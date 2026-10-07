#import "Basic";
#import "Math";

#load "module.jai";

PreSolveSmokeState :: struct {
    discrete_call_count: s32;
    point_round_trip_count: s32;
    default_push_speed: float;
    default_push_speed_valid: bool = true;
    default_damping_ratio_valid: bool = true;
    probe_shape: b3ShapeId;
    probe_continuous_count: s32;
}

smoke_pre_solve :: (shape_a: b3ShapeId, shape_b: b3ShapeId, data: *b3PreSolveData, user_data: *void) -> bool #c_call {
    push_context {
        state := cast(*PreSolveSmokeState) user_data;
        is_probe := shape_b.index1 == state.probe_shape.index1;

        if data.phase == .preSolveDiscrete {
            state.discrete_call_count += 1;
            assert(b3Contact_IsValid(data.contactId));
            contact := b3Contact_GetData(data.contactId);
            assert(contact.shapeIdA.index1 == shape_a.index1 && contact.shapeIdB.index1 == shape_b.index1);
            assert(contact.manifolds == data.manifolds && contact.manifoldCount == data.manifoldCount);

            for manifold_index: 0..data.manifoldCount - 1 {
                manifold := data.manifolds + manifold_index;
                state.default_push_speed_valid = state.default_push_speed_valid && manifold.maxPushSpeed == state.default_push_speed;
                manifold.maxPushSpeed = FLOAT32_MAX;
                state.default_damping_ratio_valid = state.default_damping_ratio_valid && manifold.contactDampingRatio == -1;
                manifold.contactDampingRatio = 1;
                if is_probe manifold.normal = .{1, 0, 0};
                for point_index: 0..manifold.pointCount - 1 {
                    point := b3PreSolve_GetPoint(data, manifold_index, point_index);
                    b3PreSolve_SetPoint(data, manifold_index, point_index, point);
                    state.point_round_trip_count += 1;
                    if is_probe {
                        manifold.points[point_index].separation = -0.01;
                        manifold.points[point_index].friction = 0;
                        manifold.points[point_index].maxNormalImpulse = 1000000;
                    }
                }
            }
        } else if is_probe {
            assert(data.manifolds == null && data.manifoldCount == 0);
            assert(b3Contact_IsValid(data.contactId));
            contact := b3Contact_GetData(data.contactId);
            assert(contact.shapeIdA.index1 == shape_a.index1 && contact.shapeIdB.index1 == shape_b.index1);
            assert(contact.manifoldCount > 0);
            assert(contact.manifolds[0].normal.x == 1 && contact.manifolds[0].maxPushSpeed == FLOAT32_MAX);
            assert(contact.manifolds[0].contactDampingRatio == 1);
            assert(contact.manifolds[0].points[0].maxNormalImpulse == 1000000);
            state.probe_continuous_count += 1;
            return false;
        }

        return true;
    }
}

main :: () {
    version := b3GetVersion();
    assert(version.major == 0 && version.minor == 3 && version.revision == 0);
    assert(!b3IsDoublePrecision());

    world_def := b3DefaultWorldDef();
    world_def.gravity = .{0, -10, 0};
    world_def.workerCount = 1;

    world := b3CreateWorld(*world_def);
    assert(b3World_IsValid(world));

    pre_solve_state: PreSolveSmokeState;
    pre_solve_state.default_push_speed = world_def.contactSpeed;
    b3World_SetPreSolveCallback(world, smoke_pre_solve, *pre_solve_state);

    ground_body_def := b3DefaultBodyDef();
    ground_body_def.position = .{0, -0.5, 0};
    ground_body := b3CreateBody(world, *ground_body_def);

    ground_shape_def := b3DefaultShapeDef();
    ground_hull := b3MakeBoxHull(10, 0.5, 10);
    ground_shape := b3CreateHullShape(ground_body, *ground_shape_def, *ground_hull.base);
    assert(b3Shape_IsValid(ground_shape));

    sphere_body_def := b3DefaultBodyDef();
    sphere_body_def.type = .dynamicBody;
    sphere_body_def.position = .{0, 4, 0};
    sphere_body := b3CreateBody(world, *sphere_body_def);

    sphere_shape_def := b3DefaultShapeDef();
    sphere_shape_def.enableContactEvents = true;
    sphere_shape_def.enablePreSolveEvents = true;
    sphere := b3Sphere.{radius = 0.5};
    sphere_shape := b3CreateSphereShape(sphere_body, *sphere_shape_def, *sphere);
    assert(b3Shape_IsValid(sphere_shape));

    began_contact := false;
    for 0..119 {
        b3World_Step(world, 1.0 / 60.0, 4);

        events := b3World_GetContactEvents(world);
        began_contact = began_contact || events.beginCount > 0;
    }

    final_position := b3Body_GetPosition(sphere_body);
    assert(began_contact, "The falling sphere never began touching the ground.\n");
    assert(pre_solve_state.discrete_call_count > 0, "The Jai pre-solve callback was never called.\n");
    assert(pre_solve_state.point_round_trip_count > 0, "The Jai pre-solve callback received no contact points.\n");
    assert(final_position.y > 0.45 && final_position.y < 0.55,
        "The falling sphere did not settle on the ground. Position: %.\n", final_position);

    sphere_body_def.position = .{2, 0.1, 0};
    recovery_body := b3CreateBody(world, *sphere_body_def);
    b3CreateSphereShape(recovery_body, *sphere_shape_def, *sphere);
    b3World_Step(world, 1.0 / 60.0, 4);
    assert(b3Body_GetPosition(recovery_body).y > 0.2,
        "The manifold push-speed override did not exceed ordinary penetration recovery.\n");
    assert(pre_solve_state.default_push_speed_valid,
        "The manifold push-speed override was not initialized from the world setting.\n");
    assert(pre_solve_state.default_damping_ratio_valid,
        "The manifold damping-ratio override was not reset to -1.\n");

    // Redirect the discrete normal so CCD still encounters the original ground surface.
    sphere_body_def.position = .{4, 0.505, 0};
    sphere_body_def.linearVelocity = .{0, -30, 0};
    probe_body := b3CreateBody(world, *sphere_body_def);
    pre_solve_state.probe_shape = b3CreateSphereShape(probe_body, *sphere_shape_def, *sphere);
    b3World_Step(world, 1.0 / 60.0, 4);
    assert(pre_solve_state.probe_continuous_count > 0,
        "CCD did not expose the current discrete contact through the Jai binding.\n");
    assert(b3Body_GetPosition(probe_body).y < 0.25);

    b3DestroyBody(probe_body);
    b3DestroyBody(recovery_body);
    b3DestroyBody(sphere_body);
    b3DestroyBody(ground_body);
    b3DestroyWorld(world);

    assert(b3GetWorldCount() == 0);
    print("JaiBox3D smoke test passed.\n");
}
