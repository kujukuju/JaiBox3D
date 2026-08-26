#import "Basic";

#load "module.jai";

PreSolveSmokeState :: struct {
    discrete_call_count: s32;
    point_round_trip_count: s32;
}

smoke_pre_solve :: (shape_a: b3ShapeId, shape_b: b3ShapeId, data: *b3PreSolveData, user_data: *void) -> bool #c_call {
    state := cast(*PreSolveSmokeState) user_data;

    if data.phase == .preSolveDiscrete {
        state.discrete_call_count += 1;

        for manifold_index: 0..data.manifoldCount - 1 {
            manifold := data.manifolds + manifold_index;
            for point_index: 0..manifold.pointCount - 1 {
                point := b3PreSolve_GetPoint(data, manifold_index, point_index);
                b3PreSolve_SetPoint(data, manifold_index, point_index, point);
                state.point_round_trip_count += 1;
            }
        }
    }

    return true;
}

main :: () {
    version := b3GetVersion();
    assert(version.major == 0 && version.minor == 2 && version.revision == 0);
    assert(!b3IsDoublePrecision());

    world_def := b3DefaultWorldDef();
    world_def.gravity = .{0, -10, 0};
    world_def.workerCount = 1;

    world := b3CreateWorld(*world_def);
    assert(b3World_IsValid(world));

    pre_solve_state: PreSolveSmokeState;
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

    b3DestroyBody(sphere_body);
    b3DestroyBody(ground_body);
    b3DestroyWorld(world);

    assert(b3GetWorldCount() == 0);
    print("JaiBox3D smoke test passed.\n");
}
