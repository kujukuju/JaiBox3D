//
// This file was auto-generated using the following command:
//
// jai generate.jai
//



NDEBUG :: 1;
B3_ENABLE_VALIDATION :: 0;

B3_NULL_INDEX :: -1;

B3_HASH_INIT :: 5381;

B3_PI :: 3.14159265359;

B3_DEG_TO_RAD :: 0.01745329251;

B3_RAD_TO_DEG :: 57.2957795131;

B3_MIN_SCALE :: 0.01;

B3_MAX_WORKERS :: 32;

B3_MAX_TASKS :: 256;

B3_GRAPH_COLOR_COUNT :: 24;

B3_CONTACT_MANIFOLD_COUNT_BUCKETS :: 8;

B3_MIN_FRICTION_WEIGHT :: 1.0e-10;

B3_MAX_WORLDS :: 128;

B3_MAX_ROTATION :: 0.25 * B3_PI;

B3_CONTACT_RECYCLE_ANGULAR_DISTANCE :: 0.99240388;

B3_AABB_MARGIN_FRACTION :: 0.125;

B3_TIME_TO_SLEEP :: 0.5;

B3_MAX_MANIFOLD_POINTS :: 4;

B3_GYROSCOPIC_ITERATIONS :: 1;

B3_MAX_HULL_VERTICES :: 128;

B3_MAX_HULL_FACES :: 128;

B3_MAX_HULL_EDGES :: 128;

B3_PARALLEL_EDGE_TOL :: 0.005;

B3_MAX_SHAPE_CAST_POINTS :: B3_MAX_HULL_VERTICES;

B3_SHAPE_POWER :: 22;
B3_CHILD_POWER :: 64 - 2 * B3_SHAPE_POWER;
B3_MAX_SHAPES :: 1 << B3_SHAPE_POWER;
B3_MAX_CHILD_SHAPES :: 1 << B3_CHILD_POWER;

B3_RESTITUTION_ITERATIONS :: 1;

B3_DYNAMIC_TREE_VERSION :: 0x93EDAF889FD30B4A;

B3_HULL_VERSION :: 0x4A4C9587DE57485C;

B3_MESH_VERSION :: 0xAAAB9A00F1A8AAF7;

B3_HEIGHT_FIELD_HOLE :: 0xFF;

B3_HEIGHT_FIELD_VERSION :: 0x8E41E5FB084848F8;

B3_COMPOUND_VERSION :: 0xB11DCE70FAD5622B ^ B3_DYNAMIC_TREE_VERSION ^ B3_MESH_VERSION ^ B3_HULL_VERSION;

B3_MAX_COMPOUND_MESH_MATERIALS :: 4;

/// Prototype for user allocation function.
///	@param size the allocation size in bytes
///	@param alignment the required alignment, guaranteed to be a power of 2
b3AllocFcn :: #type (size: s32, alignment: s32) -> *void #c_call;

/// Prototype for user free function.
///	@param mem the memory previously allocated through `b3AllocFcn`
b3FreeFcn :: #type (mem: *void) -> void #c_call;

/// Prototype for the user assert callback. Return 0 to skip the debugger break.
b3AssertFcn :: #type (condition: *u8, fileName: *u8, lineNumber: s32) -> s32 #c_call;

/// Prototype for user log callback. Used to log warnings.
b3LogFcn :: #type (message: *u8) -> void #c_call;

/// This allows the user to override the allocation functions. These should be
///	set during application startup.
b3SetAllocator :: (allocFcn: b3AllocFcn, freeFcn: b3FreeFcn) -> void #foreign box3d;

/// Total bytes allocated by Box3D
b3GetByteCount :: () -> s32 #foreign box3d;

/// Override the default assert callback.
///	@param assertFcn a non-null assert callback
b3SetAssertFcn :: (assertFcn: b3AssertFcn) -> void #foreign box3d;

/// Override the default logging callback.
b3SetLogFcn :: (logFcn: b3LogFcn) -> void #foreign box3d;

/// Version numbering scheme.
/// See https://semver.org/
b3Version :: struct {
    /// Significant changes
    major:    s32;

    /// Incremental changes
    minor:    s32;

    /// Bug fixes
    revision: s32;
}

/// Get the current version of Box3D
b3GetVersion :: () -> b3Version #foreign box3d;

/// @return true if the library was built with BOX3D_DOUBLE_PRECISION (large world mode)
b3IsDoublePrecision :: () -> bool #foreign box3d;

/// Get the absolute number of system ticks. The value is platform specific.
b3GetTicks :: () -> u64 #foreign box3d;

/// Get the milliseconds passed from an initial tick value.
b3GetMilliseconds :: (ticks: u64) -> float #foreign box3d;

/// Get the milliseconds passed from an initial tick value.
b3GetMillisecondsAndReset :: (ticks: *u64) -> float #foreign box3d;

/// Yield to be used in a busy loop.
b3Yield :: () -> void #foreign box3d;

/// Sleep the current thread for a number of milliseconds.
b3Sleep :: (milliseconds: s32) -> void #foreign box3d;

b3Hash :: (hash: u32, data: *u8, count: s32) -> u32 #foreign box3d;

/// A 2D vector.
b3Vec2 :: struct {
    x: float;
    y: float;
}

/// A 3D vector.
b3Vec3 :: struct {
    x: float;
    y: float;
    z: float;
}

/// Cosine and sine pair.
/// This uses a custom implementation designed for cross-platform determinism.
b3CosSin :: struct {
    /// cosine and sine
    cosine: float;
    sine:   float;
}

/// A quaternion.
b3Quat :: struct {
    v: b3Vec3;
    s: float;
}

/// A rigid transform.
b3Transform :: struct {
    p: b3Vec3;
    q: b3Quat;
}

/// In single precision mode these types are the same.
b3Pos :: b3Vec3;

/// In single precision mode these types are the same.
b3WorldTransform :: b3Transform;

/// A 3x3 matrix.
b3Matrix3 :: struct {
    cx: b3Vec3;
    cy: b3Vec3;
    cz: b3Vec3;
}

/// Axis aligned bounding box.
b3AABB :: struct {
    lowerBound: b3Vec3;
    upperBound: b3Vec3;
}

/// A plane.
/// separation = dot(normal, point) - offset
b3Plane :: struct {
    normal: b3Vec3;
    offset: float;
}

/// Compute an approximate arctangent in the range [-pi, pi]
/// This is hand coded for cross-platform determinism. The atan2f
/// function in the standard library is not cross-platform deterministic.
///	Accurate to around 0.0023 degrees.
b3Atan2 :: (y: float, x: float) -> float #foreign box3d;

/// Compute the cosine and sine of an angle in radians. Implemented
/// for cross-platform determinism.
b3ComputeCosSin :: (radians: float) -> b3CosSin #foreign box3d;

/// Extract a quaternion from a rotation matrix.
b3MakeQuatFromMatrix :: (m: *b3Matrix3) -> b3Quat #foreign box3d;

/// Find a quaternion that rotates one vector to another.
b3ComputeQuatBetweenUnitVectors :: (v1: b3Vec3, v2: b3Vec3) -> b3Quat #foreign box3d;

/// Get the inertia tensor of an offset point.
/// https://en.wikipedia.org/wiki/Parallel_axis_theorem
b3Steiner :: (mass: float, origin: b3Vec3) -> b3Matrix3 #foreign box3d;

/// The closest points between to segments or infinite lines.
b3SegmentDistanceResult :: struct {
    point1:    b3Vec3;
    fraction1: float;
    point2:    b3Vec3;
    fraction2: float;
}

/// Compute the closest point on the segment a-b to the target q.
b3PointToSegmentDistance :: (a: b3Vec3, b: b3Vec3, q: b3Vec3) -> b3Vec3 #foreign box3d;

/// Compute the closest points on two infinite lines.
b3LineDistance :: (p1: b3Vec3, d1: b3Vec3, p2: b3Vec3, d2: b3Vec3) -> b3SegmentDistanceResult #foreign box3d;

/// Compute the closest points on two line segments.
b3SegmentDistance :: (p1: b3Vec3, q1: b3Vec3, p2: b3Vec3, q2: b3Vec3) -> b3SegmentDistanceResult #foreign box3d;

/// Is this a valid number? Not NaN or infinity.
b3IsValidFloat :: (a: float) -> bool #foreign box3d;

/// Is this a valid vector? Not NaN or infinity.
b3IsValidVec3 :: (a: b3Vec3) -> bool #foreign box3d;

/// Is this a valid quaternion? Not NaN or infinity. Is normalized.
b3IsValidQuat :: (q: b3Quat) -> bool #foreign box3d;

/// Is this a valid transform? Not NaN or infinity. Is normalized.
b3IsValidTransform :: (a: b3Transform) -> bool #foreign box3d;

/// Is this a valid matrix? Not NaN or infinity.
b3IsValidMatrix3 :: (a: b3Matrix3) -> bool #foreign box3d;

/// Is this a valid bounding box? Not Nan or infinity. Upper bound greater than or equal to lower bound.
b3IsValidAABB :: (a: b3AABB) -> bool #foreign box3d;

/// Is this AABB reasonably close to the origin? See B3_HUGE.
b3IsBoundedAABB :: (a: b3AABB) -> bool #foreign box3d;

/// Is this AABB valid and reasonable?
b3IsSaneAABB :: (a: b3AABB) -> bool #foreign box3d;

/// Is this a valid plane? Normal is a unit vector. Not Nan or infinity.
b3IsValidPlane :: (a: b3Plane) -> bool #foreign box3d;

/// Is this a valid world position? Not NaN or infinity.
b3IsValidPosition :: (p: b3Pos) -> bool #foreign box3d;

/// Is this a valid world transform? Not NaN or infinity. Rotation is normalized.
b3IsValidWorldTransform :: (t: b3WorldTransform) -> bool #foreign box3d;

/// Box3D bases all length units on meters, but you may need different units for your game.
/// You can set this value to use different units. This should be done at application startup
/// and only modified once. Default value is 1.
/// @warning This must be modified before any calls to Box3D
b3SetLengthUnitsPerMeter :: (lengthUnits: float) -> void #foreign box3d;

/// Get the current length units per meter.
b3GetLengthUnitsPerMeter :: () -> float #foreign box3d;

/// Set the threshold for logging stalls.
b3SetStallThreshold :: (seconds: float) -> void #foreign box3d;

/// Get the threshold for logging stalls.
b3GetStallThreshold :: () -> float #foreign box3d;

/// World id references a world instance. This should be treated as an opaque handle.
b3WorldId :: struct {
    index1:     u16;
    generation: u16;
}

/// Body id references a body instance. This should be treated as an opaque handle.
b3BodyId :: struct {
    index1:     s32;
    world0:     u16;
    generation: u16;
}

/// Shape id references a shape instance. This should be treated as an opaque handle.
b3ShapeId :: struct {
    index1:     s32;
    world0:     u16;
    generation: u16;
}

/// Joint id references a joint instance. This should be treated as an opaque handle.
b3JointId :: struct {
    index1:     s32;
    world0:     u16;
    generation: u16;
}

/// Contact id references a contact instance. This should be treated as an opaque handle.
b3ContactId :: struct {
    index1:     s32;
    world0:     u16;
    padding:    s16;
    generation: u32;
}

/// Task interface
/// This is the prototype for a Box3D task. Your task system is expected to run this callback on a worker thread,
/// exactly once per enqueue, passing back the same taskContext pointer supplied to b3EnqueueTaskCallback.
/// @ingroup world
b3TaskCallback :: #type (taskContext: *void) -> void #c_call;

/// These functions can be provided to Box3D to invoke a task system.
/// Returns a pointer to the user's task object. May be nullptr. A nullptr indicates to Box3D that the work was executed
/// serially within the callback and there is no need to call b3FinishTaskCallback. Otherwise the returned
/// value must be non-null will be passed to b3FinishTaskCallback as the userTask.
/// @param task the Box3D task to be called by the scheduler
/// @param taskContext the Box3D context object that the scheduler must pass to the task
/// @param userContext the scheduler context object that is opaque to Box3D
/// @param taskName the Box3D task name that the scheduler can use for diagnostics
/// @ingroup world
b3EnqueueTaskCallback :: #type (task: b3TaskCallback, taskContext: *void, userContext: *void, taskName: *u8) -> *void #c_call;

/// Finishes a user task object that wraps a Box3D task. This must block until the task has completed.
/// The step blocks here on the tasks it spawned, so b3World_Step holds its stack across every
/// fork/join. Drive it from a thread you can dedicate to the step, or from a fiber this callback can
/// park to free the underlying thread. In a job system that cannot park a job's stack, do not call
/// b3World_Step from inside a job: a job that blocks on its own sub-jobs without yielding its thread
/// can deadlock. The in-tree scheduler instead runs other pending tasks on the waiting thread.
/// @ingroup world
b3FinishTaskCallback :: #type (userTask: *void, userContext: *void) -> void #c_call;

/// The user needs to be able to create debug draw shapes for multi-pass rendering to work efficiently.
/// These user shapes are created and destroyed via callback so they can be bound to shape lifetime and scaling updates.
/// @ingroup debug_draw
b3CreateDebugShapeCallback :: #type (debugShape: *b3DebugShape, userContext: *void) -> *void #c_call;
b3DestroyDebugShapeCallback :: #type (userShape: *void, userContext: *void) -> void #c_call;

/// Optional friction mixing callback. This intentionally provides no context objects because this is called
/// from a worker thread.
/// @warning This function should not attempt to modify Box3D state or user application state.
/// @ingroup world
b3FrictionCallback :: #type (frictionA: float, userMaterialIdA: u64, frictionB: float, userMaterialIdB: u64) -> float #c_call;

/// Optional restitution mixing callback. This intentionally provides no context objects because this is called
/// from a worker thread.
/// @warning This function should not attempt to modify Box3D state or user application state.
/// @ingroup world
b3RestitutionCallback :: #type (restitutionA: float, userMaterialIdA: u64, restitutionB: float, userMaterialIdB: u64) -> float #c_call;

/// Prototype for a contact filter callback.
/// This is called when a contact pair is considered for collision. This allows you to
/// perform custom logic to prevent collision between shapes. This is only called if
/// one of the two shapes has custom filtering enabled. @see b3ShapeDef.
/// Notes:
/// - this function must be thread-safe
/// - this is only called if one of the two shapes has enabled custom filtering
/// - this is called only for awake dynamic bodies
/// Return false if you want to disable the collision
/// @warning Do not attempt to modify the world inside this callback
/// @ingroup world
b3CustomFilterFcn :: #type (shapeIdA: b3ShapeId, shapeIdB: b3ShapeId, _context: *void) -> bool #c_call;

/// Identifies the stage that invoked a pre-solve callback.
b3PreSolvePhase :: enum u32 {
    preSolveDiscrete   :: 0;

    preSolveContinuous :: 1;

    b3_preSolveDiscrete   :: preSolveDiscrete;

    b3_preSolveContinuous :: preSolveContinuous;
}

/// Transient pre-solve data owned by Box3D.
/// The data and borrowed manifold array are valid only for the duration of the callback and must not be retained.
b3PreSolveData :: struct {
    /// The stage that invoked the callback.
    phase:          b3PreSolvePhase;

    /// Borrowed mutable manifolds for discrete contacts. Null during continuous collision.
    /// Do not replace this pointer or retain it after the callback returns.
    manifolds:      *b3Manifold;

    /// Number of mutable manifolds. Zero during continuous collision.
    /// This value and each manifold point count are read-only.
    manifoldCount:  s32;

    /// Body center of mass for shape A. Valid for discrete contacts.
    centerA:        b3Pos;

    /// Body center of mass for shape B. Valid for discrete contacts.
    centerB:        b3Pos;

    /// Participating baked-compound child for shape A, or B3_NULL_INDEX.
    childIndexA:    s32;

    /// Participating baked-compound child for shape B, or B3_NULL_INDEX.
    childIndexB:    s32;

    /// Continuous collision candidate point. Read-only and valid only during continuous collision.
    point:          b3Pos;

    /// Continuous collision candidate normal. Read-only and valid only during continuous collision.
    normal:         b3Vec3;

    /// Continuous collision candidate fraction. Read-only and valid only during continuous collision.
    fraction:       float;

    /// Continuous mesh or height-field triangle for shape A, or B3_NULL_INDEX.
    triangleIndexA: s32;

    /// Continuous mesh or height-field triangle for shape B, or B3_NULL_INDEX.
    triangleIndexB: s32;
}

/// Prototype for a pre-solve callback.
/// This is called for awake solid contacts when either shape has enabled pre-solve events.
/// A discrete callback is invoked once per updated contact in the contact's authoritative shape A/B order.
/// It may modify b3Manifold::normal and the documented mutable fields in b3ManifoldPoint. Use b3PreSolve_SetPoint
/// to move a point. Set b3ManifoldPoint::enabled to false to remove a point for the current step. If all points are
/// disabled, the contact is disabled for the step. Do not modify manifold pointers, manifold counts, or point counts.
/// During continuous collision there is no solver manifold and all data fields are read-only; only returning false to reject
/// the candidate has an effect.
/// Notes:
/// - this function must be thread-safe
/// - this is only called if one of the shapes has enabled pre-solve events
/// - this is not called for sensors
/// - the data and manifold pointers become invalid when the callback returns
/// Return false to disable a discrete contact for the step or reject a continuous collision candidate.
/// @warning Do not attempt to modify the world inside this callback
/// @ingroup world
b3PreSolveFcn :: #type (shapeIdA: b3ShapeId, shapeIdB: b3ShapeId, data: *b3PreSolveData, _context: *void) -> bool #c_call;

/// Prototype callback for overlap queries.
/// Called for each shape found in the query.
/// @see b3World_OverlapAABB
/// @return false to terminate the query.
/// @ingroup world
b3OverlapResultFcn :: #type (shapeId: b3ShapeId, _context: *void) -> bool #c_call;

/// Prototype callback for ray casts.
/// Called for each shape found in the query. You control how the ray cast
/// proceeds by returning a float:
/// return -1: ignore this shape and continue
/// return 0: terminate the ray cast
/// return fraction: clip the ray to this point
/// return 1: don't clip the ray and continue
/// @param shapeId the shape hit by the ray
/// @param point the point of initial intersection
/// @param normal the normal vector at the point of intersection
/// @param fraction the fraction along the ray at the point of intersection
/// @param userMaterialId the shape or triangle surface type
/// @param triangleIndex the triangle index for mesh or height field shapes or -1 for other shape types
/// @param childIndex the child shape index for compound shapes
/// @param context the user context
/// @return -1 to filter, 0 to terminate, fraction to clip the ray for closest hit, 1 to continue
/// @see b3World_CastRay
/// @ingroup world
b3CastResultFcn :: #type (shapeId: b3ShapeId, point: b3Pos, normal: b3Vec3, fraction: float, userMaterialId: u64, triangleIndex: s32, childIndex: s32, _context: *void) -> float #c_call;

/// Optional world capacities that can be use to avoid run-time allocations
/// @ingroup world
b3Capacity :: struct {
    /// Number of expected static shapes.
    staticShapeCount:  s32;

    /// Number of expected dynamic and kinematic shapes.
    dynamicShapeCount: s32;

    /// Number of expected static bodies.
    staticBodyCount:   s32;

    /// Number of expected dynamic and kinematic bodies.
    dynamicBodyCount:  s32;

    /// Number of expected contacts.
    contactCount:      s32;
}

/// World definition used to create a simulation world. Must be initialized using b3DefaultWorldDef.
/// @ingroup world
b3WorldDef :: struct {
    /// Gravity vector. Box3D has no up-vector defined.
    gravity:               b3Vec3;

    /// Restitution speed threshold, usually in m/s. Collisions above this
    /// speed have restitution applied (will bounce).
    restitutionThreshold:  float;

    /// Hit event speed threshold, usually in m/s. Collisions above this
    /// speed can generate hit events if the shape also enables hit events.
    hitEventThreshold:     float;

    /// Contact stiffness. Cycles per second. Increasing this increases the speed of overlap recovery, but can introduce jitter.
    contactHertz:          float;

    /// Contact bounciness. Non-dimensional. You can speed up overlap recovery by decreasing this with
    /// the trade-off that overlap resolution becomes more energetic.
    contactDampingRatio:   float;

    /// This parameter controls how fast overlap is resolved and usually has units of meters per second. This only
    /// puts a cap on the resolution speed. The resolution speed is increased by increasing the hertz and/or
    /// decreasing the damping ratio.
    contactSpeed:          float;

    /// Maximum linear speed. Usually meters per second.
    maximumLinearSpeed:    float;

    /// Optional mixing callback for friction. The default uses sqrt(frictionA * frictionB).
    frictionCallback:      b3FrictionCallback;

    /// Optional mixing callback for restitution. The default uses max(restitutionA, restitutionB).
    restitutionCallback:   b3RestitutionCallback;

    /// Can bodies go to sleep to improve performance
    enableSleep:           bool;

    /// Enable continuous collision
    enableContinuous:      bool;

    /// Number of workers to use with the provided task system. Box3D performs best when using only
    /// performance cores and accessing a single L2 cache. Efficiency cores and hyper-threading provide
    /// little benefit and may even harm performance.
    /// This is clamped to the range [1, B3_MAX_WORKERS]. Using a value above 1 will turn on multithreading.
    /// If task callbacks are provided then Box3D will use the user provided task system. Otherwise Box3D
    /// will create threads and use an internal scheduler.
    workerCount:           u32;

    /// function to spawn task
    enqueueTask:           b3EnqueueTaskCallback;

    /// function to finish a task
    finishTask:            b3FinishTaskCallback;

    /// User context that is provided to enqueueTask and finishTask
    userTaskContext:       *void;

    /// User data associated with a world
    userData:              *void;

    /// Used to create debug draw shapes. This is called when a shape is
    /// first drawn using b3DebugDraw.
    createDebugShape:      b3CreateDebugShapeCallback;

    /// Used to destroy debug draw shapes. This is called when a shape is modified or destroyed.
    destroyDebugShape:     b3DestroyDebugShapeCallback;

    /// This is passed to the debug shape callbacks to provide a user context.
    userDebugShapeContext: *void;

    /// Optional initial capacities
    capacity:              b3Capacity;

    /// Used internally to detect a valid definition. DO NOT SET.
    internalValue:         s32;
}

/// Use this to initialize your world definition
/// @ingroup world
b3DefaultWorldDef :: () -> b3WorldDef #foreign box3d;

/// The body simulation type.
/// Each body is one of these three types. The type determines how the body behaves in the simulation.
/// @ingroup body
b3BodyType :: enum u32 {
    staticBody    :: 0;

    kinematicBody :: 1;

    dynamicBody   :: 2;

    bodyTypeCount :: 3;

    b3_staticBody    :: staticBody;

    b3_kinematicBody :: kinematicBody;

    b3_dynamicBody   :: dynamicBody;

    b3_bodyTypeCount :: bodyTypeCount;
}

/// Motion locks to restrict the body movement
/// @ingroup body
b3MotionLocks :: struct {
    /// Prevent translation along the x-axis
    linearX:  bool;

    /// Prevent translation along the y-axis
    linearY:  bool;

    /// Prevent translation along the z-axis
    linearZ:  bool;

    /// Prevent rotation around the x-axis
    angularX: bool;

    /// Prevent rotation around the y-axis
    angularY: bool;

    /// Prevent rotation around the z-axis
    angularZ: bool;
}

/// A body definition holds all the data needed to construct a rigid body.
/// You can safely re-use body definitions. Shapes are added to a body after construction.
/// Body definitions are temporary objects used to bundle creation parameters.
/// Must be initialized using b3DefaultBodyDef().
/// @ingroup body
b3BodyDef :: struct {
    /// The body type: static, kinematic, or dynamic.
    type:                   b3BodyType;

    /// The initial world position of the body. Bodies should be created with the desired position.
    /// @note Creating bodies at the origin and then moving them nearly doubles the cost of body creation, especially
    /// if the body is moved after shapes have been added.
    position:               b3Pos;

    /// The initial world rotation of the body.
    rotation:               b3Quat;

    /// The initial linear velocity of the body's origin. Usually in meters per second.
    linearVelocity:         b3Vec3;

    /// The initial angular velocity of the body. Radians per second.
    angularVelocity:        b3Vec3;

    /// Linear damping is used to reduce the linear velocity. The damping parameter
    /// can be larger than 1 but the damping effect becomes sensitive to the
    /// time step when the damping parameter is large.
    /// Generally linear damping is undesirable because it makes objects move slowly
    /// as if they are floating.
    linearDamping:          float;

    /// Angular damping is used to reduce the angular velocity. The damping parameter
    /// can be larger than 1.0f but the damping effect becomes sensitive to the
    /// time step when the damping parameter is large.
    /// Angular damping can be used to slow down rotating bodies.
    angularDamping:         float;

    /// Scale the gravity applied to this body. Non-dimensional.
    gravityScale:           float;

    /// Sleep speed threshold, default is 0.05 meters per second
    sleepThreshold:         float;

    /// Optional body name for debugging.
    name:                   *u8;

    /// Use this to store application specific body data.
    userData:               *void;

    /// Motions locks to restrict linear and angular movement
    motionLocks:            b3MotionLocks;

    /// Set this flag to false if this body should never fall asleep.
    enableSleep:            bool;

    /// Is this body initially awake or sleeping?
    isAwake:                bool;

    /// Treat this body as a high speed object that performs continuous collision detection
    /// against dynamic and kinematic bodies, but not other bullet bodies.
    /// @warning Bullets should be used sparingly. They are not a solution for general dynamic-versus-dynamic
    /// continuous collision. They do not guarantee accurate collision if both bodies are fast moving because
    /// the bullet does a continuous check after all non-bullet bodies have moved. You could get unlucky and have
    /// the bullet body end a time step very close to a non-bullet body and the non-bullet body then moves over
    /// the bullet body. In continuous collision, initial overlap is ignored to avoid freezing bodies in place.
    /// I do not recommend using them for game projectiles if precise collision timing is needed. Instead consider
    /// using a ray or shape cast. You can use a marching ray or shape cast for projectile that moves over time.
    /// If you want a fast moving projectile to collide with a fast moving target, you need to consider the relative
    /// movement in your ray or shape cast. This is out of the scope of Box3D.
    /// So what are good use cases for bullets? Pinball games or games with dynamic containers that hold other objects.
    /// It should be a use case where it doesn't break the game if there is a collision missed, but having them
    /// captured improves the quality of the game.
    isBullet:               bool;

    /// Used to disable a body. A disabled body does not move or collide.
    isEnabled:              bool;

    /// This allows this body to bypass rotational speed limits. Should only be used
    /// for circular objects, like wheels.
    allowFastRotation:      bool;

    /// Enable contact recycling. True by default. Leaving this enabled improves performance
    /// but may lead to ghost collision that should be avoided on characters.
    enableContactRecycling: bool;

    /// Used internally to detect a valid definition. DO NOT SET.
    internalValue:          s32;
}

/// Use this to initialize your body definition
/// @ingroup body
b3DefaultBodyDef :: () -> b3BodyDef #foreign box3d;

/// This is used to filter collision on shapes. It affects shape-vs-shape collision
/// and shape-versus-query collision (such as b3World_CastRay).
/// @ingroup shape
b3Filter :: struct {
    /// The collision category bits. Normally you would just set one bit. The category bits should
    /// represent your application object types. For example:
    /// @code{.cpp}
    /// enum MyCategories
    /// {
    ///    Static  = 0x00000001,
    ///    Dynamic = 0x00000002,
    ///    Debris  = 0x00000004,
    ///    Player  = 0x00000008,
    ///    // etc
    /// };
    /// @endcode
    categoryBits: u64;

    /// The collision mask bits. This states the categories that this
    /// shape would accept for collision.
    /// For example, you may want your player to only collide with static objects
    /// and other players.
    /// @code{.c}
    /// maskBits = Static | Player;
    /// @endcode
    maskBits:     u64;

    /// Collision groups allow a certain group of objects to never collide (negative)
    /// or always collide (positive). A group index of zero has no effect. Non-zero group filtering
    /// always wins against the mask bits.
    /// For example, you may want ragdolls to collide with other ragdolls but you don't want
    /// ragdoll self-collision. In this case you would give each ragdoll a unique negative group index
    /// and apply that group index to all shapes on the ragdoll.
    groupIndex:   s32;
}

/// Use this to initialize your filter
/// @ingroup shape
b3DefaultFilter :: () -> b3Filter #foreign box3d;

/// Material properties supported per triangle on meshes and height fields
/// @ingroup shape
b3SurfaceMaterial :: struct {
    /// The Coulomb (dry) friction coefficient, usually in the range [0,1].
    friction:          float;

    /// The coefficient of restitution (bounce) usually in the range [0,1].
    /// https://en.wikipedia.org/wiki/Coefficient_of_restitution
    restitution:       float;

    /// The rolling resistance usually in the range [0,1]. This is only used for spheres and capsules.
    rollingResistance: float;

    /// The tangent velocity for conveyor belts. This is local to the shape and will be projected
    /// onto the contact surface.
    tangentVelocity:   b3Vec3;

    /// User material identifier. This is passed with query results and to friction and restitution
    /// combining functions. It is not used internally.
    userMaterialId:    u64;

    /// Custom debug draw color. Ignored if 0. The low 24 bits are RGB. The high byte may
    /// carry a b3DebugMaterial preset, see b3MakeDebugColor.
    /// @see b3HexColor
    customColor:       u32;

    /// Explicit padding. Must be zero.
    padding:           u32;
}

/// Use this to initialize your surface material
/// @ingroup shape
b3DefaultSurfaceMaterial :: () -> b3SurfaceMaterial #foreign box3d;

/// Shape type
/// @ingroup shape
b3ShapeType :: enum u32 {
    capsuleShape   :: 0;

    compoundShape  :: 1;

    heightShape    :: 2;

    hullShape      :: 3;

    meshShape      :: 4;

    sphereShape    :: 5;

    shapeTypeCount :: 6;

    b3_capsuleShape   :: capsuleShape;

    b3_compoundShape  :: compoundShape;

    b3_heightShape    :: heightShape;

    b3_hullShape      :: hullShape;

    b3_meshShape      :: meshShape;

    b3_sphereShape    :: sphereShape;

    b3_shapeTypeCount :: shapeTypeCount;
}

/// Used to create a shape
/// @ingroup shape
b3ShapeDef :: struct {
    /// Optional shape name for debugging
    name:                     *u8;

    /// Use this to store application specific shape data.
    userData:                 *void;

    /// Surface material used on mesh shapes per triangle. Ignored for convex shapes. Ignored for compound shapes.
    materials:                *b3SurfaceMaterial;

    /// Surface material count.
    materialCount:            s32;

    /// The base surface material. Ignored for compound shapes.
    baseMaterial:             b3SurfaceMaterial;

    /// The density, usually in kg/m^3.
    density:                  float;

    /// Explosion scale for b3World_Explode. non-dimensional
    explosionScale:           float;

    /// Contact filtering data.
    filter:                   b3Filter;

    /// Enable custom filtering. Only one of the two shapes needs to enable custom filtering. See b3WorldDef.
    enableCustomFiltering:    bool;

    /// A sensor shape generates overlap events but never generates a collision response.
    /// Sensors do not have continuous collision. Instead, use a ray or shape cast for those scenarios.
    /// Sensors still contribute to the body mass if they have non-zero density.
    /// @note Sensor events are disabled by default.
    /// @see enableSensorEvents
    isSensor:                 bool;

    /// Enable sensor events for this shape. This applies to sensors and non-sensors. False by default, even for sensors.
    /// Only convex shapes may act as sensor visitors.
    enableSensorEvents:       bool;

    /// Enable contact events for this shape. Only applies to kinematic and dynamic bodies. Ignored for sensors. False by default.
    enableContactEvents:      bool;

    /// Enable hit events for this shape. Only applies to kinematic and dynamic bodies. Ignored for sensors. False by default.
    enableHitEvents:          bool;

    /// Enable pre-solve contact events for this shape. Only applies to dynamic bodies. These are expensive
    ///	and must be carefully handled due to multithreading. Ignored for sensors.
    enablePreSolveEvents:     bool;

    /// When shapes are created they will scan the environment for collision the next time step. This can significantly slow down
    /// static body creation when there are many static shapes.
    /// This is flag is ignored for dynamic and kinematic shapes which always invoke contact creation.
    invokeContactCreation:    bool;

    /// Should the body update the mass properties when this shape is created. Default is true.
    /// Warning: if this is false, you MUST call b3Body_ApplyMassFromShapes or b3Body_SetMassData before simulating the world.
    updateBodyMass:           bool;

    /// Enable speculative collision. Leave this true unless you care about reducing ghost collision
    /// more than continuous collision under rotation.
    /// Experimental: this can only disable speculative contact between hulls and triangles (meshes and height fields).
    enableSpeculativeContact: bool;

    /// Used internally to detect a valid definition. DO NOT SET.
    internalValue:            s32;
}

/// Use this to initialize your shape definition
/// @ingroup shape
b3DefaultShapeDef :: () -> b3ShapeDef #foreign box3d;

//! @cond
/// Profiling data. Times are in milliseconds.
/// @ingroup world
b3Profile :: struct {
    step:                float;
    pairs:               float;
    collide:             float;
    solve:               float;
    solverSetup:         float;
    constraints:         float;
    prepareConstraints:  float;
    integrateVelocities: float;
    warmStart:           float;
    solveImpulses:       float;
    integratePositions:  float;
    relaxImpulses:       float;
    applyRestitution:    float;
    storeImpulses:       float;
    splitIslands:        float;
    transforms:          float;
    sensorHits:          float;
    jointEvents:         float;
    hitEvents:           float;
    refit:               float;
    bullets:             float;
    sleepIslands:        float;
    sensors:             float;
}

/// Counters that give details of the simulation size.
/// @ingroup world
b3Counters :: struct {
    bodyCount:            s32;
    shapeCount:           s32;
    contactCount:         s32;
    jointCount:           s32;
    islandCount:          s32;
    stackUsed:            s32;
    arenaCapacity:        s32;
    staticTreeHeight:     s32;
    treeHeight:           s32;
    satCallCount:         s32;
    satCacheHitCount:     s32;
    byteCount:            s32;
    taskCount:            s32;
    colorCounts:          [24] s32;
    manifoldCounts:       [8] s32;

    /// Number of contacts touched by the collide pass
    /// graph contacts + awake-set non-touching
    awakeContactCount:    s32;

    /// Number of contacts recycled in the most recent step.
    recycledContactCount: s32;

    /// Maximum number of time of impact iterations
    distanceIterations:   s32;
    pushBackIterations:   s32;
    rootIterations:       s32;
}

/// Joint type enumeration. This is useful because all joint types use b3JointId and sometimes you
/// want to get the type of a joint.
/// @ingroup joint
b3JointType :: enum u32 {
    parallelJoint  :: 0;
    distanceJoint  :: 1;
    filterJoint    :: 2;
    motorJoint     :: 3;
    prismaticJoint :: 4;
    revoluteJoint  :: 5;
    sphericalJoint :: 6;
    weldJoint      :: 7;
    wheelJoint     :: 8;

    b3_parallelJoint  :: parallelJoint;
    b3_distanceJoint  :: distanceJoint;
    b3_filterJoint    :: filterJoint;
    b3_motorJoint     :: motorJoint;
    b3_prismaticJoint :: prismaticJoint;
    b3_revoluteJoint  :: revoluteJoint;
    b3_sphericalJoint :: sphericalJoint;
    b3_weldJoint      :: weldJoint;
    b3_wheelJoint     :: wheelJoint;
}

/// Base joint definition used by all joint types. The local frames are measured from the
/// body's origin rather than the center of mass because:
/// 1. You might not know where the center of mass will be.
/// 2. If you add/remove shapes from a body and recompute the mass, the joints will be broken.
/// @ingroup joint
b3JointDef :: struct {
    /// User data pointer
    userData:               *void;

    /// The first attached body
    bodyIdA:                b3BodyId;

    /// The second attached body
    bodyIdB:                b3BodyId;

    /// The first local joint frame
    localFrameA:            b3Transform;

    /// The second local joint frame
    localFrameB:            b3Transform;

    /// Force threshold for joint events
    forceThreshold:         float;

    /// Torque threshold for joint events
    torqueThreshold:        float;

    /// Constraint hertz (advanced feature)
    constraintHertz:        float;

    /// Constraint damping ratio (advanced feature)
    constraintDampingRatio: float;

    /// Debug draw scale
    drawScale:              float;

    /// Set this flag to true if the attached bodies should collide
    collideConnected:       bool;

    /// Used internally to detect a valid definition. DO NOT SET.
    internalValue:          s32;
}

/// Distance joint definition.
/// Connects a point on body A with a point on body B by a segment.
/// Useful for ropes and springs.
/// @ingroup distance_joint
b3DistanceJointDef :: struct {
    /// Base joint definition
    base:             b3JointDef;

    /// The rest length of this joint. Clamped to a stable minimum value.
    length:           float;

    /// Enable the distance constraint to behave like a spring. If false
    /// then the distance joint will be rigid, overriding the limit and motor.
    enableSpring:     bool;

    /// The lower spring force controls how much tension it can sustain
    lowerSpringForce: float;

    /// The upper spring force controls how much compression it can sustain
    upperSpringForce: float;

    /// The spring linear stiffness Hertz, cycles per second
    hertz:            float;

    /// The spring linear damping ratio, non-dimensional
    dampingRatio:     float;

    /// Enable/disable the joint limit
    enableLimit:      bool;

    /// Minimum length. Clamped to a stable minimum value.
    minLength:        float;

    /// Maximum length. Must be greater than or equal to the minimum length.
    maxLength:        float;

    /// Enable/disable the joint motor
    enableMotor:      bool;

    /// The maximum motor force, usually in newtons
    maxMotorForce:    float;

    /// The desired motor speed, usually in meters per second
    motorSpeed:       float;
}

/// Use this to initialize your joint definition
/// @ingroup distance_joint
b3DefaultDistanceJointDef :: () -> b3DistanceJointDef #foreign box3d;

/// A motor joint is used to control the relative position and velocity between two bodies.
/// @ingroup motor_joint
b3MotorJointDef :: struct {
    /// Base joint definition
    base:                b3JointDef;

    /// The desired linear velocity
    linearVelocity:      b3Vec3;

    /// The maximum motor force in newtons
    maxVelocityForce:    float;

    /// The desired angular velocity
    angularVelocity:     b3Vec3;

    /// The maximum motor torque in newton-meters
    maxVelocityTorque:   float;

    /// Linear spring hertz for position control
    linearHertz:         float;

    /// Linear spring damping ratio
    linearDampingRatio:  float;

    /// Maximum spring force in newtons
    maxSpringForce:      float;

    /// Angular spring hertz for position control
    angularHertz:        float;

    /// Angular spring damping ratio
    angularDampingRatio: float;

    /// Maximum spring torque in newton-meters
    maxSpringTorque:     float;
}

/// Use this to initialize your joint definition
/// @ingroup motor_joint
b3DefaultMotorJointDef :: () -> b3MotorJointDef #foreign box3d;

/// A filter joint is used to disable collision between two specific bodies.
/// @ingroup filter_joint
b3FilterJointDef :: struct {
    /// Base joint definition
    base: b3JointDef;
}

/// Use this to initialize your joint definition
/// @ingroup filter_joint
b3DefaultFilterJointDef :: () -> b3FilterJointDef #foreign box3d;

/// Parallel joint definition. Constrains the angle between axis z in body A and axis z in body B
/// using a spring. Useful to keep a body upright.
/// @ingroup parallel_joint
b3ParallelJointDef :: struct {
    /// Base joint definition
    base:         b3JointDef;

    /// The spring stiffness Hertz, cycles per second
    hertz:        float;

    /// The spring damping ratio, non-dimensional
    dampingRatio: float;

    /// The maximum spring torque, typically in newton-meters.
    maxTorque:    float;
}

/// Use this to initialize your joint definition
/// @ingroup parallel_joint
b3DefaultParallelJointDef :: () -> b3ParallelJointDef #foreign box3d;

/// Prismatic joint definition. Body B may slide along the x-axis in local frame A.
/// Body B cannot rotate relative to body A. The joint translation is zero when the
/// local frame origins coincide in world space.
/// @ingroup prismatic_joint
b3PrismaticJointDef :: struct {
    /// Base joint definition
    base:              b3JointDef;

    /// Enable a linear spring along the prismatic joint axis
    enableSpring:      bool;

    /// The spring stiffness Hertz, cycles per second
    hertz:             float;

    /// The spring damping ratio, non-dimensional
    dampingRatio:      float;

    /// The target translation for the joint in meters. The spring-damper will drive
    /// to this translation.
    targetTranslation: float;

    /// Enable/disable the joint limit
    enableLimit:       bool;

    /// The lower translation limit
    lowerTranslation:  float;

    /// The upper translation limit
    upperTranslation:  float;

    /// Enable/disable the joint motor
    enableMotor:       bool;

    /// The maximum motor force, typically in newtons
    maxMotorForce:     float;

    /// The desired motor speed, typically in meters per second
    motorSpeed:        float;
}

/// Use this to initialize your joint definition
/// @ingroup prismatic_joint
b3DefaultPrismaticJointDef :: () -> b3PrismaticJointDef #foreign box3d;

/// Revolute joint definition. A point on body B is fixed to a point on body A.
/// Allows relative rotation about the z-axis.
/// @ingroup revolute_joint
b3RevoluteJointDef :: struct {
    /// Base joint definition.
    base:           b3JointDef;

    /// The bodyB angle minus bodyA angle in the reference state (radians).
    /// This defines the zero angle for the joint limit.
    targetAngle:    float;

    /// Enable a rotational spring on the revolute hinge axis.
    enableSpring:   bool;

    /// The spring stiffness Hertz, cycles per second.
    hertz:          float;

    /// The spring damping ratio, non-dimensional.
    dampingRatio:   float;

    /// A flag to enable joint limits.
    enableLimit:    bool;

    /// The lower angle for the joint limit in radians. Minimum of -0.99*pi radians.
    lowerAngle:     float;

    /// The upper angle for the joint limit in radians. Maximum of 0.99*pi radians.
    upperAngle:     float;

    /// A flag to enable the joint motor.
    enableMotor:    bool;

    /// The maximum motor torque, typically in newton-meters.
    maxMotorTorque: float;

    /// The desired motor speed in radians per second.
    motorSpeed:     float;
}

/// Use this to initialize your joint definition.
/// @ingroup revolute_joint
b3DefaultRevoluteJointDef :: () -> b3RevoluteJointDef #foreign box3d;

/// Spherical joint definition. A point on body B is fixed to a point on body A.
/// Allows rotation about the shared point.
/// @ingroup spherical_joint
b3SphericalJointDef :: struct {
    /// Base joint definition
    base:             b3JointDef;

    /// Enable a rotational spring that attempts to align the two joint frames.
    enableSpring:     bool;

    /// The spring stiffness Hertz, cycles per second. This may be clamped internally
    /// according to the time step to maintain stability. Non-negative number.
    hertz:            float;

    /// The spring damping ratio, non-dimensional. Non-negative number.
    dampingRatio:     float;

    /// Target spring rotation, joint frame B relative to joint frame A.
    targetRotation:   b3Quat;

    /// A flag to enable the cone limit. The cone is centered on the frameA z-axis.
    enableConeLimit:  bool;

    /// The angle for the cone limit in radians. Valid range is [0, pi]
    coneAngle:        float;

    /// A flag to enable the twist limit. The twist is centered on the frameB z-axis.
    enableTwistLimit: bool;

    /// The angle for the lower twist limit in radians. Minimum of -0.99*pi radians.
    lowerTwistAngle:  float;

    /// The angle for the upper twist limit in radians. Maximum of 0.99*pi radians.
    upperTwistAngle:  float;

    /// A flag to enable the joint motor
    enableMotor:      bool;

    /// The maximum motor torque, typically in newton-meters. Non-negative number.
    maxMotorTorque:   float;

    /// The desired motor angular velocity in radians per second.
    motorVelocity:    b3Vec3;
}

/// Use this to initialize your joint definition.
/// @ingroup spherical_joint
b3DefaultSphericalJointDef :: () -> b3SphericalJointDef #foreign box3d;

/// Weld joint definition
/// Connects two bodies together rigidly. This constraint provides springs to mimic
/// soft-body simulation.
/// @note The approximate solver in Box3D cannot hold many bodies together rigidly
/// @ingroup weld_joint
b3WeldJointDef :: struct {
    /// Base joint definition
    base:                b3JointDef;

    /// Linear stiffness expressed as Hertz (cycles per second). Use zero for maximum stiffness.
    linearHertz:         float;

    /// Angular stiffness as Hertz (cycles per second). Use zero for maximum stiffness.
    angularHertz:        float;

    /// Linear damping ratio, non-dimensional. Use 1 for critical damping.
    linearDampingRatio:  float;

    /// Linear damping ratio, non-dimensional. Use 1 for critical damping.
    angularDampingRatio: float;
}

/// Use this to initialize your joint definition
/// @ingroup weld_joint
b3DefaultWeldJointDef :: () -> b3WeldJointDef #foreign box3d;

/// Wheel joint definition
/// Body A is the chassis and body B is the wheel.
/// The wheel rotates around the local z-axis in frame B.
/// The wheel translates along the local x-axis in frame A.
/// The wheel can optionally steer along the x-axis in frame A.
/// @ingroup wheel_joint
b3WheelJointDef :: struct {
    /// Base joint definition
    base:                   b3JointDef;

    /// Enable a linear spring along the local axis
    enableSuspensionSpring: bool;

    /// Spring stiffness in Hertz
    suspensionHertz:        float;

    /// Spring damping ratio, non-dimensional
    suspensionDampingRatio: float;

    /// Enable/disable the joint linear limit
    enableSuspensionLimit:  bool;

    /// The lower suspension translation limit
    lowerSuspensionLimit:   float;

    /// The upper translation limit
    upperSuspensionLimit:   float;

    /// Enable/disable the joint rotational motor
    enableSpinMotor:        bool;

    /// The maximum motor torque, typically in newton-meters
    maxSpinTorque:          float;

    /// The desired motor speed in radians per second
    spinSpeed:              float;

    /// Enable steering, otherwise the steering is fixed forward
    enableSteering:         bool;

    /// Steering stiffness in Hertz
    steeringHertz:          float;

    /// Spring damping ratio, non-dimensional
    steeringDampingRatio:   float;

    /// The target steering angle in radians
    targetSteeringAngle:    float;

    /// The maximum steering torque in N*m
    maxSteeringTorque:      float;

    /// Enable/disable the steering angular limit
    enableSteeringLimit:    bool;

    /// The lower steering angle in radians
    lowerSteeringLimit:     float;

    /// The upper steering angle in radians
    upperSteeringLimit:     float;
}

/// Use this to initialize your joint definition
/// @ingroup wheel_joint
b3DefaultWheelJointDef :: () -> b3WheelJointDef #foreign box3d;

/// The explosion definition is used to configure options for explosions. Explosions
/// consider shape geometry when computing the impulse.
/// @ingroup world
b3ExplosionDef :: struct {
    /// Mask bits to filter shapes
    maskBits:       u64;

    /// The center of the explosion in world space
    position:       b3Pos;

    /// The radius of the explosion
    radius:         float;

    /// The falloff distance beyond the radius. Impulse is reduced to zero at this distance.
    falloff:        float;

    /// Impulse per unit area. This applies an impulse according to the shape area that
    /// is facing the explosion. Explosions only apply to spheres, capsules, and hulls. This
    /// may be negative for implosions.
    impulsePerArea: float;
}

/// Use this to initialize your explosion definition
/// @ingroup world
b3DefaultExplosionDef :: () -> b3ExplosionDef #foreign box3d;

/// A begin-touch event is generated when a shape starts to overlap a sensor shape.
b3SensorBeginTouchEvent :: struct {
    /// The id of the sensor shape
    sensorShapeId:  b3ShapeId;

    /// The id of the shape that began touching the sensor shape
    visitorShapeId: b3ShapeId;
}

/// An end touch event is generated when a shape stops overlapping a sensor shape.
///	These include things like setting the transform, destroying a body or shape, or changing
///	a filter. You will also get an end event if the sensor or visitor are destroyed.
///	Therefore you should always confirm the shape id is valid using b3Shape_IsValid.
b3SensorEndTouchEvent :: struct {
    /// The id of the sensor shape
    ///	@warning this shape may have been destroyed
    ///	@see b3Shape_IsValid
    sensorShapeId:  b3ShapeId;

    /// The id of the shape that stopped touching the sensor shape
    ///	@warning this shape may have been destroyed
    ///	@see b3Shape_IsValid
    visitorShapeId: b3ShapeId;
}

/// Sensor events are buffered in the world and are available
///	as begin/end overlap event arrays after the time step is complete.
///	Note: these may become invalid if bodies and/or shapes are destroyed
b3SensorEvents :: struct {
    /// Array of sensor begin touch events
    beginEvents: *b3SensorBeginTouchEvent;

    /// Array of sensor end touch events
    endEvents:   *b3SensorEndTouchEvent;

    /// The number of begin touch events
    beginCount:  s32;

    /// The number of end touch events
    endCount:    s32;
}

/// A begin-touch event is generated when two shapes begin touching.
b3ContactBeginTouchEvent :: struct {
    /// Id of the first shape
    shapeIdA:  b3ShapeId;

    /// Id of the second shape
    shapeIdB:  b3ShapeId;

    /// The transient contact id. This contact may be destroyed automatically when the world is modified or simulated.
    /// Use b3Contact_IsValid before using this id.
    contactId: b3ContactId;
}

/// An end touch event is generated when two shapes stop touching.
///	You will get an end event if you do anything that destroys contacts previous to the last
///	world step. These include things like setting the transform, destroying a body
///	or shape, or changing a filter or body type.
b3ContactEndTouchEvent :: struct {
    /// Id of the first shape
    ///	@warning this shape may have been destroyed
    ///	@see b3Shape_IsValid
    shapeIdA:  b3ShapeId;

    /// Id of the first shape
    ///	@warning this shape may have been destroyed
    ///	@see b3Shape_IsValid
    shapeIdB:  b3ShapeId;

    /// Id of the contact.
    ///	@warning this contact may have been destroyed
    ///	@see b3Contact_IsValid
    contactId: b3ContactId;
}

/// A hit touch event is generated when two shapes collide with a speed faster than the hit speed threshold.
/// This may be reported for speculative contacts that have a confirmed impulse.
b3ContactHitEvent :: struct {
    /// Id of the first shape
    shapeIdA:        b3ShapeId;

    /// Id of the second shape
    shapeIdB:        b3ShapeId;

    /// Id of the contact.
    ///	@warning this contact may have been destroyed
    ///	@see b3Contact_IsValid
    contactId:       b3ContactId;

    /// Point where the shapes hit at the beginning of the time step.
    /// This is a mid-point between the two surfaces. It could be at speculative
    /// point where the two shapes were not touching at the beginning of the time step.
    point:           b3Pos;

    /// Normal vector pointing from shape A to shape B
    normal:          b3Vec3;

    /// The speed the shapes are approaching. Always positive. Typically in meters per second.
    approachSpeed:   float;

    /// User material on shape A
    userMaterialIdA: u64;

    /// User material on shape B
    userMaterialIdB: u64;
}

/// Contact events are buffered in the world and are available
///	as event arrays after the time step is complete.
///	Note: these may become invalid if bodies and/or shapes are destroyed
b3ContactEvents :: struct {
    /// Array of begin touch events
    beginEvents: *b3ContactBeginTouchEvent;

    /// Array of end touch events
    endEvents:   *b3ContactEndTouchEvent;

    /// Array of hit events
    hitEvents:   *b3ContactHitEvent;

    /// Number of begin touch events
    beginCount:  s32;

    /// Number of end touch events
    endCount:    s32;

    /// Number of hit events
    hitCount:    s32;
}

/// Body move events triggered when a body moves.
/// Triggered when a body moves due to simulation. Not reported for bodies moved by the user.
/// This also has a flag to indicate that the body went to sleep so the application can also
/// sleep that actor/entity/object associated with the body.
/// On the other hand if the flag does not indicate the body went to sleep then the application
/// can treat the actor/entity/object associated with the body as awake.
/// This is an efficient way for an application to update game object transforms rather than
/// calling functions such as b3Body_GetTransform() because this data is delivered as a contiguous array
/// and it is only populated with bodies that have moved.
/// @note If sleeping is disabled all dynamic and kinematic bodies will trigger move events.
b3BodyMoveEvent :: struct {
    /// The body user data.
    userData:   *void;

    /// The body transform.
    transform:  b3WorldTransform;

    /// The body id.
    bodyId:     b3BodyId;

    /// Did the body fall asleep this time step?
    fellAsleep: bool;
}

/// Body events are buffered in the world and are available
///	as event arrays after the time step is complete.
///	Note: this data becomes invalid if bodies are destroyed
b3BodyEvents :: struct {
    /// Array of move events
    moveEvents: *b3BodyMoveEvent;

    /// Number of move events
    moveCount:  s32;
}

/// Joint events report joints that are awake and have a force and/or torque exceeding the threshold
/// The observed forces and torques are not returned for efficiency reasons.
b3JointEvent :: struct {
    /// The joint id
    jointId:  b3JointId;

    /// The user data from the joint for convenience
    userData: *void;
}

/// Joint events are buffered in the world and are available
/// as event arrays after the time step is complete.
/// Note: this data becomes invalid if joints are destroyed
b3JointEvents :: struct {
    /// Array of events
    jointEvents: *b3JointEvent;

    /// Number of events
    count:       s32;
}

/// The contact data for two shapes. By convention the manifold normal points
/// from shape A to shape B.
/// @see b3Shape_GetContactData() and b3Body_GetContactData()
b3ContactData :: struct {
    /// The contact id. You may hold onto this to track a contact across time steps.
    /// This id may become orphaned. Use b3Contact_IsValid before using it for other functions.
    contactId:     b3ContactId;

    /// The first shape id.
    shapeIdA:      b3ShapeId;

    /// The second shape id.
    shapeIdB:      b3ShapeId;

    /// The contact manifold. This points to internal data and may become invalid. Do not store
    /// this pointer.
    manifolds:     *b3Manifold;

    /// The number of contact manifolds. For mesh and height-field collision there can be multiple manifolds.
    manifoldCount: s32;
}

/// The query filter is used to filter collisions between queries and shapes. For example,
/// you may want a ray-cast representing a projectile to hit players and the static environment
/// but not debris.
b3QueryFilter :: struct {
    /// The collision category bits of this query. Normally you would just set one bit.
    categoryBits: u64;

    /// The collision mask bits. This states the shape categories that this
    /// query would accept for collision.
    maskBits:     u64;

    /// Optional id combined with @ref name to identify this query in a recording, e.g. an entity id.
    /// Need not be unique on its own. 0 with a null name means untagged. Ignored when not recording.
    id:           u64;

    /// Optional label combined with @ref id to identify this query, e.g. "bullet". Need not be unique
    /// on its own. The recorder hashes (id, name) into one stable key the viewer tracks the query by,
    /// so the same id and name pair identifies the same query across frames. NULL means none. Ignored
    /// when not recording.
    name:         *u8;
}

/// Use this to initialize your query filter
b3DefaultQueryFilter :: () -> b3QueryFilter #foreign box3d;

/// Low level ray cast input data.
b3RayCastInput :: struct {
    /// Start point of the ray cast.
    origin:      b3Vec3;

    /// Translation of the ray cast.
    /// end = start + translation.
    translation: b3Vec3;

    /// The maximum fraction of the translation to consider, typically 1
    maxFraction: float;
}

/// Result from b3World_RayCastClosest.
b3RayResult :: struct {
    /// The shape hit.
    shapeId:        b3ShapeId;

    /// The world point of the hit.
    point:          b3Pos;

    /// The world normal of the shape surface at the hit point.
    normal:         b3Vec3;

    /// The user material id at the hit point. This can be per triangle
    /// if the shape is a mesh, height-field, or compound with child mesh.
    userMaterialId: u64;

    /// The fraction of the input ray.
    fraction:       float;

    /// The triangle index if the shape is a mesh, height-field, or compound with
    /// child mesh.
    triangleIndex:  s32;

    /// The child index if the shape is a compound.
    childIndex:     s32;

    /// The number of BVH nodes visited. Diagnostic.
    nodeVisits:     s32;

    /// The number of BVH leaves visited. Diagnostic.
    leafVisits:     s32;

    /// Did the ray hit? If false, all other data is invalid.
    hit:            bool;
}

/// A shape proxy is used by the GJK algorithm. It can represent a convex shape.
b3ShapeProxy :: struct {
    /// The point cloud.
    points: *b3Vec3;

    /// The number of points. Do not exceed B3_MAX_SHAPE_CAST_POINTS.
    count:  s32;

    /// The external radius of the point cloud.
    radius: float;
}

/// Low level shape cast input in generic form. This allows casting an arbitrary point
/// cloud wrap with a radius. For example, a sphere is a single point with a non-zero radius.
/// A capsule is two points with a non-zero radius. A box is four points with a zero radius.
b3ShapeCastInput :: struct {
    /// A generic query shape.
    proxy:       b3ShapeProxy;

    /// The translation of the shape cast.
    translation: b3Vec3;

    /// The maximum fraction of the translation to consider, typically 1.
    maxFraction: float;

    /// Allow shape cast to encroach when initially touching. This only works if the radius is greater than zero.
    canEncroach: bool;
}

/// Input for sweeping an AABB through a dynamic tree. The box is in the tree's world float frame.
/// The caller folds the cast shape radius and any world origin into the box, so the tree traversal
/// stays a conservative box sweep and the precise narrow phase happens per shape in the callback.
b3BoxCastInput :: struct {
    /// The AABB to cast, in the tree's frame.
    box:         b3AABB;

    /// The sweep translation.
    translation: b3Vec3;

    /// The maximum fraction of the translation to consider, typically 1.
    maxFraction: float;
}

/// Low level ray cast or shape-cast output data.
b3CastOutput :: struct {
    /// The surface normal at the hit point.
    normal:        b3Vec3;

    /// The surface hit point.
    point:         b3Vec3;

    /// The fraction of the input translation at collision.
    fraction:      float;

    /// The number of iterations used.
    iterations:    s32;

    /// The index of the mesh or height field triangle hit.
    triangleIndex: s32;

    /// The index of the compound child shape.
    childIndex:    s32;

    /// The material index. May be -1 for null.
    materialIndex: s32;

    /// Did the cast hit?
    hit:           bool;
}

/// Same type in single precision.
b3WorldCastOutput :: b3CastOutput;

/// Body cast result for ray and shape casts.
b3BodyCastResult :: struct {
    /// The shape hit.
    shapeId:        b3ShapeId;

    /// The world point on the shape surface.
    point:          b3Pos;

    /// The world normal vector on the shape surface.
    normal:         b3Vec3;

    /// The fraction along the ray hit.
    /// hit point = origin + fraction * translation
    fraction:       float;

    /// The triangle index if the shape is a mesh or height-field.
    triangleIndex:  s32;

    /// The user material id at the hit point. This can be per triangle
    /// if the shape is a mesh, height-field, or compound with child mesh.
    userMaterialId: u64;

    /// The number of iterations used. Diagnostic.
    iterations:     s32;

    /// Did the cast hit? If false, all other fields are invalid.
    hit:            bool;
}

/// Used to warm start the GJK simplex. If you call this function multiple times with nearby
/// transforms this might improve performance. Otherwise you can zero initialize this.
/// The distance cache must be initialized to zero on the first call.
/// Users should generally just zero initialize this structure for each call.
b3SimplexCache :: struct {
    /// Value use to compare length, area, volume of two simplexes.
    metric: float;

    // todo use an index of 0xFF as a sentinel and remove the count
    /// The number of stored simplex points
    count:  u16;

    /// The cached simplex indices on shape A
    indexA: [4] u8;

    /// The cached simplex indices on shape B
    indexB: [4] u8;
}

/// Input parameters for b3ShapeCast
b3ShapeCastPairInput :: struct {
    proxyA:       b3ShapeProxy; ///< The proxy for shape A
    proxyB:       b3ShapeProxy; ///< The proxy for shape B
    transform:    b3Transform; ///< Transform of shape B in shape A's frame, the relative pose B in A
    translationB: b3Vec3; ///< The translation of shape B, in A's frame
    maxFraction:  float; ///< The fraction of the translation to consider, typically 1
    canEncroach:  bool; ///< Allows shapes with a radius to move slightly closer if already touching
}

/// Input for b3ShapeDistance
b3DistanceInput :: struct {
    /// The proxy for shape A
    proxyA:    b3ShapeProxy;

    /// The proxy for shape B
    proxyB:    b3ShapeProxy;

    /// Transform of shape B in shape A's frame, the relative pose B in A
    /// (b3InvMulWorldTransforms( worldA, worldB )). The query is origin independent and runs in frame A.
    transform: b3Transform;

    /// Should the proxy radius be considered?
    useRadii:  bool;
}

/// Output for b3ShapeDistance
b3DistanceOutput :: struct {
    pointA:       b3Vec3; ///< Closest point on shapeA, in shape A's frame
    pointB:       b3Vec3; ///< Closest point on shapeB, in shape A's frame
    normal:       b3Vec3; ///< A to B normal in shape A's frame. Invalid if distance is zero.
    distance:     float; ///< The final distance, zero if overlapped
    iterations:   s32; ///< Number of GJK iterations used
    simplexCount: s32; ///< The number of simplexes stored in the simplex array
}

/// Simplex vertex for debugging the GJK algorithm
b3SimplexVertex :: struct {
    wA:     b3Vec3; ///< support point in proxyA
    wB:     b3Vec3; ///< support point in proxyB
    w:      b3Vec3; ///< wB - wA
    a:      float; ///< barycentric coordinates
    indexA: s32; ///< wA index
    indexB: s32; ///< wB index
}

/// Simplex from the GJK algorithm
b3Simplex :: struct {
    vertices: [4] b3SimplexVertex; ///< vertices
    count:    s32; ///< number of valid vertices
}

/// This describes the motion of a body/shape for TOI computation. Shapes are defined with respect to the body origin,
/// which may not coincide with the center of mass. However, to support dynamics we must interpolate the center of mass
/// position.
b3Sweep :: struct {
    localCenter: b3Vec3; ///< Local center of mass position
    c1:          b3Vec3; ///< Starting center of mass world position
    c2:          b3Vec3; ///< Ending center of mass world position
    q1:          b3Quat; ///< Starting world rotation
    q2:          b3Quat; ///< Ending world rotation
}

/// Time of impact input
b3TOIInput :: struct {
    proxyA:      b3ShapeProxy; ///< The proxy for shape A
    proxyB:      b3ShapeProxy; ///< The proxy for shape B
    sweepA:      b3Sweep; ///< The movement of shape A
    sweepB:      b3Sweep; ///< The movement of shape B
    maxFraction: float; ///< Defines the sweep interval [0, tMax]
}

/// Describes the TOI output
b3TOIState :: enum u32 {
    toiStateUnknown    :: 0;
    toiStateFailed     :: 1;
    toiStateOverlapped :: 2;
    toiStateHit        :: 3;
    toiStateSeparated  :: 4;

    b3_toiStateUnknown    :: toiStateUnknown;
    b3_toiStateFailed     :: toiStateFailed;
    b3_toiStateOverlapped :: toiStateOverlapped;
    b3_toiStateHit        :: toiStateHit;
    b3_toiStateSeparated  :: toiStateSeparated;
}

/// Time of impact output
b3TOIOutput :: struct {
    /// The type of result
    state:              b3TOIState;

    /// The hit point
    point:              b3Vec3;

    /// The hit normal
    normal:             b3Vec3;

    /// The sweep time of the collision
    fraction:           float;

    /// The final distance
    distance:           float;

    /// Number of outer iterations
    distanceIterations: s32;

    /// Total number of push back iterations
    pushBackIterations: s32;

    /// Total number of root iterations
    rootIterations:     s32;

    /// Indicates that the time of impact detected initial
    /// overlap and used a fallback sphere as a last ditch effort
    /// to prevent tunneling.
    usedFallback:       bool;
}

/// Flags for tree nodes. For internal usage.
b3TreeNodeFlags :: enum u32 {
    allocatedNode :: 1;
    enlargedNode  :: 2;
    leafNode      :: 4;

    b3_allocatedNode :: allocatedNode;
    b3_enlargedNode  :: enlargedNode;
    b3_leafNode      :: leafNode;
}

/// Tree node child indices. For internal usage.
b3TreeNodeChildren :: struct {
    child1: s32; ///< child node index 1
    child2: s32; ///< child node index 2
}

/// A node in the dynamic tree. This is private data placed here for performance reasons.
/// todo test padding to 64 bytes to avoid straddling cache lines
b3TreeNode :: struct {
    aabb:         b3AABB; // 24

    categoryBits: u64; // 8

    struct {
        /// Children (internal node)
        children: b3TreeNodeChildren;

        #overlay (children) /// User data (leaf node)
userData: u64;
    }

    struct {
        /// The node parent index (allocated node)
        parent: s32;

        #overlay (parent) /// The node freelist next index (free node)
next: s32;
    }

    height:       u16; // 2

    flags:        u16; // 2
}

/// The dynamic tree structure. This should be considered private data.
/// It is placed here for performance reasons.
b3DynamicTree :: struct {
    /// The dynamic tree version. Always the first field. Useful
    /// if the tree is serialized.
    version:         u64;

    /// The tree nodes
    nodes:           *b3TreeNode;

    /// The root index
    root:            s32;

    /// The number of nodes
    nodeCount:       s32;

    /// The allocated node space
    nodeCapacity:    s32;

    /// Number of proxies created
    proxyCount:      s32;

    /// Node free list
    freeList:        s32;

    /// Leaf indices for rebuild
    leafIndices:     *s32;

    /// Leaf bounding boxes for rebuild
    leafBoxes:       *b3AABB;

    /// Leaf bounding box centers for rebuild
    leafCenters:     *b3Vec3;

    /// Bins for sorting during rebuild
    binIndices:      *s32;

    /// Allocated space for rebuilding
    rebuildCapacity: s32;
}

/// These are performance results returned by dynamic tree queries.
b3TreeStats :: struct {
    /// Number of internal nodes visited during the query
    nodeVisits: s32;

    /// Number of leaf nodes visited during the query
    leafVisits: s32;
}

/// This function receives proxies found in the AABB query.
/// @return true if the query should continue
b3TreeQueryCallbackFcn :: #type (proxyId: s32, userData: u64, _context: *void) -> bool #c_call;

/// This function receives the minimum distance squared so far and proxy to check in the closest query.
/// @return minimum distance squared to user objects in the proxy
b3TreeQueryClosestCallbackFcn :: #type (distanceSqrMin: float, proxyId: s32, userData: u64, _context: *void) -> float #c_call;

/// This function receives clipped AABB cast input for a proxy. The function returns the new cast
/// fraction.
/// - return a value of 0 to terminate the cast
/// - return a value less than input->maxFraction to clip the cast
/// - return a value of input->maxFraction to continue the cast without clipping
b3TreeBoxCastCallbackFcn :: #type (input: *b3BoxCastInput, proxyId: s32, userData: u64, _context: *void) -> float #c_call;

/// This function receives clipped ray cast input for a proxy. The function
/// returns the new ray fraction.
/// - return a value of 0 to terminate the ray cast
/// - return a value less than input->maxFraction to clip the ray
/// - return a value of input->maxFraction to continue the ray cast without clipping
b3TreeRayCastCallbackFcn :: #type (input: *b3RayCastInput, proxyId: s32, userData: u64, _context: *void) -> float #c_call;

/// The plane between a character mover and a shape
b3PlaneResult :: struct {
    /// Outward pointing plane.
    plane: b3Plane;

    /// Closest point on the shape. May not be unique.
    point: b3Vec3;
}

/// These are collision planes that can be fed to b3SolvePlanes. Normally
/// this is assembled by the user from plane results in b3PlaneResult.
b3CollisionPlane :: struct {
    /// The collision plane between the mover and some shape.
    plane:        b3Plane;

    /// Setting this to FLT_MAX makes the plane as rigid as possible. Lower values can
    /// make the plane collision soft. Usually in meters.
    pushLimit:    float;

    /// The push on the mover determined by b3SolvePlanes. Usually in meters.
    push:         float;

    /// Indicates if b3ClipVector should clip against this plane. Should be false for soft collision.
    clipVelocity: bool;
}

/// Result returned by b3SolvePlanes.
b3PlaneSolverResult :: struct {
    /// The final relative translation.
    delta:          b3Vec3;

    /// The number of iterations used by the plane solver. For diagnostics.
    iterationCount: s32;
}

/// Body plane result for movers.
b3BodyPlaneResult :: struct {
    /// The shape id on the body.
    shapeId: b3ShapeId;

    /// The plane result.
    result:  b3PlaneResult;
}

/// Used to collect collision planes for character movers.
/// Return true to continue gathering planes.
b3PlaneResultFcn :: #type (shapeId: b3ShapeId, plane: *b3PlaneResult, planeCount: s32, _context: *void) -> bool #c_call;

/// Used to filter shapes for shape casting character movers.
/// Return true to accept the collision
b3MoverFilterFcn :: #type (shapeId: b3ShapeId, _context: *void) -> bool #c_call;

/// This holds the mass data computed for a shape.
b3MassData :: struct {
    /// The shape mass
    mass:    float;

    /// The local center of mass position.
    center:  b3Vec3;

    /// The inertia tensor about the shape center of mass.
    inertia: b3Matrix3;
}

/// A solid sphere
b3Sphere :: struct {
    /// The local center
    center: b3Vec3;

    /// The radius
    radius: float;
}

/// A solid capsule can be viewed as two hemispheres connected
/// by a rectangle.
b3Capsule :: struct {
    /// Local center of the first hemisphere
    center1: b3Vec3;

    /// Local center of the second hemisphere
    center2: b3Vec3;

    /// The radius of the hemispheres
    radius:  float;
}

/// A hull vertex. Identified by a half-edge with this vertex as its tail.
b3HullVertex :: struct {
    /// A half-edge that has this vertex as the origin
    /// Can be used along with edge twins and winding order
    /// to traverse all the edges connected to this vertex.
    edge: u8;
}

/// Half-edge for hull data structure
b3HullHalfEdge :: struct {
    /// Next edge index CCW
    next:   u8;

    /// Twin edge index
    twin:   u8;

    /// index of origin vertex and point
    origin: u8;

    /// Face to the left of this edge
    face:   u8;
}

/// A hull face. Hulls use a half-edge data structure, so a face
/// can be determined from a single half-edge index.
b3HullFace :: struct {
    /// An arbitrary half-edge on this face
    edge: u8;
}

/// A convex hull.
/// @note This data structure has data hanging off the end and cannot be directly copied.
b3HullData :: struct {
    /// Version must be first and match B3_HULL_VERSION
    version:         u64;

    /// Hash of this hull (this field is zero when the hash is computed).
    hash:            u64;

    /// Axis-aligned box in local space.
    aabb:            b3AABB;

    /// Surface area, typically in squared meters.
    surfaceArea:     float;

    /// Volume, typically in m^3.
    volume:          float;

    /// The radius of the largest sphere at the center.
    innerRadius:     float;

    /// The local centroid
    center:          b3Vec3;

    /// The inertia tensor about the centroid.
    centralInertia:  b3Matrix3;

    /// The vertex count.
    vertexCount:     s32;

    /// Offset of the vertex array in bytes from the struct address.
    vertexOffset:    s32;

    /// Offset of the point array in bytes from the struct address.
    pointOffset:     s32;

    /// This is the half-edge count (double the edge count)
    edgeCount:       s32;

    /// Offset of the edge array in bytes from the struct address.
    edgeOffset:      s32;

    /// The face count. Hulls faces are convex polygons.
    faceCount:       s32;

    /// Offset of the face plane array in bytes from the struct address.
    planeOffset:     s32;

    /// Offset of the face array in bytes from the struct address.
    faceOffset:      s32;

    /// Offset of structure of array (SOA) vertices
    soaVertexOffset: s32;

    /// Offset of structure of array (SOA) unit normal vectors
    soaNormalOffset: s32;

    /// The total number of bytes for this hull.
    byteCount:       s32;
}

/// Efficient box hull
b3BoxHull :: struct {
    /// The embedded hull. So the offsets index into the arrays that follow.
    base:        b3HullData;
    boxVertices: [8] b3HullVertex; ///< Box vertices.
    boxPoints:   [8] b3Vec3; ///< Box points.
    boxEdges:    [24] b3HullHalfEdge; ///< Box half-edges.
    boxPlanes:   [6] b3Plane; ///< Box face planes.
    boxFaces:    [6] b3HullFace; ///< Box faces.
    padding:     [2] u8; ///< Explicit padding.
    vx:          [8] float; ///< vertex x
    vy:          [8] float; ///< vertex y
    vz:          [8] float; ///< vertex z
    nx:          [8] float; ///< normal x, padded to multiple of 4
    ny:          [8] float; ///< normal y, padded to multiple of 4
    nz:          [8] float; ///< normal z, padded to multiple of 4
}

/// This is used to create a re-usable collision mesh. No pointers
/// are held to this data in b3MeshData. So all this data can be temporary.
b3MeshDef :: struct {
    /// Triangle vertices.
    vertices:        *b3Vec3;

    /// Triangle vertex indices. 3 for each triangle. CCW winding.
    indices:         *s32;

    /// Triangle material index. 1 per triangle. Indexes into b3ShapeDef::materials.
    /// This allows different run-time material data to be associated with different
    /// instances of this mesh.
    materialIndices: *u8;

    /// Tolerance for vertex welding in length units.
    weldTolerance:   float;

    /// The vertex count. Must be 3 or more.
    vertexCount:     s32;

    /// The triangle count. Must be 1 or more.
    triangleCount:   s32;

    /// Optionally weld nearby vertices.
    weldVertices:    bool;

    /// Use the median split instead of SAH to speed up mesh creation. Good
    /// for meshes that are structured like a grid.
    useMedianSplit:  bool;

    /// Compute triangle adjacency information using shared edges
    identifyEdges:   bool;
}

/// Triangle mesh edge flags.
b3MeshEdgeFlags :: enum u32 {
    concaveEdge1        :: 1;
    concaveEdge2        :: 2;
    concaveEdge3        :: 4;

    inverseConcaveEdge1 :: 16;
    inverseConcaveEdge2 :: 32;
    inverseConcaveEdge3 :: 64;

    allConcaveEdges     :: 7;

    flatEdge1           :: 17;
    flatEdge2           :: 34;
    flatEdge3           :: 68;

    allFlatEdges        :: 119;

    b3_concaveEdge1        :: concaveEdge1;
    b3_concaveEdge2        :: concaveEdge2;
    b3_concaveEdge3        :: concaveEdge3;

    b3_inverseConcaveEdge1 :: inverseConcaveEdge1;
    b3_inverseConcaveEdge2 :: inverseConcaveEdge2;
    b3_inverseConcaveEdge3 :: inverseConcaveEdge3;

    b3_allConcaveEdges     :: allConcaveEdges;

    b3_flatEdge1           :: flatEdge1;
    b3_flatEdge2           :: flatEdge2;
    b3_flatEdge3           :: flatEdge3;

    b3_allFlatEdges        :: allFlatEdges;
}

/// A mesh triangle.
b3MeshTriangle :: struct {
    index1: s32; ///< Index of vertex 1.
    index2: s32; ///< Index of vertex 2.
    index3: s32; ///< Index of vertex 3.
}

/// A mesh BVH node.
b3MeshNode :: struct {
    /// The lower bound of the node AABB. Strategic placement for SIMD.
    lowerBound:     b3Vec3;

    data:           struct {
        asNode: struct {
            __bitfield: u32;
            /* 
                /// Split axis. 0, 1, or 2.
                axis: u32; /* 2 bits */
                /// Offset of the second child node.
                childOffset: u32; /* 30 bits */;
            */
        };

        #overlay (asNode) asLeaf: struct {
            __bitfield: u32;
            /* 
                /// Aligned with axis above and has value of 3 if this is a leaf.
                type: u32; /* 2 bits */
                /// The number of triangles for this leaf node.
                triangleCount: u32; /* 30 bits */;
            */
        };
    };

    /// The upper bound of the node AABB.  Strategic placement for SIMD.
    upperBound:     b3Vec3;

    /// The index of the leaf triangles.
    triangleOffset: u32;
}

set_data_asNode_axis :: (fields: *b3MeshNode, value: u32) {
    MASK0: u32 : 0b11;
    fields.data.asNode.__bitfield = (fields.data.asNode.__bitfield & ~MASK0) | (value & MASK0);
}
get_data_asNode_axis :: (fields: b3MeshNode) -> u32 {
    return (fields.data.asNode.__bitfield & 0b11);
}

set_data_asNode_childOffset :: (fields: *b3MeshNode, value: u32) {
    MASK0: u32 : (0b11_1111_1111_1111_1111_1111_1111_1111 << 2);
    fields.data.asNode.__bitfield = (fields.data.asNode.__bitfield & ~MASK0) | ((value << 2) & MASK0);
}
get_data_asNode_childOffset :: (fields: b3MeshNode) -> u32 {
    return ((fields.data.asNode.__bitfield & (0b11_1111_1111_1111_1111_1111_1111_1111 << 2)) >> 2);
}

set_data_asLeaf_type :: (fields: *b3MeshNode, value: u32) {
    MASK0: u32 : 0b11;
    fields.data.asLeaf.__bitfield = (fields.data.asLeaf.__bitfield & ~MASK0) | (value & MASK0);
}
get_data_asLeaf_type :: (fields: b3MeshNode) -> u32 {
    return (fields.data.asLeaf.__bitfield & 0b11);
}

set_data_asLeaf_triangleCount :: (fields: *b3MeshNode, value: u32) {
    MASK0: u32 : (0b11_1111_1111_1111_1111_1111_1111_1111 << 2);
    fields.data.asLeaf.__bitfield = (fields.data.asLeaf.__bitfield & ~MASK0) | ((value << 2) & MASK0);
}
get_data_asLeaf_triangleCount :: (fields: b3MeshNode) -> u32 {
    return ((fields.data.asLeaf.__bitfield & (0b11_1111_1111_1111_1111_1111_1111_1111 << 2)) >> 2);
}


/// This is a sorted triangle collision bounding volume hierarchy.
/// @note This struct has data hanging off the end and cannot be directly copied.
b3MeshData :: struct {
    /// Version must be first.
    version:         u64;

    /// Hash of this mesh (this field is zero when the hash is computed)
    hash:            u64;

    /// The total number of bytes for this mesh.
    byteCount:       s32;

    /// Local axis-aligned box.
    bounds:          b3AABB;

    /// Combined surface area of all triangles. Single-sided.
    surfaceArea:     float;

    /// The height of the bounding volume hierarchy.
    treeHeight:      s32;

    /// The number of degenerate triangles. Diagnostic.
    degenerateCount: s32;

    /// Offset of the node array in bytes from the struct address.
    nodeOffset:      s32;

    /// The number of BVH nodes.
    nodeCount:       s32;

    /// Offset of the vertex array in bytes from the struct address.
    vertexOffset:    s32;

    /// The number of vertices.
    vertexCount:     s32;

    /// Offset of the triangle array in bytes from the struct address.
    triangleOffset:  s32;

    /// The number of triangles.
    triangleCount:   s32;

    /// Offset of the material array in bytes from the struct address.
    materialOffset:  s32;

    /// The number of materials.
    materialCount:   s32;

    /// Offset of the triangle flag array in bytes from the struct address.
    flagsOffset:     s32;

    /// Explicit padding.
    padding:         s32;
}

/// This allows mesh data to be re-used with different scales.
b3Mesh :: struct {
    /// Immutable pointer to the mesh data.
    data:  *b3MeshData;

    /// This scale may be non-uniform and have negative components. However,
    /// no component may be very small in magnitude.
    scale: b3Vec3;
}

/// Data used to create a height field. No pointers are held to this data.
b3HeightFieldDef :: struct {
    /// Grid point heights
    /// count = countX * countZ
    heights:             *float;

    /// Grid cell material
    /// A value of 0xFF is reserved for holes
    /// count = (countX - 1) * (countZ - 1)
    materialIndices:     *u8;

    /// The height field scale. All components must be positive values.
    scale:               b3Vec3;

    /// The number of grid lines along the x-axis.
    countX:              s32;

    /// The number of grid lines along the z-axis.
    countZ:              s32;

    /// Global minimum and maximum heights used for quantization. This is important
    /// if you want height fields to be placed next to each other and line up exactly.
    /// In that case, both height fields should use the same minimum and maximum heights.
    /// All height values are clamped to this range.
    /// These values are in unscaled space.
    globalMinimumHeight: float;

    /// The maximum.
    globalMaximumHeight: float;

    /// Use clock-wise winding. This effectively inverts the height-field along the y-axis.
    clockwiseWinding:    bool;
}

/// A height field with compressed storage.
/// @note This data structure has data hanging off the end and cannot be directly copied.
b3HeightFieldData :: struct {
    /// Version must be first and match B3_HEIGHT_FIELD_VERSION
    version:        u64;

    /// Hash of this height field (this field is zero when the hash is computed).
    hash:           u64;

    /// The total number of bytes for this height field.
    byteCount:      s32;

    /// The local axis-aligned bounding box.
    aabb:           b3AABB;

    /// The minimum y value.
    minHeight:      float;

    /// The maximum y value
    maxHeight:      float;

    /// The quantization scale.
    heightScale:    float;

    /// The overall scale.
    scale:          b3Vec3;

    /// The number of grid columns along the local x-axis.
    columnCount:    s32;

    /// The number of grid rows along the local z-axis.
    rowCount:       s32;

    /// Offset of the compressed height array in bytes from the struct address.
    /// uint16_t, one per grid point.
    heightsOffset:  s32;

    /// Offset of the material index array in bytes from the struct address.
    /// uint8_t, one per cell.
    materialOffset: s32;

    /// Offset of the flag array in bytes from the struct address.
    /// uint8_t, one per triangle.
    flagsOffset:    s32;

    /// Triangle winding.
    clockwise:      u8;

    /// Explicit padding.
    padding:        [7] u8;
}

/// Definition for a capsule in a compound shape.
b3CompoundCapsuleDef :: struct {
    /// Local capsule.
    capsule:  b3Capsule;

    /// Material properties.
    material: b3SurfaceMaterial;
}

/// Definition for a convex hull in a compound shape.
b3CompoundHullDef :: struct {
    /// Shared hull.
    hull:      *b3HullData;

    /// Transform of the shared hull into compound local space.
    transform: b3Transform;

    /// Material properties.
    material:  b3SurfaceMaterial;
}

/// Definition for a triangle mesh in a compound shape.
b3CompoundMeshDef :: struct {
    /// Shared mesh.
    meshData:      *b3MeshData;

    /// Transform of the shared mesh into compound local space.
    transform:     b3Transform;

    /// Local space non-uniform mesh scale. May have negative components.
    scale:         b3Vec3;

    /// Material properties.
    /// This array must line up with the material indices on the triangles.
    materials:     *b3SurfaceMaterial;

    /// Number of materials.
    materialCount: s32;
}

/// Definition for a sphere in a compound shape.
b3CompoundSphereDef :: struct {
    /// Local sphere.
    sphere:   b3Sphere;

    /// Material properties.
    material: b3SurfaceMaterial;
}

/// Definition for creating a compound shape. All this data is fully cloned
/// into the run-time compound shape.
b3CompoundDef :: struct {
    /// Capsule instances.
    capsules:     *b3CompoundCapsuleDef;

    /// Number of capsules.
    capsuleCount: s32;

    /// Hulls instances.
    hulls:        *b3CompoundHullDef;

    /// Number of hull instances.
    hullCount:    s32;

    /// Mesh instances.
    meshes:       *b3CompoundMeshDef;

    /// Number of mesh instances.
    meshCount:    s32;

    /// Sphere instances.
    spheres:      *b3CompoundSphereDef;

    /// Number of spheres.
    sphereCount:  s32;
}

/// The data for a baked compound shape. This is a potentially large yet highly optimized
/// data structure. It can contain thousands of child shapes, yet at runtime it populates
/// into the world as a single shape in the runtime broad-phase.
/// This data structure has data living off the end and must be accessed using offsets.
/// Accessors are provided for user relevant data.
/// Note: you don't need to use this to create runtime compounds. For runtime compounds you can
/// add multiple shapes to a body using the regular shape creation functions.
b3CompoundData :: struct {
    /// The compound version is always first.
    version:         u64;

    /// The total number of bytes for this compound.
    byteCount:       s32;

    /// Offset of the tree node array in bytes from the struct address.
    nodeOffset:      s32;

    /// Immutable dynamic tree. The tree node pointer must be fixed up using the node offset
    tree:            b3DynamicTree;

    /// Offset of the material array in bytes from the struct address.
    materialOffset:  s32;

    /// The number of materials.
    materialCount:   s32;

    /// Offset of the capsule array in bytes from the struct address.
    capsuleOffset:   s32;

    /// The number of capsules.
    capsuleCount:    s32;

    /// Offset of the hull instance array in bytes from the struct address.
    hullOffset:      s32;

    /// The number of hull instances.
    hullCount:       s32;

    /// The number of unique hulls. Diagnostic.
    sharedHullCount: s32;

    /// Offset of the mesh instance array in bytes from the struct address.
    meshOffset:      s32;

    /// The number of mesh instances.
    meshCount:       s32;

    /// The number of unique meshes. Diagnostic.
    sharedMeshCount: s32;

    /// Offset of the sphere array in bytes from the struct address.
    sphereOffset:    s32;

    /// The number of spheres.
    sphereCount:     s32;
}

/// A capsule that lives in a compound.
b3CompoundCapsule :: struct {
    /// Local capsule.
    capsule:       b3Capsule;

    /// Index to a shared material.
    materialIndex: s32;
}

/// A hull that lives in a compound.
b3CompoundHull :: struct {
    /// Pointer to the unique shared hull.
    hull:          *b3HullData;

    /// The transform of this hull instance.
    transform:     b3Transform;

    /// Index to a shared material.
    materialIndex: s32;
}

/// A mesh with non-uniform scale that lives in a compound.
b3CompoundMesh :: struct {
    /// Pointer to the unique shared mesh.
    meshData:        *b3MeshData;

    /// The transform of this mesh instance.
    transform:       b3Transform;

    /// Non-uniform scale of this mesh instance.
    scale:           b3Vec3;

    /// This is used to access the surface material from b3GetCompoundMaterials.
    /// Requires an extra level of indirection. The triangle material index
    /// is clamped to B3_MAX_COMPOUND_MESH_MATERIALS.
    /// materialIndex = materialIndices[triangle->materialIndex]
    materialIndices: [4] s32;
}

/// A sphere that lives in a compound.
b3CompoundSphere :: struct {
    /// Local sphere.
    sphere:        b3Sphere;

    /// Index to a shared material.
    materialIndex: s32;
}

/// Callback for compound overlap queries.
b3CompoundQueryFcn :: #type (compound: *b3CompoundData, childIndex: s32, _context: *void) -> bool #c_call;

/// A manifold point is a contact point belonging to a contact manifold.
/// It holds details related to the geometry and dynamics of the contact points.
/// Box3D uses speculative collision so some contact points may be separated.
/// You may use the maxNormalImpulse to determine if there was an interaction during
/// the time step.
b3ManifoldPoint :: struct {
    /// Location of the contact point relative to the bodyA center of mass in world space.
    anchorA:            b3Vec3;

    /// Location of the contact point relative to the bodyB center of mass in world space.
    anchorB:            b3Vec3;

    /// The separation of the contact point, negative if penetrating.
    /// This may be modified during a discrete pre-solve callback.
    separation:         float;

    /// Cached separation used for contact recycling
    baseSeparation:     float;

    /// Current-step friction coefficient initialized from the contact materials.
    /// This may be modified during a discrete pre-solve callback.
    friction:           float;

    /// Current-step restitution coefficient initialized from the contact materials.
    /// This may be modified during a discrete pre-solve callback.
    restitution:        float;

    /// Current-step maximum accumulated normal impulse, initialized to FLT_MAX.
    /// This may be modified during a discrete pre-solve callback.
    maxNormalImpulse:   float;

    /// The impulse along the manifold normal vector. Since Box3D uses sub-stepping, this is
    /// result from the final sub-step.
    normalImpulse:      float;

    /// The total normal impulse applied during sub-stepping. This is important
    /// to identify speculative contact points that had an interaction in the time step.
    totalNormalImpulse: float;

    /// Relative normal velocity pre-solve. Used for hit events. If the normal impulse is
    /// zero then there was no hit. Negative means shapes are approaching.
    normalVelocity:     float;

    /// Local point for matching
    /// Uniquely identifies a contact point between two shapes
    featureId:          u32;

    /// Triangle index if one of the shapes is a mesh or height field
    triangleIndex:      s32;

    /// Did this contact point exist in the previous step?
    persisted:          bool;

    /// Set false during a discrete pre-solve callback to remove this point for the current step.
    enabled:            bool;
}

/// A contact manifold describes the contact points between colliding shapes.
/// @note Box3D uses speculative collision so some contact points may be separated.
b3Manifold :: struct {
    /// The manifold points. There may be 1 to 4 valid points.
    points:          [4] b3ManifoldPoint;

    /// The unit normal vector in world space, points from shape A to shape B.
    /// This may be modified during a discrete pre-solve callback.
    normal:          b3Vec3;

    /// Central friction angular impulse (applied about the normal)
    twistImpulse:    float;

    /// Central friction linear impulse
    frictionImpulse: b3Vec3;

    /// Rolling resistance angular impulse
    rollingImpulse:  b3Vec3;

    /// The number of contact points, will be 0 to 4.
    /// This is read-only during a pre-solve callback. Disable individual points with b3ManifoldPoint::enabled.
    pointCount:      s32;
}

/// Cached separating axis feature.
b3SeparatingFeature :: enum u32 {
    invalidAxis        :: 0;
    backsideAxis       :: 1;
    faceAxisA          :: 2;
    faceAxisB          :: 3;
    edgePairAxis       :: 4;
    closestPointsAxis  :: 5;

    manualFaceAxisA    :: 6;
    manualFaceAxisB    :: 7;
    manualEdgePairAxis :: 8;

    b3_invalidAxis        :: invalidAxis;
    b3_backsideAxis       :: backsideAxis;
    b3_faceAxisA          :: faceAxisA;
    b3_faceAxisB          :: faceAxisB;
    b3_edgePairAxis       :: edgePairAxis;
    b3_closestPointsAxis  :: closestPointsAxis;

    b3_manualFaceAxisA    :: manualFaceAxisA;
    b3_manualFaceAxisB    :: manualFaceAxisB;
    b3_manualEdgePairAxis :: manualEdgePairAxis;
}

/// Cached triangle feature.
b3TriangleFeature :: enum u32 {
    featureNone         :: 0;
    featureTriangleFace :: 1;
    featureHullFace     :: 2;

    featureEdge1        :: 3;

    featureEdge2        :: 4;

    featureEdge3        :: 5;
    featureVertex1      :: 6;
    featureVertex2      :: 7;
    featureVertex3      :: 8;

    b3_featureNone         :: featureNone;
    b3_featureTriangleFace :: featureTriangleFace;
    b3_featureHullFace     :: featureHullFace;

    b3_featureEdge1        :: featureEdge1;

    b3_featureEdge2        :: featureEdge2;

    b3_featureEdge3        :: featureEdge3;
    b3_featureVertex1      :: featureVertex1;
    b3_featureVertex2      :: featureVertex2;
    b3_featureVertex3      :: featureVertex3;
}

/// Separating axis test cache. Provides temporal acceleration of collision routines.
b3SATCache :: struct {
    /// The separation when the cache is populated. Negative for overlap.
    separation: float;

    /// b3SeparatingFeature.
    type:       u8;

    /// Index of the feature on shape A.
    indexA:     u8;

    /// Index of the feature on shape B.
    indexB:     u8;

    /// Was the cache re-used?
    hit:        u8;
}

/// Contact points are always the result of two edges intersecting.
/// It can be two edges of the same shape, which is just a shape vertex.
/// Or a contact point can be the result of two edges crossing from different shapes.
/// This is designed to support hull versus hull, but it is adapted to work
/// with all shape types. The feature pair is used to identify contact points
/// for temporal coherence and warm starting.
b3FeaturePair :: struct {
    /// Incoming type (either edge on shape A or shape B)
    owner1: u8;

    /// Incoming edge index (into associated shape array)
    index1: u8;

    /// Outgoing type (either edge on shape A or shape B)
    owner2: u8;

    /// Outgoing edge index (into associated shape array)
    index2: u8;
}

/// A local manifold point and normal in frame A.
b3LocalManifoldPoint :: struct {
    /// Local point in frame A.
    point:         b3Vec3;

    /// The contact point separation. Negative for overlap.
    separation:    float;

    /// The feature pair for this point.
    pair:          b3FeaturePair;

    /// The triangle index when collide with a mesh or height-field.
    triangleIndex: s32;
}

/// A local manifold with no dynamic information. Used by b3Collide functions.
b3LocalManifold :: struct {
    /// Local normal in frame A.
    normal:          b3Vec3;

    /// The triangle normal.
    triangleNormal:  b3Vec3;

    /// The manifold points. From a point buffer.
    points:          *b3LocalManifoldPoint;

    /// The number of manifold points. Only bounded by the buffer capacity.
    pointCount:      s32;

    /// The index of the triangle.
    triangleIndex:   s32;

    i1:              s32; ///< Vertex 1 index.
    i2:              s32; ///< Vertex 2 index.
    i3:              s32; ///< Vertex 3 index.

    /// The squared distance of a sphere from a triangle. For ghost collision reduction.
    squaredDistance: float;

    /// The triangle feature involved.
    feature:         b3TriangleFeature;

    /// b3MeshEdgeFlags.
    triangleFlags:   s32;
}

/// These colors are used for debug draw and mostly match the named SVG colors.
/// See https://www.rapidtables.com/web/color/index.html
/// https://johndecember.com/html/spec/colorsvg.html
/// https://upload.wikimedia.org/wikipedia/commons/2/2b/SVG_Recognized_color_keyword_names.svg
b3HexColor :: enum u32 {
    colorAliceBlue            :: 15792383;
    colorAntiqueWhite         :: 16444375;
    colorAqua                 :: 65535;
    colorAquamarine           :: 8388564;
    colorAzure                :: 15794175;
    colorBeige                :: 16119260;
    colorBisque               :: 16770244;
    colorBlack                :: 0;
    colorBlanchedAlmond       :: 16772045;
    colorBlue                 :: 255;
    colorBlueViolet           :: 9055202;
    colorBrown                :: 10824234;
    colorBurlywood            :: 14596231;
    colorCadetBlue            :: 6266528;
    colorChartreuse           :: 8388352;
    colorChocolate            :: 13789470;
    colorCoral                :: 16744272;
    colorCornflowerBlue       :: 6591981;
    colorCornsilk             :: 16775388;
    colorCrimson              :: 14423100;
    colorCyan                 :: 65535;
    colorDarkBlue             :: 139;
    colorDarkCyan             :: 35723;
    colorDarkGoldenRod        :: 12092939;
    colorDarkGray             :: 11119017;
    colorDarkGreen            :: 25600;
    colorDarkKhaki            :: 12433259;
    colorDarkMagenta          :: 9109643;
    colorDarkOliveGreen       :: 5597999;
    colorDarkOrange           :: 16747520;
    colorDarkOrchid           :: 10040012;
    colorDarkRed              :: 9109504;
    colorDarkSalmon           :: 15308410;
    colorDarkSeaGreen         :: 9419919;
    colorDarkSlateBlue        :: 4734347;
    colorDarkSlateGray        :: 3100495;
    colorDarkTurquoise        :: 52945;
    colorDarkViolet           :: 9699539;
    colorDeepPink             :: 16716947;
    colorDeepSkyBlue          :: 49151;
    colorDimGray              :: 6908265;
    colorDodgerBlue           :: 2003199;
    colorFireBrick            :: 11674146;
    colorFloralWhite          :: 16775920;
    colorForestGreen          :: 2263842;
    colorFuchsia              :: 16711935;
    colorGainsboro            :: 14474460;
    colorGhostWhite           :: 16316671;
    colorGold                 :: 16766720;
    colorGoldenRod            :: 14329120;
    colorGray                 :: 8421504;
    colorGreen                :: 32768;
    colorGreenYellow          :: 11403055;
    colorHoneyDew             :: 15794160;
    colorHotPink              :: 16738740;
    colorIndianRed            :: 13458524;
    colorIndigo               :: 4915330;
    colorIvory                :: 16777200;
    colorKhaki                :: 15787660;
    colorLavender             :: 15132410;
    colorLavenderBlush        :: 16773365;
    colorLawnGreen            :: 8190976;
    colorLemonChiffon         :: 16775885;
    colorLightBlue            :: 11393254;
    colorLightCoral           :: 15761536;
    colorLightCyan            :: 14745599;
    colorLightGoldenRodYellow :: 16448210;
    colorLightGray            :: 13882323;
    colorLightGreen           :: 9498256;
    colorLightPink            :: 16758465;
    colorLightSalmon          :: 16752762;
    colorLightSeaGreen        :: 2142890;
    colorLightSkyBlue         :: 8900346;
    colorLightSlateGray       :: 7833753;
    colorLightSteelBlue       :: 11584734;
    colorLightYellow          :: 16777184;
    colorLime                 :: 65280;
    colorLimeGreen            :: 3329330;
    colorLinen                :: 16445670;
    colorMagenta              :: 16711935;
    colorMaroon               :: 8388608;
    colorMediumAquaMarine     :: 6737322;
    colorMediumBlue           :: 205;
    colorMediumOrchid         :: 12211667;
    colorMediumPurple         :: 9662683;
    colorMediumSeaGreen       :: 3978097;
    colorMediumSlateBlue      :: 8087790;
    colorMediumSpringGreen    :: 64154;
    colorMediumTurquoise      :: 4772300;
    colorMediumVioletRed      :: 13047173;
    colorMidnightBlue         :: 1644912;
    colorMintCream            :: 16121850;
    colorMistyRose            :: 16770273;
    colorMoccasin             :: 16770229;
    colorNavajoWhite          :: 16768685;
    colorNavy                 :: 128;
    colorOldLace              :: 16643558;
    colorOlive                :: 8421376;
    colorOliveDrab            :: 7048739;
    colorOrange               :: 16753920;
    colorOrangeRed            :: 16729344;
    colorOrchid               :: 14315734;
    colorPaleGoldenRod        :: 15657130;
    colorPaleGreen            :: 10025880;
    colorPaleTurquoise        :: 11529966;
    colorPaleVioletRed        :: 14381203;
    colorPapayaWhip           :: 16773077;
    colorPeachPuff            :: 16767673;
    colorPeru                 :: 13468991;
    colorPink                 :: 16761035;
    colorPlum                 :: 14524637;
    colorPowderBlue           :: 11591910;
    colorPurple               :: 8388736;
    colorRebeccaPurple        :: 6697881;
    colorRed                  :: 16711680;
    colorRosyBrown            :: 12357519;
    colorRoyalBlue            :: 4286945;
    colorSaddleBrown          :: 9127187;
    colorSalmon               :: 16416882;
    colorSandyBrown           :: 16032864;
    colorSeaGreen             :: 3050327;
    colorSeaShell             :: 16774638;
    colorSienna               :: 10506797;
    colorSilver               :: 12632256;
    colorSkyBlue              :: 8900331;
    colorSlateBlue            :: 6970061;
    colorSlateGray            :: 7372944;
    colorSnow                 :: 16775930;
    colorSpringGreen          :: 65407;
    colorSteelBlue            :: 4620980;
    colorTan                  :: 13808780;
    colorTeal                 :: 32896;
    colorThistle              :: 14204888;
    colorTomato               :: 16737095;
    colorTurquoise            :: 4251856;
    colorViolet               :: 15631086;
    colorWheat                :: 16113331;
    colorWhite                :: 16777215;
    colorWhiteSmoke           :: 16119285;
    colorYellow               :: 16776960;
    colorYellowGreen          :: 10145074;

    colorBox2DRed             :: 14430514;
    colorBox2DBlue            :: 3190463;
    colorBox2DGreen           :: 9226532;
    colorBox2DYellow          :: 16772748;

    b3_colorAliceBlue            :: colorAliceBlue;
    b3_colorAntiqueWhite         :: colorAntiqueWhite;
    b3_colorAqua                 :: colorAqua;
    b3_colorAquamarine           :: colorAquamarine;
    b3_colorAzure                :: colorAzure;
    b3_colorBeige                :: colorBeige;
    b3_colorBisque               :: colorBisque;
    b3_colorBlack                :: colorBlack;
    b3_colorBlanchedAlmond       :: colorBlanchedAlmond;
    b3_colorBlue                 :: colorBlue;
    b3_colorBlueViolet           :: colorBlueViolet;
    b3_colorBrown                :: colorBrown;
    b3_colorBurlywood            :: colorBurlywood;
    b3_colorCadetBlue            :: colorCadetBlue;
    b3_colorChartreuse           :: colorChartreuse;
    b3_colorChocolate            :: colorChocolate;
    b3_colorCoral                :: colorCoral;
    b3_colorCornflowerBlue       :: colorCornflowerBlue;
    b3_colorCornsilk             :: colorCornsilk;
    b3_colorCrimson              :: colorCrimson;
    b3_colorCyan                 :: colorCyan;
    b3_colorDarkBlue             :: colorDarkBlue;
    b3_colorDarkCyan             :: colorDarkCyan;
    b3_colorDarkGoldenRod        :: colorDarkGoldenRod;
    b3_colorDarkGray             :: colorDarkGray;
    b3_colorDarkGreen            :: colorDarkGreen;
    b3_colorDarkKhaki            :: colorDarkKhaki;
    b3_colorDarkMagenta          :: colorDarkMagenta;
    b3_colorDarkOliveGreen       :: colorDarkOliveGreen;
    b3_colorDarkOrange           :: colorDarkOrange;
    b3_colorDarkOrchid           :: colorDarkOrchid;
    b3_colorDarkRed              :: colorDarkRed;
    b3_colorDarkSalmon           :: colorDarkSalmon;
    b3_colorDarkSeaGreen         :: colorDarkSeaGreen;
    b3_colorDarkSlateBlue        :: colorDarkSlateBlue;
    b3_colorDarkSlateGray        :: colorDarkSlateGray;
    b3_colorDarkTurquoise        :: colorDarkTurquoise;
    b3_colorDarkViolet           :: colorDarkViolet;
    b3_colorDeepPink             :: colorDeepPink;
    b3_colorDeepSkyBlue          :: colorDeepSkyBlue;
    b3_colorDimGray              :: colorDimGray;
    b3_colorDodgerBlue           :: colorDodgerBlue;
    b3_colorFireBrick            :: colorFireBrick;
    b3_colorFloralWhite          :: colorFloralWhite;
    b3_colorForestGreen          :: colorForestGreen;
    b3_colorFuchsia              :: colorFuchsia;
    b3_colorGainsboro            :: colorGainsboro;
    b3_colorGhostWhite           :: colorGhostWhite;
    b3_colorGold                 :: colorGold;
    b3_colorGoldenRod            :: colorGoldenRod;
    b3_colorGray                 :: colorGray;
    b3_colorGreen                :: colorGreen;
    b3_colorGreenYellow          :: colorGreenYellow;
    b3_colorHoneyDew             :: colorHoneyDew;
    b3_colorHotPink              :: colorHotPink;
    b3_colorIndianRed            :: colorIndianRed;
    b3_colorIndigo               :: colorIndigo;
    b3_colorIvory                :: colorIvory;
    b3_colorKhaki                :: colorKhaki;
    b3_colorLavender             :: colorLavender;
    b3_colorLavenderBlush        :: colorLavenderBlush;
    b3_colorLawnGreen            :: colorLawnGreen;
    b3_colorLemonChiffon         :: colorLemonChiffon;
    b3_colorLightBlue            :: colorLightBlue;
    b3_colorLightCoral           :: colorLightCoral;
    b3_colorLightCyan            :: colorLightCyan;
    b3_colorLightGoldenRodYellow :: colorLightGoldenRodYellow;
    b3_colorLightGray            :: colorLightGray;
    b3_colorLightGreen           :: colorLightGreen;
    b3_colorLightPink            :: colorLightPink;
    b3_colorLightSalmon          :: colorLightSalmon;
    b3_colorLightSeaGreen        :: colorLightSeaGreen;
    b3_colorLightSkyBlue         :: colorLightSkyBlue;
    b3_colorLightSlateGray       :: colorLightSlateGray;
    b3_colorLightSteelBlue       :: colorLightSteelBlue;
    b3_colorLightYellow          :: colorLightYellow;
    b3_colorLime                 :: colorLime;
    b3_colorLimeGreen            :: colorLimeGreen;
    b3_colorLinen                :: colorLinen;
    b3_colorMagenta              :: colorMagenta;
    b3_colorMaroon               :: colorMaroon;
    b3_colorMediumAquaMarine     :: colorMediumAquaMarine;
    b3_colorMediumBlue           :: colorMediumBlue;
    b3_colorMediumOrchid         :: colorMediumOrchid;
    b3_colorMediumPurple         :: colorMediumPurple;
    b3_colorMediumSeaGreen       :: colorMediumSeaGreen;
    b3_colorMediumSlateBlue      :: colorMediumSlateBlue;
    b3_colorMediumSpringGreen    :: colorMediumSpringGreen;
    b3_colorMediumTurquoise      :: colorMediumTurquoise;
    b3_colorMediumVioletRed      :: colorMediumVioletRed;
    b3_colorMidnightBlue         :: colorMidnightBlue;
    b3_colorMintCream            :: colorMintCream;
    b3_colorMistyRose            :: colorMistyRose;
    b3_colorMoccasin             :: colorMoccasin;
    b3_colorNavajoWhite          :: colorNavajoWhite;
    b3_colorNavy                 :: colorNavy;
    b3_colorOldLace              :: colorOldLace;
    b3_colorOlive                :: colorOlive;
    b3_colorOliveDrab            :: colorOliveDrab;
    b3_colorOrange               :: colorOrange;
    b3_colorOrangeRed            :: colorOrangeRed;
    b3_colorOrchid               :: colorOrchid;
    b3_colorPaleGoldenRod        :: colorPaleGoldenRod;
    b3_colorPaleGreen            :: colorPaleGreen;
    b3_colorPaleTurquoise        :: colorPaleTurquoise;
    b3_colorPaleVioletRed        :: colorPaleVioletRed;
    b3_colorPapayaWhip           :: colorPapayaWhip;
    b3_colorPeachPuff            :: colorPeachPuff;
    b3_colorPeru                 :: colorPeru;
    b3_colorPink                 :: colorPink;
    b3_colorPlum                 :: colorPlum;
    b3_colorPowderBlue           :: colorPowderBlue;
    b3_colorPurple               :: colorPurple;
    b3_colorRebeccaPurple        :: colorRebeccaPurple;
    b3_colorRed                  :: colorRed;
    b3_colorRosyBrown            :: colorRosyBrown;
    b3_colorRoyalBlue            :: colorRoyalBlue;
    b3_colorSaddleBrown          :: colorSaddleBrown;
    b3_colorSalmon               :: colorSalmon;
    b3_colorSandyBrown           :: colorSandyBrown;
    b3_colorSeaGreen             :: colorSeaGreen;
    b3_colorSeaShell             :: colorSeaShell;
    b3_colorSienna               :: colorSienna;
    b3_colorSilver               :: colorSilver;
    b3_colorSkyBlue              :: colorSkyBlue;
    b3_colorSlateBlue            :: colorSlateBlue;
    b3_colorSlateGray            :: colorSlateGray;
    b3_colorSnow                 :: colorSnow;
    b3_colorSpringGreen          :: colorSpringGreen;
    b3_colorSteelBlue            :: colorSteelBlue;
    b3_colorTan                  :: colorTan;
    b3_colorTeal                 :: colorTeal;
    b3_colorThistle              :: colorThistle;
    b3_colorTomato               :: colorTomato;
    b3_colorTurquoise            :: colorTurquoise;
    b3_colorViolet               :: colorViolet;
    b3_colorWheat                :: colorWheat;
    b3_colorWhite                :: colorWhite;
    b3_colorWhiteSmoke           :: colorWhiteSmoke;
    b3_colorYellow               :: colorYellow;
    b3_colorYellowGreen          :: colorYellowGreen;

    b3_colorBox2DRed             :: colorBox2DRed;
    b3_colorBox2DBlue            :: colorBox2DBlue;
    b3_colorBox2DGreen           :: colorBox2DGreen;
    b3_colorBox2DYellow          :: colorBox2DYellow;
}

/// Debug draw material preset. Optionally packed into the unused high byte of a
/// b3HexColor (or b3SurfaceMaterial::customColor) to drive the renderer's PBR
/// roughness and metalness. The low 24 bits stay RGB, so a plain 0xRRGGBB color
/// reads as b3_debugMaterialDefault and keeps the renderer's per-body-type look.
b3DebugMaterial :: enum u32 {
    debugMaterialDefault  :: 0;
    debugMaterialMatte    :: 1;
    debugMaterialSoft     :: 2;
    debugMaterialDead     :: 3;
    debugMaterialGlossy   :: 4;
    debugMaterialMetallic :: 5;

    b3_debugMaterialDefault  :: debugMaterialDefault;
    b3_debugMaterialMatte    :: debugMaterialMatte;
    b3_debugMaterialSoft     :: debugMaterialSoft;
    b3_debugMaterialDead     :: debugMaterialDead;
    b3_debugMaterialGlossy   :: debugMaterialGlossy;
    b3_debugMaterialMetallic :: debugMaterialMetallic;
}

/// Get the visualization color assigned to a constraint graph color slot. The last index
/// (B3_GRAPH_COLOR_COUNT - 1) is the overflow color.
b3GetGraphColor :: (index: s32) -> b3HexColor #foreign box3d;

/// This is sent to the user for debug shape creation. The user should know the type in case they have
/// custom sphere or capsule rendering.
b3DebugShape :: struct {
    /// Shape id.
    shapeId: b3ShapeId;

    /// Shape type.
    type:    b3ShapeType;

    /// Tagged union.
    struct {
        capsule: *b3Capsule; ///< Capsule shape.

        #overlay (capsule) compound:    *b3CompoundData; ///< Compound shape.
        #overlay (capsule) heightField: *b3HeightFieldData; ///< Height-field shape.
        #overlay (capsule) hull:        *b3HullData; ///< Convex hull shape.
        #overlay (capsule) mesh:        *b3Mesh; ///< Mesh shape with scale.
        #overlay (capsule) sphere:      *b3Sphere; ///< Sphere shape.
    }
}

/// This struct is passed to b3World_Draw to draw a debug view of the simulation world.
/// Callbacks receive world coordinates. In large world mode the translation is double precision so
/// it stays accurate far from the origin. Shift into your own camera frame inside the callbacks.
b3DebugDraw :: struct {
    /// Draws a user shape. The userShape pointer is owned by the application and is known to Box3D as
    /// an opaque pointer returned from b3CreateDebugShapeCallback. When this is called the drawn shape has
    /// passed a culling test against drawingBounds below.
    DrawShapeFcn:        #type (userShape: *void, transform: b3WorldTransform, color: b3HexColor, _context: *void) -> void #c_call;

    /// Draw a line segment.
    DrawSegmentFcn:      #type (p1: b3Pos, p2: b3Pos, color: b3HexColor, _context: *void) -> void #c_call;

    /// Draw a transform. Choose your own length scale.
    DrawTransformFcn:    #type (transform: b3WorldTransform, _context: *void) -> void #c_call;

    /// Draw a point.
    DrawPointFcn:        #type (p: b3Pos, size: float, color: b3HexColor, _context: *void) -> void #c_call;

    /// Draw a sphere.
    DrawSphereFcn:       #type (p: b3Pos, radius: float, color: b3HexColor, alpha: float, _context: *void) -> void #c_call;

    /// Draw a capsule.
    DrawCapsuleFcn:      #type (p1: b3Pos, p2: b3Pos, radius: float, color: b3HexColor, alpha: float, _context: *void) -> void #c_call;

    /// Draw a bounding box.
    DrawBoundsFcn:       #type (aabb: b3AABB, color: b3HexColor, _context: *void) -> void #c_call;

    /// Draw an oriented box.
    DrawBoxFcn:          #type (extents: b3Vec3, transform: b3WorldTransform, color: b3HexColor, _context: *void) -> void #c_call;

    /// Draw a string in world space
    DrawStringFcn:       #type (p: b3Pos, s: *u8, color: b3HexColor, _context: *void) -> void #c_call;

    /// World bounds to use for debug draw
    drawingBounds:       b3AABB;

    /// Scale to use when drawing forces
    forceScale:          float;

    /// Global scaling for joint drawing
    jointScale:          float;

    /// Option to draw shapes
    drawShapes:          bool;

    /// Option to draw joints
    drawJoints:          bool;

    /// Option to draw additional information for joints
    drawJointExtras:     bool;

    /// Option to draw the bounding boxes for shapes
    drawBounds:          bool;

    /// Option to draw the mass and center of mass of dynamic bodies
    drawMass:            bool;

    /// Option to draw the sleep information for dynamic and kinematic bodies
    drawSleep:           bool;

    /// Option to draw body names
    drawBodyNames:       bool;

    /// Option to draw contact points
    drawContacts:        bool;

    /// Draw contact anchor A or B
    drawAnchorA:         bool;

    /// Option to visualize the graph coloring used for contacts and joints
    drawGraphColors:     bool;

    /// Option to draw contact features
    drawContactFeatures: bool;

    /// Option to draw contact normals
    drawContactNormals:  bool;

    /// Option to draw contact normal forces
    drawContactForces:   bool;

    /// Option to draw islands as bounding boxes
    drawIslands:         bool;

    /// User context that is passed as an argument to drawing callback functions
    _context:            *void;
}

/// Create a debug draw struct with default values.
b3DefaultDebugDraw :: () -> b3DebugDraw #foreign box3d;

/// Constructing the tree initializes the node pool.
b3DynamicTree_Create :: (proxyCapacity: s32) -> b3DynamicTree #foreign box3d;

/// Destroy the tree, freeing the node pool.
b3DynamicTree_Destroy :: (tree: *b3DynamicTree) -> void #foreign box3d;

/// Create a proxy. Provide an AABB and a userData value.
b3DynamicTree_CreateProxy :: (tree: *b3DynamicTree, aabb: b3AABB, categoryBits: u64, userData: u64) -> s32 #foreign box3d;

/// Destroy a proxy. This asserts if the id is invalid.
b3DynamicTree_DestroyProxy :: (tree: *b3DynamicTree, proxyId: s32) -> void #foreign box3d;

/// Move a proxy to a new AABB by removing and reinserting into the tree.
b3DynamicTree_MoveProxy :: (tree: *b3DynamicTree, proxyId: s32, aabb: b3AABB) -> void #foreign box3d;

/// Enlarge a proxy and enlarge ancestors as necessary.
b3DynamicTree_EnlargeProxy :: (tree: *b3DynamicTree, proxyId: s32, aabb: b3AABB) -> void #foreign box3d;

/// Modify the category bits on a proxy. This is an expensive operation.
b3DynamicTree_SetCategoryBits :: (tree: *b3DynamicTree, proxyId: s32, categoryBits: u64) -> void #foreign box3d;

/// Get the category bits on a proxy.
b3DynamicTree_GetCategoryBits :: (tree: *b3DynamicTree, proxyId: s32) -> u64 #foreign box3d;

/// Query an AABB for overlapping proxies. The callback function is called for each proxy that overlaps the supplied AABB.
///	@return performance data
b3DynamicTree_Query :: (tree: *b3DynamicTree, aabb: b3AABB, maskBits: u64, requireAllBits: bool, callback: b3TreeQueryCallbackFcn, _context: *void) -> b3TreeStats #foreign box3d;

/// Query an AABB for the closest object. The callback function is called for each proxy that might be closest to the supplied
/// point.
/// @param tree the dynamic tree to query
/// @param point the query point
/// @param maskBits nodes are skipped if the bit-wise AND with the node category bits is zero
/// @param requireAllBits nodes are skipped if the bit-wise AND with the node category bits does not equal the maskBits
/// @param callback a user provided instance of b3TreeQueryClosestCallbackFcn
/// @param context a user context object that is provided to the callback
/// @param minDistanceSqr the initial and final minimum squared distance. Provide a small initial to restrict the search and
/// improve performance. If the value is large this query has performance that scales linearly with the number of proxies and
/// would be slower than a brute force search.
///	@return performance data
b3DynamicTree_QueryClosest :: (tree: *b3DynamicTree, point: b3Vec3, maskBits: u64, requireAllBits: bool, callback: b3TreeQueryClosestCallbackFcn, _context: *void, minDistanceSqr: *float) -> b3TreeStats #foreign box3d;

/// Ray cast against the proxies in the tree. This relies on the callback
/// to perform an exact ray cast in the case where the proxy contains a shape.
/// The callback also performs any collision filtering. This has performance
/// roughly equal to k * log(n), where k is the number of collisions and n is the
/// number of proxies in the tree.
/// Bit-wise filtering using mask bits can greatly improve performance in some scenarios.
///	However, this filtering may be approximate, so the user should still apply filtering to results.
/// @param tree the dynamic tree to ray cast
/// @param input the ray cast input data. The ray extends from p1 to p1 + maxFraction * (p2 - p1)
/// @param maskBits bit mask test: `bool accept = (maskBits & node->categoryBits) != 0;`
/// @param requireAllBits modifies bit mask test: `bool accept = (maskBits & node->categoryBits) == maskBits;`
/// @param callback a callback function that is called for each proxy that is hit by the ray
/// @param context user context that is passed to the callback
///	@return performance data
b3DynamicTree_RayCast :: (tree: *b3DynamicTree, input: *b3RayCastInput, maskBits: u64, requireAllBits: bool, callback: b3TreeRayCastCallbackFcn, _context: *void) -> b3TreeStats #foreign box3d;

/// Sweep an AABB through the tree. The box is in the tree's world float frame and the callback
/// re-differences each shape at full precision against the query origin. Used by the large world
/// spatial queries so the tree traversal stays float while the narrow phase stays precise.
b3DynamicTree_BoxCast :: (tree: *b3DynamicTree, input: *b3BoxCastInput, maskBits: u64, requireAllBits: bool, callback: b3TreeBoxCastCallbackFcn, _context: *void) -> b3TreeStats #foreign box3d;

/// Get the height of the binary tree.
b3DynamicTree_GetHeight :: (tree: *b3DynamicTree) -> s32 #foreign box3d;

/// Get the ratio of the sum of the node areas to the root area.
b3DynamicTree_GetAreaRatio :: (tree: *b3DynamicTree) -> float #foreign box3d;

/// Get the bounding box that contains the entire tree
b3DynamicTree_GetRootBounds :: (tree: *b3DynamicTree) -> b3AABB #foreign box3d;

/// Get the number of proxies created
b3DynamicTree_GetProxyCount :: (tree: *b3DynamicTree) -> s32 #foreign box3d;

/// Rebuild the tree while retaining subtrees that haven't changed. Returns the number of boxes sorted.
b3DynamicTree_Rebuild :: (tree: *b3DynamicTree, fullBuild: bool) -> s32 #foreign box3d;

/// Get the number of bytes used by this tree
b3DynamicTree_GetByteCount :: (tree: *b3DynamicTree) -> s32 #foreign box3d;

/// Validate this tree. For testing.
b3DynamicTree_Validate :: (tree: *b3DynamicTree) -> void #foreign box3d;

/// Validate this tree has no enlarged AABBs. For testing.
b3DynamicTree_ValidateNoEnlarged :: (tree: *b3DynamicTree) -> void #foreign box3d;

/// Save this tree to a file for debugging
b3DynamicTree_Save :: (tree: *b3DynamicTree, fileName: *u8) -> void #foreign box3d;

/// Load a file for debugging
b3DynamicTree_Load :: (fileName: *u8, scale: float) -> b3DynamicTree #foreign box3d;

/// Create a tessellated cylinder as a hull.
b3CreateCylinder :: (height: float, radius: float, yOffset: float, sides: s32) -> *b3HullData #foreign box3d;

/// Create a tessellated cone as a hull.
b3CreateCone :: (height: float, radius1: float, radius2: float, slices: s32) -> *b3HullData #foreign box3d;

/// Create a rock shaped hull.
b3CreateRock :: (radius: float) -> *b3HullData #foreign box3d;

/// Create a generic convex hull.
b3CreateHull :: (points: *b3Vec3, pointCount: s32, maxVertexCount: s32) -> *b3HullData #foreign box3d;

/// Deep clone a hull.
b3CloneHull :: (hull: *b3HullData) -> *b3HullData #foreign box3d;

/// Clone and transform a hull. Supports non-uniform and mirroring scale.
b3CloneAndTransformHull :: (original: *b3HullData, transform: b3Transform, scale: b3Vec3) -> *b3HullData #foreign box3d;

/// Destroy a hull.
b3DestroyHull :: (hull: *b3HullData) -> void #foreign box3d;

/// Make a cube as a hull. Do not call b3DestroyHull on this.
b3MakeCubeHull :: (halfWidth: float) -> b3BoxHull #foreign box3d;

/// Make a box as a hull. Do not call b3DestroyHull on this.
b3MakeBoxHull :: (hx: float, hy: float, hz: float) -> b3BoxHull #foreign box3d;

/// Make an offset box as a hull. Do not call b3DestroyHull on this.
b3MakeOffsetBoxHull :: (hx: float, hy: float, hz: float, offset: b3Vec3) -> b3BoxHull #foreign box3d;

/// Make a transformed box as a hull. Do not call b3DestroyHull on this.
/// @param hx, hy, hz positive half widths
/// @param transform local transform of box
b3MakeTransformedBoxHull :: (hx: float, hy: float, hz: float, transform: b3Transform) -> b3BoxHull #foreign box3d;

/// This makes a transformed box hull with post scaling. This is useful for boxes that are scaled in
/// a level editor. Such scaling can have reflection and shear. In the case of shear the result
/// may be approximate. If you need to support shear consider using b3CreateHull.
/// Do not call b3DestroyHull on this.
/// @param halfWidths positive half widths
/// @param transform local transform of box
/// @param postScale scale applied after the transform, may be negative
b3MakeScaledBoxHull :: (halfWidths: b3Vec3, transform: b3Transform, postScale: b3Vec3) -> b3BoxHull #foreign box3d;

/// This takes a box with a transform and post scale and converts it into a box with the post scale
/// resolved with new half-widths and transform. This accepts non-uniform and negative scale.
/// This is approximate if there is shear.
/// @param halfWidths [in/out] the box half widths
/// @param transform [in/out] the box transform with rotation and translation
/// @param postScale the post scale being applied to the box after the transform
/// @param minHalfWidth the minimum half width after scale is applied
b3ScaleBox :: (halfWidths: *b3Vec3, transform: *b3Transform, postScale: b3Vec3, minHalfWidth: float) -> void #foreign box3d;

/// Create a grid mesh along the x and z axes.
/// @param xCount the number of rows in the x direction
/// @param zCount the number of rows in the z direction
/// @param cellWidth the width of each cell
/// @param materialCount the number of materials to generate
/// @param identifyEdges compute adjacency information
b3CreateGridMesh :: (xCount: s32, zCount: s32, cellWidth: float, materialCount: s32, identifyEdges: bool) -> *b3MeshData #foreign box3d;

/// Create a wave mesh along the x and z axes.
b3CreateWaveMesh :: (xCount: s32, zCount: s32, cellWidth: float, amplitude: float, rowFrequency: float, columnFrequency: float) -> *b3MeshData #foreign box3d;

/// Create a torus mesh.
b3CreateTorusMesh :: (radialResolution: s32, tubularResolution: s32, radius: float, thickness: float) -> *b3MeshData #foreign box3d;

/// Create a box mesh.
b3CreateBoxMesh :: (center: b3Vec3, extent: b3Vec3, identifyEdges: bool) -> *b3MeshData #foreign box3d;

/// Create a hollow box mesh.
b3CreateHollowBoxMesh :: (center: b3Vec3, extent: b3Vec3) -> *b3MeshData #foreign box3d;

/// Create a platform mesh. A truncated pyramid.
b3CreatePlatformMesh :: (center: b3Vec3, height: float, topWidth: float, bottomWidth: float) -> *b3MeshData #foreign box3d;

/// Create a generic mesh.
b3CreateMesh :: (def: *b3MeshDef, degenerateTriangleIndices: *s32, degenerateCapacity: s32) -> *b3MeshData #foreign box3d;

/// Destroy a mesh.
b3DestroyMesh :: (mesh: *b3MeshData) -> void #foreign box3d;

/// Get the height of the mesh BVH.
b3GetHeight :: (mesh: *b3MeshData) -> s32 #foreign box3d;

/// Create a generic height field.
b3CreateHeightField :: (data: *b3HeightFieldDef) -> *b3HeightFieldData #foreign box3d;

/// Create a grid as a height field.
b3CreateGrid :: (rowCount: s32, columnCount: s32, scale: b3Vec3, makeHoles: bool) -> *b3HeightFieldData #foreign box3d;

/// Create a wave grid as a height field.
b3CreateWave :: (rowCount: s32, columnCount: s32, scale: b3Vec3, rowFrequency: float, columnFrequency: float, makeHoles: bool) -> *b3HeightFieldData #foreign box3d;

/// Destroy a height field.
b3DestroyHeightField :: (heightField: *b3HeightFieldData) -> void #foreign box3d;

/// Save input height data to a file
b3DumpHeightData :: (data: *b3HeightFieldDef, fileName: *u8) -> void #foreign box3d;

/// Create a height field by loading a previously saved height data
b3LoadHeightField :: (fileName: *u8) -> *b3HeightFieldData #foreign box3d;

/// Get a child shape of a compound.
b3GetCompoundChild :: (compound: *b3CompoundData, childIndex: s32) -> b3ChildShape #foreign box3d;

/// Query a compound shape for children that overlap an AABB.
b3QueryCompound :: (compound: *b3CompoundData, aabb: b3AABB, fcn: b3CompoundQueryFcn, _context: *void) -> void #foreign box3d;

/// Access a child capsule by index.
b3GetCompoundCapsule :: (compound: *b3CompoundData, index: s32) -> b3CompoundCapsule #foreign box3d;

/// Access a child hull by index.
b3GetCompoundHull :: (compound: *b3CompoundData, index: s32) -> b3CompoundHull #foreign box3d;

/// Access a child mesh by index.
b3GetCompoundMesh :: (compound: *b3CompoundData, index: s32) -> b3CompoundMesh #foreign box3d;

/// Access a child sphere by index.
b3GetCompoundSphere :: (compound: *b3CompoundData, index: s32) -> b3CompoundSphere #foreign box3d;

/// Access the compound material array.
b3GetCompoundMaterials :: (compound: *b3CompoundData) -> *b3SurfaceMaterial #foreign box3d;

/// Create a compound shape. All input data in the definition is cloned into the resulting compound.
b3CreateCompound :: (def: *b3CompoundDef) -> *b3CompoundData #foreign box3d;

/// Destroy a compound shape.
b3DestroyCompound :: (compound: *b3CompoundData) -> void #foreign box3d;

/// Cast the provided compound data to bytes, setting the internal pointers to null.
/// Use this before serializing the compound bytes.
b3ConvertCompoundToBytes :: (compound: *b3CompoundData) -> *u8 #foreign box3d;

/// Cast the provided bytes to compound data, setting up internal pointers.
/// Use this after de-serializing the compound bytes.
b3ConvertBytesToCompound :: (bytes: *u8, byteCount: s32) -> *b3CompoundData #foreign box3d;

/// Compute mass properties of a sphere
b3ComputeSphereMass :: (shape: *b3Sphere, density: float) -> b3MassData #foreign box3d;

/// Compute mass properties of a capsule
b3ComputeCapsuleMass :: (shape: *b3Capsule, density: float) -> b3MassData #foreign box3d;

/// Compute mass properties of a hull
b3ComputeHullMass :: (shape: *b3HullData, density: float) -> b3MassData #foreign box3d;

/// Compute the bounding box of a transformed sphere
b3ComputeSphereAABB :: (shape: *b3Sphere, transform: b3Transform) -> b3AABB #foreign box3d;

/// Compute the bounding box of a transformed capsule
b3ComputeCapsuleAABB :: (shape: *b3Capsule, transform: b3Transform) -> b3AABB #foreign box3d;

/// Compute the bounding box of a transformed hull
b3ComputeHullAABB :: (shape: *b3HullData, transform: b3Transform) -> b3AABB #foreign box3d;

/// Compute the bounding box of a transformed mesh. Scale may be non-uniform and have negative components.
b3ComputeMeshAABB :: (shape: *b3MeshData, transform: b3Transform, scale: b3Vec3) -> b3AABB #foreign box3d;

/// Compute the bounding box of a transformed height-field
b3ComputeHeightFieldAABB :: (shape: *b3HeightFieldData, transform: b3Transform) -> b3AABB #foreign box3d;

/// Compute the bounding box of a compound
b3ComputeCompoundAABB :: (shape: *b3CompoundData, transform: b3Transform) -> b3AABB #foreign box3d;

/// Use this to ensure your ray cast input is valid and avoid internal assertions.
b3IsValidRay :: (input: *b3RayCastInput) -> bool #foreign box3d;

/// Overlap shape versus capsule
b3OverlapCapsule :: (shape: *b3Capsule, shapeTransform: b3Transform, proxy: *b3ShapeProxy) -> bool #foreign box3d;

/// Overlap shape versus compound
b3OverlapCompound :: (shape: *b3CompoundData, shapeTransform: b3Transform, proxy: *b3ShapeProxy) -> bool #foreign box3d;

/// Overlap shape versus height field
b3OverlapHeightField :: (shape: *b3HeightFieldData, shapeTransform: b3Transform, proxy: *b3ShapeProxy) -> bool #foreign box3d;

/// Overlap shape versus hull
b3OverlapHull :: (shape: *b3HullData, shapeTransform: b3Transform, proxy: *b3ShapeProxy) -> bool #foreign box3d;

/// Overlap shape versus mesh
b3OverlapMesh :: (shape: *b3Mesh, shapeTransform: b3Transform, proxy: *b3ShapeProxy) -> bool #foreign box3d;

/// Overlap shape versus sphere
b3OverlapSphere :: (shape: *b3Sphere, shapeTransform: b3Transform, proxy: *b3ShapeProxy) -> bool #foreign box3d;

/// Ray cast versus sphere in local space. A zero length ray is a point query. Initial overlap
/// reports a hit at the ray origin with zero fraction and zero normal.
b3RayCastSphere :: (shape: *b3Sphere, input: *b3RayCastInput) -> b3CastOutput #foreign box3d;

/// Ray cast versus a hollow sphere shell in local space. Unlike the solid sphere a ray starting
/// inside is not an overlap: it passes through and hits the far wall.
b3RayCastHollowSphere :: (shape: *b3Sphere, input: *b3RayCastInput) -> b3CastOutput #foreign box3d;

/// Ray cast versus capsule in local space. A zero length ray is a point query. Initial overlap
/// reports a hit at the ray origin with zero fraction and zero normal.
b3RayCastCapsule :: (shape: *b3Capsule, input: *b3RayCastInput) -> b3CastOutput #foreign box3d;

/// Ray cast versus compound in local space. A zero length ray is a point query. Initial overlap
/// with a child reports a hit at the ray origin with zero fraction and zero normal.
b3RayCastCompound :: (shape: *b3CompoundData, input: *b3RayCastInput) -> b3CastOutput #foreign box3d;

/// Ray cast versus hull shape in local space. A zero length ray is a point query. Initial overlap
/// reports a hit at the ray origin with zero fraction and zero normal.
b3RayCastHull :: (shape: *b3HullData, input: *b3RayCastInput) -> b3CastOutput #foreign box3d;

/// Ray cast versus mesh in local space. A thin surface with no interior, so there is no overlap case.
b3RayCastMesh :: (shape: *b3Mesh, input: *b3RayCastInput) -> b3CastOutput #foreign box3d;

/// Ray cast versus height field in local space. A thin surface with no interior, so there is no overlap case.
b3RayCastHeightField :: (shape: *b3HeightFieldData, input: *b3RayCastInput) -> b3CastOutput #foreign box3d;

/// Shape cast versus a sphere. Initial overlap is treated as a miss.
b3ShapeCastSphere :: (shape: *b3Sphere, input: *b3ShapeCastInput) -> b3CastOutput #foreign box3d;

/// Shape cast versus a capsule. Initial overlap is treated as a miss.
b3ShapeCastCapsule :: (shape: *b3Capsule, input: *b3ShapeCastInput) -> b3CastOutput #foreign box3d;

/// Shape cast versus compound. Initial overlap is treated as a miss.
b3ShapeCastCompound :: (shape: *b3CompoundData, input: *b3ShapeCastInput) -> b3CastOutput #foreign box3d;

/// Shape cast versus a hull. Initial overlap is treated as a miss.
b3ShapeCastHull :: (shape: *b3HullData, input: *b3ShapeCastInput) -> b3CastOutput #foreign box3d;

/// Shape cast versus a mesh. Initial overlap is treated as a miss.
b3ShapeCastMesh :: (shape: *b3Mesh, input: *b3ShapeCastInput) -> b3CastOutput #foreign box3d;

/// Shape cast versus a height field. Initial overlap is treated as a miss.
b3ShapeCastHeightField :: (shape: *b3HeightFieldData, input: *b3ShapeCastInput) -> b3CastOutput #foreign box3d;

/// Query callback.
b3MeshQueryFcn :: #type (a: b3Vec3, b: b3Vec3, c: b3Vec3, triangleIndex: s32, _context: *void) -> bool #c_call;

/// Query a mesh for triangles overlapping a bounding box in local space. May have false positives. Useful for debug draw.
/// @param mesh the mesh to query, includes scale
/// @param bounds the bounding box in local space
/// @param fcn a user function to collect triangles
/// @param context the context sent to the user function.
b3QueryMesh :: (mesh: *b3Mesh, bounds: b3AABB, fcn: b3MeshQueryFcn, _context: *void) -> void #foreign box3d;

/// Query a height field for triangles overlapping a bounding box in local space. May have false positives. Useful for debug draw.
/// @param heightField the height field to query
/// @param bounds the bounding box in local space
/// @param fcn a user function to collect triangles
/// @param context the context sent to the user function.
b3QueryHeightField :: (heightField: *b3HeightFieldData, bounds: b3AABB, fcn: b3MeshQueryFcn, _context: *void) -> void #foreign box3d;

/// Compute the closest points between two shapes represented as point clouds.
/// b3SimplexCache cache is input/output. On the first call set b3SimplexCache.count to zero.
/// The query runs in frame A, so the witness points and normal are returned in frame A.
/// The underlying GJK algorithm may be debugged by passing in debug simplexes and capacity. You may pass in NULL and 0 for these.
b3ShapeDistance :: (input: *b3DistanceInput, cache: *b3SimplexCache, simplexes: *b3Simplex, simplexCapacity: s32) -> b3DistanceOutput #foreign box3d;

/// Perform a linear shape cast of shape B moving and shape A fixed. Determines the hit point, normal, and translation fraction.
/// The query runs in frame A, so the hit point and normal are returned in frame A. Initially touching shapes are a miss.
b3ShapeCast :: (input: *b3ShapeCastPairInput) -> b3CastOutput #foreign box3d;

/// Evaluate the transform sweep at a specific time.
b3GetSweepTransform :: (sweep: *b3Sweep, time: float) -> b3Transform #foreign box3d;

/// Compute the upper bound on time before two shapes penetrate. Time is represented as
/// a fraction between [0,tMax]. This uses a swept separating axis and may miss some intermediate,
/// non-tunneling collisions. If you change the time interval, you should call this function
/// again.
b3TimeOfImpact :: (input: *b3TOIInput) -> b3TOIOutput #foreign box3d;

/// Collide two spheres.
b3CollideSpheres :: (manifold: *b3LocalManifold, capacity: s32, sphereA: *b3Sphere, sphereB: *b3Sphere, transformBtoA: b3Transform) -> void #foreign box3d;

/// Collide a capsule and a sphere.
b3CollideCapsuleAndSphere :: (manifold: *b3LocalManifold, capacity: s32, capsuleA: *b3Capsule, sphereB: *b3Sphere, transformBtoA: b3Transform) -> void #foreign box3d;

/// Collide a hull and a sphere.
b3CollideHullAndSphere :: (manifold: *b3LocalManifold, capacity: s32, hullA: *b3HullData, sphereB: *b3Sphere, transformBtoA: b3Transform, cache: *b3SimplexCache) -> void #foreign box3d;

/// Collide two capsules.
b3CollideCapsules :: (manifold: *b3LocalManifold, capacity: s32, capsuleA: *b3Capsule, capsuleB: *b3Capsule, transformBtoA: b3Transform) -> void #foreign box3d;

/// Collide a hull and a capsule.
b3CollideHullAndCapsule :: (manifold: *b3LocalManifold, capacity: s32, hullA: *b3HullData, capsuleB: *b3Capsule, transformBtoA: b3Transform, cache: *b3SimplexCache) -> void #foreign box3d;

/// Collide two hulls.
b3CollideHulls :: (manifold: *b3LocalManifold, capacity: s32, hullA: *b3HullData, hullB: *b3HullData, transformBtoA: b3Transform, cache: *b3SATCache) -> void #foreign box3d;

/// Collide a triangle and capsule. Normal points from triangle to capsule.
b3CollideTriangleAndCapsule :: (manifold: *b3LocalManifold, capacity: s32, triangleA: *b3Vec3, capsuleB: *b3Capsule, cache: *b3SimplexCache) -> void #foreign box3d;

/// Collide a triangle and hull. Normal points from triangle to hull.
b3CollideTriangleAndHull :: (manifold: *b3LocalManifold, capacity: s32, v1: b3Vec3, v2: b3Vec3, v3: b3Vec3, triangleFlags: s32, hullB: *b3HullData, cache: *b3SATCache, enableSpeculative: bool) -> void #foreign box3d;

/// Collide a triangle and sphere. Normal points from triangle to sphere.
b3CollideTriangleAndSphere :: (manifold: *b3LocalManifold, capacity: s32, triangleA: *b3Vec3, sphereB: *b3Sphere) -> void #foreign box3d;

/// Solves the position of a mover that satisfies the given collision planes.
/// @param targetDelta the desired translation from the position used to generate the collision planes
/// @param planes the collision planes
/// @param count the number of collision planes
b3SolvePlanes :: (targetDelta: b3Vec3, planes: *b3CollisionPlane, count: s32) -> b3PlaneSolverResult #foreign box3d;

/// Clips the velocity against the given collision planes. Planes with zero push or clipVelocity
/// set to false are skipped.
b3ClipVector :: (vector: b3Vec3, planes: *b3CollisionPlane, count: s32) -> b3Vec3 #foreign box3d;

/// Create a world for rigid body simulation. A world contains bodies, shapes, and constraints. You may create
/// up to 128 worlds. Each world is completely independent and may be simulated in parallel.
/// @return the world id.
b3CreateWorld :: (def: *b3WorldDef) -> b3WorldId #foreign box3d;

/// Destroy a world
b3DestroyWorld :: (worldId: b3WorldId) -> void #foreign box3d;

/// Get the current number of worlds
b3GetWorldCount :: () -> s32 #foreign box3d;

/// Get the maximum number of simultaneous worlds that have been created
b3GetMaxWorldCount :: () -> s32 #foreign box3d;

/// World id validation. Provides validation for up to 64K allocations.
b3World_IsValid :: (id: b3WorldId) -> bool #foreign box3d;

/// Simulate a world for one time step. This performs collision detection, integration, and constraint solution.
/// @param worldId The world to simulate
/// @param timeStep The amount of time to simulate, this should be a fixed number. Usually 1/60.
/// @param subStepCount The number of sub-steps, increasing the sub-step count can increase accuracy. Usually 4.
b3World_Step :: (worldId: b3WorldId, timeStep: float, subStepCount: s32) -> void #foreign box3d;

/// Call this to draw shapes and other debug draw data
b3World_Draw :: (worldId: b3WorldId, draw: *b3DebugDraw, maskBits: u64) -> void #foreign box3d;

/// Get the world's bounds. This is the bounding box that covers the current simulation. May have a small
/// amount of padding.
b3World_GetBounds :: (worldId: b3WorldId) -> b3AABB #foreign box3d;

/// Get the body events for the current time step. The event data is transient. Do not store a reference to this data.
b3World_GetBodyEvents :: (worldId: b3WorldId) -> b3BodyEvents #foreign box3d;

/// Get sensor events for the current time step. The event data is transient. Do not store a reference to this data.
b3World_GetSensorEvents :: (worldId: b3WorldId) -> b3SensorEvents #foreign box3d;

/// Get contact events for this current time step. The event data is transient. Do not store a reference to this data.
b3World_GetContactEvents :: (worldId: b3WorldId) -> b3ContactEvents #foreign box3d;

/// Get the joint events for the current time step. The event data is transient. Do not store a reference to this data.
b3World_GetJointEvents :: (worldId: b3WorldId) -> b3JointEvents #foreign box3d;

/// Overlap test for all shapes that *potentially* overlap the provided AABB
b3World_OverlapAABB :: (worldId: b3WorldId, aabb: b3AABB, filter: b3QueryFilter, fcn: b3OverlapResultFcn, _context: *void) -> b3TreeStats #foreign box3d;

/// Overlap test for all shapes that overlap the provided shape proxy. The proxy points are relative
/// to the world origin, which lets the query stay precise far from the world origin.
b3World_OverlapShape :: (worldId: b3WorldId, origin: b3Pos, proxy: *b3ShapeProxy, filter: b3QueryFilter, fcn: b3OverlapResultFcn, _context: *void) -> b3TreeStats #foreign box3d;

/// Cast a ray into the world to collect shapes in the path of the ray.
/// Your callback function controls whether you get the closest point, any point, or n-points.
/// @note The callback function may receive shapes in any order
/// @param worldId The world to cast the ray against
/// @param origin The start point of the ray
/// @param translation The translation of the ray from the start point to the end point
/// @param filter Contains bit flags to filter unwanted shapes from the results
/// @param fcn A user implemented callback function
/// @param context A user context that is passed along to the callback function
///	@return traversal performance counters
b3World_CastRay :: (worldId: b3WorldId, origin: b3Pos, translation: b3Vec3, filter: b3QueryFilter, fcn: b3CastResultFcn, _context: *void) -> b3TreeStats #foreign box3d;

/// Cast a ray into the world to collect the closest hit. This is a convenience function. Ignores initial overlap.
/// This is less general than b3World_CastRay() and does not allow for custom filtering.
b3World_CastRayClosest :: (worldId: b3WorldId, origin: b3Pos, translation: b3Vec3, filter: b3QueryFilter) -> b3RayResult #foreign box3d;

/// Cast a shape through the world. Similar to a cast ray except that a shape is cast instead of a point.
/// The proxy points are relative to the origin and the hit points come back as world positions, so the
/// cast stays precise far from the world origin.
///	@see b3World_CastRay
b3World_CastShape :: (worldId: b3WorldId, origin: b3Pos, proxy: *b3ShapeProxy, translation: b3Vec3, filter: b3QueryFilter, fcn: b3CastResultFcn, _context: *void) -> b3TreeStats #foreign box3d;

/// Cast a capsule mover through the world. This is a special shape cast that handles sliding along other shapes while reducing
/// clipping. This is not a good source of information about what the mover is touching. Instead use the planes returned by
/// b3World_CollideMover.
/// @param worldId World to cast the mover against
/// @param origin World position the mover capsule is relative to
/// @param mover Capsule mover, relative to the origin
/// @param translation Desired mover translation
/// @param filter Contains bit flags to filter unwanted shapes from the results
/// @param fcn Optional callback for custom shape filtering
/// @param context A user context that is passed along to the callback function
/// @return the translation fraction
b3World_CastMover :: (worldId: b3WorldId, origin: b3Pos, mover: *b3Capsule, translation: b3Vec3, filter: b3QueryFilter, fcn: b3MoverFilterFcn, _context: *void) -> float #foreign box3d;

/// Collide a capsule mover with the world, gathering collision planes that can be fed to b3SolvePlanes. Useful for
/// kinematic character movement. The mover and the returned planes are relative to the origin.
b3World_CollideMover :: (worldId: b3WorldId, origin: b3Pos, mover: *b3Capsule, filter: b3QueryFilter, fcn: b3PlaneResultFcn, _context: *void) -> void #foreign box3d;

/// Enable/disable sleep. If your application does not need sleeping, you can gain some performance
/// by disabling sleep completely at the world level.
/// @see b3WorldDef
b3World_EnableSleeping :: (worldId: b3WorldId, flag: bool) -> void #foreign box3d;

/// Is body sleeping enabled?
b3World_IsSleepingEnabled :: (worldId: b3WorldId) -> bool #foreign box3d;

/// Enable/disable continuous collision between dynamic and static bodies. Generally you should keep continuous
/// collision enabled to prevent fast moving objects from going through static objects. The performance gain from
/// disabling continuous collision is minor.
/// @see b3WorldDef
b3World_EnableContinuous :: (worldId: b3WorldId, flag: bool) -> void #foreign box3d;

/// Is continuous collision enabled?
b3World_IsContinuousEnabled :: (worldId: b3WorldId) -> bool #foreign box3d;

/// Adjust the restitution threshold. It is recommended not to make this value very small
/// because it will prevent bodies from sleeping. Usually in meters per second.
/// @see b3WorldDef
b3World_SetRestitutionThreshold :: (worldId: b3WorldId, value: float) -> void #foreign box3d;

/// Get the restitution speed threshold. Usually in meters per second.
b3World_GetRestitutionThreshold :: (worldId: b3WorldId) -> float #foreign box3d;

/// Adjust the hit event threshold. This controls the collision speed needed to generate a b3ContactHitEvent.
/// Usually in meters per second.
/// @see b3WorldDef::hitEventThreshold
b3World_SetHitEventThreshold :: (worldId: b3WorldId, value: float) -> void #foreign box3d;

/// Get the hit event speed threshold. Usually in meters per second.
b3World_GetHitEventThreshold :: (worldId: b3WorldId) -> float #foreign box3d;

/// Register the custom filter callback. This is optional.
b3World_SetCustomFilterCallback :: (worldId: b3WorldId, fcn: b3CustomFilterFcn, _context: *void) -> void #foreign box3d;

/// Register the pre-solve callback. This is optional.
/// Discrete callback data contains borrowed mutable manifolds owned by Box3D and valid only until the callback returns.
/// Continuous callback data contains a read-only collision candidate; only returning false to reject the candidate has an effect.
b3World_SetPreSolveCallback :: (worldId: b3WorldId, fcn: b3PreSolveFcn, _context: *void) -> void #foreign box3d;

/// Get the world contact point represented by a discrete pre-solve manifold point.
/// The pre-solve data must still be valid, the phase must be b3_preSolveDiscrete, and the indices must be in range.
b3PreSolve_GetPoint :: (data: *b3PreSolveData, manifoldIndex: s32, pointIndex: s32) -> b3Pos #foreign box3d;

/// Set both anchors of a discrete pre-solve manifold point from a world contact point.
/// The pre-solve data must still be valid, the phase must be b3_preSolveDiscrete, and the indices must be in range.
b3PreSolve_SetPoint :: (data: *b3PreSolveData, manifoldIndex: s32, pointIndex: s32, point: b3Pos) -> void #foreign box3d;

/// Set the gravity vector for the entire world. Box3D has no concept of an up direction and this
/// is left as a decision for the application. Usually in m/s^2.
/// @see b3WorldDef
b3World_SetGravity :: (worldId: b3WorldId, gravity: b3Vec3) -> void #foreign box3d;

/// Get the gravity vector
b3World_GetGravity :: (worldId: b3WorldId) -> b3Vec3 #foreign box3d;

/// Apply a radial explosion
/// @param worldId The world id
/// @param explosionDef The explosion definition
b3World_Explode :: (worldId: b3WorldId, explosionDef: *b3ExplosionDef) -> void #foreign box3d;

/// Adjust contact tuning parameters
/// @param worldId The world id
/// @param hertz The contact stiffness (cycles per second)
/// @param dampingRatio The contact bounciness with 1 being critical damping (non-dimensional)
/// @param contactSpeed The maximum contact constraint push out speed (meters per second)
/// @note Advanced feature
b3World_SetContactTuning :: (worldId: b3WorldId, hertz: float, dampingRatio: float, contactSpeed: float) -> void #foreign box3d;

/// Set the contact point recycling distance. Setting this to zero disables contact point recycling.
/// Usually in meters.
b3World_SetContactRecycleDistance :: (worldId: b3WorldId, recycleDistance: float) -> void #foreign box3d;

/// Get the contact point recycling distance. Usually in meters.
b3World_GetContactRecycleDistance :: (worldId: b3WorldId) -> float #foreign box3d;

/// Set the maximum linear speed. Usually in m/s.
b3World_SetMaximumLinearSpeed :: (worldId: b3WorldId, maximumLinearSpeed: float) -> void #foreign box3d;

/// Get the maximum linear speed. Usually in m/s.
b3World_GetMaximumLinearSpeed :: (worldId: b3WorldId) -> float #foreign box3d;

/// Enable/disable constraint warm starting. Advanced feature for testing. Disabling
/// warm starting greatly reduces stability and provides no performance gain.
b3World_EnableWarmStarting :: (worldId: b3WorldId, flag: bool) -> void #foreign box3d;

/// Is constraint warm starting enabled?
b3World_IsWarmStartingEnabled :: (worldId: b3WorldId) -> bool #foreign box3d;

/// Get the number of awake bodies
b3World_GetAwakeBodyCount :: (worldId: b3WorldId) -> s32 #foreign box3d;

/// Get the current world performance profile
b3World_GetProfile :: (worldId: b3WorldId) -> b3Profile #foreign box3d;

/// Get world counters and sizes
b3World_GetCounters :: (worldId: b3WorldId) -> b3Counters #foreign box3d;

/// Get max capacity. This can be used with b3WorldDef to avoid run-time allocations and copies
b3World_GetMaxCapacity :: (worldId: b3WorldId) -> b3Capacity #foreign box3d;

/// Set the user data pointer.
b3World_SetUserData :: (worldId: b3WorldId, userData: *void) -> void #foreign box3d;

/// Get the user data pointer.
b3World_GetUserData :: (worldId: b3WorldId) -> *void #foreign box3d;

/// Set the friction callback. Passing NULL resets to default.
b3World_SetFrictionCallback :: (worldId: b3WorldId, callback: b3FrictionCallback) -> void #foreign box3d;

/// Set the restitution callback. Passing NULL resets to default.
b3World_SetRestitutionCallback :: (worldId: b3WorldId, callback: b3RestitutionCallback) -> void #foreign box3d;

/// Set the worker count. Must be in the range [1, B3_MAX_WORKERS]
b3World_SetWorkerCount :: (worldId: b3WorldId, count: s32) -> void #foreign box3d;

/// Get the worker count.
b3World_GetWorkerCount :: (worldId: b3WorldId) -> s32 #foreign box3d;

/// Dump memory stats to log.
b3World_DumpMemoryStats :: (worldId: b3WorldId) -> void #foreign box3d;

/// This is for internal testing
b3World_RebuildStaticTree :: (worldId: b3WorldId) -> void #foreign box3d;

/// This is for internal testing
b3World_EnableSpeculative :: (worldId: b3WorldId, flag: bool) -> void #foreign box3d;

b3Recording :: struct {}

/// Create a recording buffer with an optional initial byte capacity.
/// Pass 0 to use the default (64 KiB). The buffer grows on demand.
/// @return a new recording, owned by the caller
b3CreateRecording :: (byteCapacity: s32) -> *b3Recording #foreign box3d;

/// Destroy a recording and free its buffer.
/// @param recording may be NULL
b3DestroyRecording :: (recording: *b3Recording) -> void #foreign box3d;

/// Get a pointer to the raw recording bytes.
/// Valid until the recording buffer is modified or destroyed.
/// @param recording the recording handle
/// @return pointer to the byte buffer, or NULL if no bytes have been written
b3Recording_GetData :: (recording: *b3Recording) -> *u8 #foreign box3d;

/// Get the number of bytes currently in the recording buffer.
/// @param recording the recording handle
b3Recording_GetSize :: (recording: *b3Recording) -> s32 #foreign box3d;

/// Begin recording world mutations into the provided buffer.
/// The buffer is reset on each call so a single b3Recording can be reused for multiple sessions.
/// @param worldId the world to record
/// @param recording the recording handle to write into
b3World_StartRecording :: (worldId: b3WorldId, recording: *b3Recording) -> void #foreign box3d;

/// End the current recording session. Writes the trailing geometry registry and
/// backpatches the header. The buffer remains valid until the recording is destroyed.
/// @param worldId the world currently being recorded
b3World_StopRecording :: (worldId: b3WorldId) -> void #foreign box3d;

/// Save the recording buffer to a file. Returns true on success.
/// @param recording the recording to save
/// @param path file path to write
b3SaveRecordingToFile :: (recording: *b3Recording, path: *u8) -> bool #foreign box3d;

/// Load a recording from a file. Returns NULL on failure (file not found, wrong magic).
/// The caller owns the returned recording and must destroy it with b3DestroyRecording.
/// @param path file path to read
b3LoadRecordingFromFile :: (path: *u8) -> *b3Recording #foreign box3d;

/// Replay a recording from memory and verify it reproduces the same world-state hashes.
/// Stands up a fresh world, restores the seed snapshot, replays every op, and checks each embedded
/// StateHash record. Returns true if replay completed without id mismatches or hash divergences.
/// @param data pointer to recording bytes
/// @param size byte count of the recording
/// @param workerCount reserved for future multithreaded replay; pass 1 for now
b3ValidateReplay :: (data: *void, size: s32, workerCount: s32) -> bool #foreign box3d;

b3RecPlayer :: struct {}

/// Summary of a recording, read once at open so a viewer can frame and label it.
b3RecPlayerInfo :: struct {
    frameCount:   s32; // total recorded steps
    workerCount:  s32; // worker count requested for the replay world
    timeStep:     float; // dt of the recorded steps
    subStepCount: s32; // recorded sub-steps
    lengthScale:  float; // length units per meter in effect when recorded
    bounds:       b3AABB; // accumulated world bounds over the recording, zero-extent if unavailable
}

/// Create a player over a recording. Owns a private copy of the bytes.
/// @param data pointer to recording bytes
/// @param size byte count of the recording
/// @param workerCount worker count for the replay world; pass 1 to match a serial recording.
/// Replaying at a different count re-partitions the constraint graph, so the StateHash check
/// becomes a cross-thread determinism test. Adjustable later with b3RecPlayer_SetWorkerCount.
/// @return a new player, or NULL on bad header or deserialization failure
b3CreatePlayer :: (data: *void, size: s32, workerCount: s32) -> *b3RecPlayer #foreign box3d;

/// Destroy the player and free all memory. Restores the previous global length scale.
b3DestroyPlayer :: (player: *b3RecPlayer) -> void #foreign box3d;

/// Advance one frame. dispatch ops until the next Step completes.
/// @return true when a frame was stepped, false at end-of-recording
b3RecPlayer_StepFrame :: (player: *b3RecPlayer) -> bool #foreign box3d;

/// Sub-step one frame. This will sub-step and return immediately after body creation.
/// The next call will execute the time step. This allows bodies to be rendered
/// at the creation pose.
b3RecPlayer_SubStepFrame :: (player: *b3RecPlayer) -> void #foreign box3d;

/// Rewind to frame 0 (in-place restore so the world id stays stable).
b3RecPlayer_Restart :: (player: *b3RecPlayer) -> void #foreign box3d;

/// Seek to a specific frame. Forward seek steps op-by-op; backward seek restores
/// the nearest keyframe then re-steps the remaining gap.
b3RecPlayer_SeekFrame :: (player: *b3RecPlayer, targetFrame: s32) -> void #foreign box3d;

/// @return the world currently driven by this player
b3RecPlayer_GetWorldId :: (player: *b3RecPlayer) -> b3WorldId #foreign box3d;

/// @return the last fully-stepped frame index (0 before any step)
b3RecPlayer_GetFrame :: (player: *b3RecPlayer) -> s32 #foreign box3d;

/// @return total number of recorded frames
b3RecPlayer_GetFrameCount :: (player: *b3RecPlayer) -> s32 #foreign box3d;

/// @return true when the op stream is exhausted
b3RecPlayer_IsAtEnd :: (player: *b3RecPlayer) -> bool #foreign box3d;

/// @return true when the op stream is paused between body creation and world step.
b3RecPlayer_IsAtPreStep :: (player: *b3RecPlayer) -> bool #foreign box3d;

/// @return true when any StateHash mismatch has been detected
b3RecPlayer_HasDiverged :: (player: *b3RecPlayer) -> bool #foreign box3d;

/// @return a summary of the recording read at open: frame count, recorded tuning, and bounds
b3RecPlayer_GetInfo :: (player: *b3RecPlayer) -> b3RecPlayerInfo #foreign box3d;

/// @return the first frame at which replay diverged, or -1 if it has not diverged
b3RecPlayer_GetDivergeFrame :: (player: *b3RecPlayer) -> s32 #foreign box3d;

/// Set the worker count of the replay world. Clamped to [1, B3_MAX_WORKERS]. Applied to the live
/// world at once and reused whenever the player rebuilds its world on Restart or a backward seek.
/// Replaying at a different count than recorded re-partitions the constraint graph, so the StateHash
/// check becomes a cross-thread determinism test.
b3RecPlayer_SetWorkerCount :: (player: *b3RecPlayer, count: s32) -> void #foreign box3d;

/// Tune the keyframe ring used to speed up backward seeking. A keyframe is a periodic snapshot the
/// player restores from instead of replaying from the start, trading memory for seek speed.
/// @param player the recording player
/// @param budgetBytes memory cap for the kept snapshots; the spacing widens to stay under it
/// @param minIntervalFrames finest spacing between keyframes, in frames
/// A zero budget or a non-positive interval keeps that value. Clears the existing ring, so call
/// b3RecPlayer_Restart afterward to repopulate it under the new policy.
b3RecPlayer_SetKeyframePolicy :: (player: *b3RecPlayer, budgetBytes: u64, minIntervalFrames: s32) -> void #foreign box3d;

/// @return the keyframe memory budget in bytes
b3RecPlayer_GetKeyframeBudget :: (player: *b3RecPlayer) -> u64 #foreign box3d;

/// @return the finest keyframe spacing in frames
b3RecPlayer_GetKeyframeMinInterval :: (player: *b3RecPlayer) -> s32 #foreign box3d;

/// @return the current keyframe spacing in frames; starts at the min interval and doubles as the
/// ring evicts to stay under budget, so it reflects the effective backward-seek granularity now
b3RecPlayer_GetKeyframeInterval :: (player: *b3RecPlayer) -> s32 #foreign box3d;

/// @return the memory currently held by keyframe snapshots, in bytes
b3RecPlayer_GetKeyframeBytes :: (player: *b3RecPlayer) -> u64 #foreign box3d;

/// @return the number of bodies tracked in creation order (including holes for destroyed bodies)
b3RecPlayer_GetBodyCount :: (player: *b3RecPlayer) -> s32 #foreign box3d;

/// Resolve a creation ordinal to the live body id at the current frame.
/// @return the body id, or a null id if that ordinal is out of range or its body is destroyed
b3RecPlayer_GetBodyId :: (player: *b3RecPlayer, index: s32) -> b3BodyId #foreign box3d;

/// Wire host debug-shape callbacks into the player's replay world so a renderer can build
/// per-shape draw resources (the 3D sample needs this or the replay world draws nothing).
/// Rebuilds the current world under the new callbacks and rewinds to frame 0, so call it
/// once right after b3RecPlayer_Create and re-read the world id afterward. The callbacks
/// persist across Restart and backward seeks, which recreate the world internally.
/// @param player the player to configure
/// @param createDebugShape called when a replayed shape is added; returns a user draw handle
/// @param destroyDebugShape called when a replayed shape is removed; may be NULL
/// @param context user context passed to both callbacks
b3RecPlayer_SetDebugShapeCallbacks :: (player: *b3RecPlayer, createDebugShape: b3CreateDebugShapeCallback, destroyDebugShape: b3DestroyDebugShapeCallback, _context: *void) -> void #foreign box3d;

/// Draw the spatial queries recorded during the most recently replayed frame, layered on top of the
/// world. Call after b3World_Draw. NULL draw function pointers are skipped.
/// @param player a valid player handle
/// @param draw debug draw callbacks
/// @param queryIndex index of the frame query to draw, or -1 to draw all of them
/// @param selectedIndex index of the query to emphasize (reserved color plus a label), or -1 for none
b3RecPlayer_DrawFrameQueries :: (player: *b3RecPlayer, draw: *b3DebugDraw, queryIndex: s32, selectedIndex: s32) -> void #foreign box3d;

/// The kind of a recorded spatial query, matching the public query and cast functions.
b3RecQueryType :: enum u32 {
    recQueryOverlapAABB    :: 0;
    recQueryOverlapShape   :: 1;
    recQueryCastRay        :: 2;
    recQueryCastShape      :: 3;
    recQueryCastRayClosest :: 4;
    recQueryCastMover      :: 5;
    recQueryCollideMover   :: 6;

    b3_recQueryOverlapAABB    :: recQueryOverlapAABB;
    b3_recQueryOverlapShape   :: recQueryOverlapShape;
    b3_recQueryCastRay        :: recQueryCastRay;
    b3_recQueryCastShape      :: recQueryCastShape;
    b3_recQueryCastRayClosest :: recQueryCastRayClosest;
    b3_recQueryCastMover      :: recQueryCastMover;
    b3_recQueryCollideMover   :: recQueryCollideMover;
}

/// A spatial query recorded during a replayed frame, exposed for inspection.
b3RecQueryInfo :: struct {
    type:        b3RecQueryType;
    filter:      b3QueryFilter;
    aabb:        b3AABB; // world-space bounds of the query, swept for casts
    origin:      b3Pos; // query origin (zero for overlap AABB)
    translation: b3Vec3; // ray and cast translation
    hitCount:    s32; // number of recorded results
    key:         u64; // identity key, the hash of (id, name), 0 if untagged
    id:          u64; // query id, 0 if none
    name:        *u8; // query label, NULL if none
}

/// One result of a recorded spatial query.
b3RecQueryHit :: struct {
    shape:    b3ShapeId;
    point:    b3Pos;
    normal:   b3Vec3;
    fraction: float;
}

/// @return the number of spatial queries recorded for the most recently replayed frame
b3RecPlayer_GetFrameQueryCount :: (player: *b3RecPlayer) -> s32 #foreign box3d;

/// Get a recorded query from the most recently replayed frame by index.
b3RecPlayer_GetFrameQuery :: (player: *b3RecPlayer, index: s32) -> b3RecQueryInfo #foreign box3d;

/// Get one result of a recorded query from the most recently replayed frame.
b3RecPlayer_GetFrameQueryHit :: (player: *b3RecPlayer, queryIndex: s32, hitIndex: s32) -> b3RecQueryHit #foreign box3d;

/// Create a rigid body given a definition. No reference to the definition is retained. So you can create the definition
/// on the stack and pass it as a pointer.
/// @code{.c}
/// b3BodyDef bodyDef = b3DefaultBodyDef();
/// b3BodyId myBodyId = b3CreateBody(myWorldId, &bodyDef);
/// @endcode
/// @warning This function is locked during callbacks.
b3CreateBody :: (worldId: b3WorldId, def: *b3BodyDef) -> b3BodyId #foreign box3d;

/// Destroy a rigid body given an id. This destroys all shapes and joints attached to the body.
/// Do not keep references to the associated shapes and joints.
b3DestroyBody :: (bodyId: b3BodyId) -> void #foreign box3d;

/// Body identifier validation. A valid body exists in a world and is non-null.
/// This can be used to detect orphaned ids. Provides validation for up to 64K allocations.
b3Body_IsValid :: (id: b3BodyId) -> bool #foreign box3d;

/// Get the body type: static, kinematic, or dynamic
b3Body_GetType :: (bodyId: b3BodyId) -> b3BodyType #foreign box3d;

/// Change the body type. This is an expensive operation. This automatically updates the mass
/// properties regardless of the automatic mass setting.
b3Body_SetType :: (bodyId: b3BodyId, type: b3BodyType) -> void #foreign box3d;

/// Set the body name.
b3Body_SetName :: (bodyId: b3BodyId, name: *u8) -> void #foreign box3d;

/// Get the body name. Returns an empty string if the name isn't set.
b3Body_GetName :: (bodyId: b3BodyId) -> *u8 #foreign box3d;

/// Set the user data for a body
b3Body_SetUserData :: (bodyId: b3BodyId, userData: *void) -> void #foreign box3d;

/// Get the user data stored in a body
b3Body_GetUserData :: (bodyId: b3BodyId) -> *void #foreign box3d;

/// Get the world position of a body. This is the location of the body origin.
b3Body_GetPosition :: (bodyId: b3BodyId) -> b3Pos #foreign box3d;

/// Get the world rotation of a body as a quaternion
b3Body_GetRotation :: (bodyId: b3BodyId) -> b3Quat #foreign box3d;

/// Get the world transform of a body.
b3Body_GetTransform :: (bodyId: b3BodyId) -> b3WorldTransform #foreign box3d;

/// Set the world transform of a body. This acts as a teleport and is fairly expensive.
/// @note Generally you should create a body with the intended transform.
/// @see b3BodyDef::position and b3BodyDef::rotation.
b3Body_SetTransform :: (bodyId: b3BodyId, position: b3Pos, rotation: b3Quat) -> void #foreign box3d;

/// Get a local point on a body given a world point.
b3Body_GetLocalPoint :: (bodyId: b3BodyId, worldPoint: b3Pos) -> b3Vec3 #foreign box3d;

/// Get a world point on a body given a local point.
b3Body_GetWorldPoint :: (bodyId: b3BodyId, localPoint: b3Vec3) -> b3Pos #foreign box3d;

/// Get a local vector on a body given a world vector.
b3Body_GetLocalVector :: (bodyId: b3BodyId, worldVector: b3Vec3) -> b3Vec3 #foreign box3d;

/// Get a world vector on a body given a local vector.
b3Body_GetWorldVector :: (bodyId: b3BodyId, localVector: b3Vec3) -> b3Vec3 #foreign box3d;

/// Get the linear velocity of a body's center of mass. Usually in meters per second.
b3Body_GetLinearVelocity :: (bodyId: b3BodyId) -> b3Vec3 #foreign box3d;

/// Get the angular velocity of a body in radians per second.
b3Body_GetAngularVelocity :: (bodyId: b3BodyId) -> b3Vec3 #foreign box3d;

/// Set the linear velocity of a body at the center of mass. Usually in meters per second.
b3Body_SetLinearVelocity :: (bodyId: b3BodyId, linearVelocity: b3Vec3) -> void #foreign box3d;

/// Set the angular velocity of a body in radians per second.
b3Body_SetAngularVelocity :: (bodyId: b3BodyId, angularVelocity: b3Vec3) -> void #foreign box3d;

/// Set the velocity to reach the given transform after a given time step.
/// The result will be close but maybe not exact. This is meant for kinematic bodies.
/// The target is not applied if the velocity would be below the sleep threshold.
/// This will optionally wake the body if asleep, but only if the movement is significant.
b3Body_SetTargetTransform :: (bodyId: b3BodyId, target: b3WorldTransform, timeStep: float, wake: bool) -> void #foreign box3d;

/// Get the linear velocity of a local point attached to a body. Usually in meters per second.
b3Body_GetLocalPointVelocity :: (bodyId: b3BodyId, localPoint: b3Vec3) -> b3Vec3 #foreign box3d;

/// Get the linear velocity of a world point attached to a body. Usually in meters per second.
b3Body_GetWorldPointVelocity :: (bodyId: b3BodyId, worldPoint: b3Pos) -> b3Vec3 #foreign box3d;

/// Apply a force at a world point. If the force is not applied at the center of mass,
/// it will generate a torque and affect the angular velocity. This optionally wakes up the body.
/// The force is ignored if the body is not awake.
/// @param bodyId The body id
/// @param force The world force vector, usually in newtons (N)
/// @param point The world position of the point of application
/// @param wake Option to wake up the body
b3Body_ApplyForce :: (bodyId: b3BodyId, force: b3Vec3, point: b3Pos, wake: bool) -> void #foreign box3d;

/// Apply a force to the center of mass. This optionally wakes up the body.
/// The force is ignored if the body is not awake.
/// @param bodyId The body id
/// @param force the world force vector, usually in newtons (N).
/// @param wake also wake up the body
b3Body_ApplyForceToCenter :: (bodyId: b3BodyId, force: b3Vec3, wake: bool) -> void #foreign box3d;

/// Apply a torque. This affects the angular velocity without affecting the linear velocity.
/// This optionally wakes the body. The torque is ignored if the body is not awake.
/// @param bodyId The body id
/// @param torque the world torque vector, usually in N*m.
/// @param wake also wake up the body
b3Body_ApplyTorque :: (bodyId: b3BodyId, torque: b3Vec3, wake: bool) -> void #foreign box3d;

/// Apply an impulse at a point. This immediately modifies the velocity.
/// It also modifies the angular velocity if the point of application
/// is not at the center of mass. This optionally wakes the body.
/// The impulse is ignored if the body is not awake.
/// @param bodyId The body id
/// @param impulse the world impulse vector, usually in N*s or kg*m/s.
/// @param point the world position of the point of application.
/// @param wake also wake up the body
/// @warning This should be used for one-shot impulses. If you need a steady force,
/// use a force instead, which will work better with the sub-stepping solver.
b3Body_ApplyLinearImpulse :: (bodyId: b3BodyId, impulse: b3Vec3, point: b3Pos, wake: bool) -> void #foreign box3d;

/// Apply an impulse to the center of mass. This immediately modifies the velocity.
/// The impulse is ignored if the body is not awake. This optionally wakes the body.
/// @param bodyId The body id
/// @param impulse the world impulse vector, usually in N*s or kg*m/s.
/// @param wake also wake up the body
/// @warning This should be used for one-shot impulses. If you need a steady force,
/// use a force instead, which will work better with the sub-stepping solver.
b3Body_ApplyLinearImpulseToCenter :: (bodyId: b3BodyId, impulse: b3Vec3, wake: bool) -> void #foreign box3d;

/// Apply an angular impulse in world space. The impulse is ignored if the body is not awake.
/// This optionally wakes the body.
/// @param bodyId The body id
/// @param impulse the world angular impulse vector, usually in units of kg*m*m/s
/// @param wake also wake up the body
/// @warning This should be used for one-shot impulses. If you need a steady torque,
/// use a torque instead, which will work better with the sub-stepping solver.
b3Body_ApplyAngularImpulse :: (bodyId: b3BodyId, impulse: b3Vec3, wake: bool) -> void #foreign box3d;

/// Get the mass of the body, usually in kilograms
b3Body_GetMass :: (bodyId: b3BodyId) -> float #foreign box3d;

/// Get the rotational inertia of the body in local space, usually in kg*m^2
b3Body_GetLocalRotationalInertia :: (bodyId: b3BodyId) -> b3Matrix3 #foreign box3d;

/// Get the inverse mass of the body, usually in 1/kilograms
b3Body_GetInverseMass :: (bodyId: b3BodyId) -> float #foreign box3d;

/// Get the inverse rotational inertia of the body in world space, usually in 1/kg*m^2
b3Body_GetWorldInverseRotationalInertia :: (bodyId: b3BodyId) -> b3Matrix3 #foreign box3d;

/// Get the center of mass position of the body in local space
b3Body_GetLocalCenter :: (bodyId: b3BodyId) -> b3Vec3 #foreign box3d;

/// Get the center of mass position of the body in world space
b3Body_GetWorldCenter :: (bodyId: b3BodyId) -> b3Pos #foreign box3d;

/// Override the body's mass properties. Normally this is computed automatically using the
/// shape geometry and density. This information is lost if a shape is added or removed or if the
/// body type changes.
b3Body_SetMassData :: (bodyId: b3BodyId, massData: b3MassData) -> void #foreign box3d;

/// Get the mass data for a body
b3Body_GetMassData :: (bodyId: b3BodyId) -> b3MassData #foreign box3d;

/// This updates the mass properties to the sum of the mass properties of the shapes.
/// This normally does not need to be called unless you called SetMassData to override
/// the mass and you later want to reset the mass.
/// You may also use this when automatic mass computation has been disabled.
/// You should call this regardless of body type.
b3Body_ApplyMassFromShapes :: (bodyId: b3BodyId) -> void #foreign box3d;

/// Adjust the linear damping. Normally this is set in b3BodyDef before creation.
b3Body_SetLinearDamping :: (bodyId: b3BodyId, linearDamping: float) -> void #foreign box3d;

/// Get the current linear damping.
b3Body_GetLinearDamping :: (bodyId: b3BodyId) -> float #foreign box3d;

/// Adjust the angular damping. Normally this is set in b3BodyDef before creation.
b3Body_SetAngularDamping :: (bodyId: b3BodyId, angularDamping: float) -> void #foreign box3d;

/// Get the current angular damping.
b3Body_GetAngularDamping :: (bodyId: b3BodyId) -> float #foreign box3d;

/// Adjust the gravity scale. Normally this is set in b3BodyDef before creation.
/// @see b3BodyDef::gravityScale
b3Body_SetGravityScale :: (bodyId: b3BodyId, gravityScale: float) -> void #foreign box3d;

/// Get the current gravity scale
b3Body_GetGravityScale :: (bodyId: b3BodyId) -> float #foreign box3d;

/// @return true if this body is awake
b3Body_IsAwake :: (bodyId: b3BodyId) -> bool #foreign box3d;

/// Wake a body from sleep. This wakes the entire island the body is touching.
/// @warning Putting a body to sleep will put the entire island of bodies touching this body to sleep,
/// which can be expensive and possibly unintuitive.
b3Body_SetAwake :: (bodyId: b3BodyId, awake: bool) -> void #foreign box3d;

/// Enable or disable sleeping for this body. If sleeping is disabled the body will wake.
b3Body_EnableSleep :: (bodyId: b3BodyId, enableSleep: bool) -> void #foreign box3d;

/// Returns true if sleeping is enabled for this body
b3Body_IsSleepEnabled :: (bodyId: b3BodyId) -> bool #foreign box3d;

/// Set the sleep threshold, usually in meters per second
b3Body_SetSleepThreshold :: (bodyId: b3BodyId, sleepThreshold: float) -> void #foreign box3d;

/// Get the sleep threshold, usually in meters per second.
b3Body_GetSleepThreshold :: (bodyId: b3BodyId) -> float #foreign box3d;

/// Returns true if this body is enabled
b3Body_IsEnabled :: (bodyId: b3BodyId) -> bool #foreign box3d;

/// Disable a body by removing it completely from the simulation. This is expensive.
b3Body_Disable :: (bodyId: b3BodyId) -> void #foreign box3d;

/// Enable a body by adding it to the simulation. This is expensive.
b3Body_Enable :: (bodyId: b3BodyId) -> void #foreign box3d;

/// Set the motion locks on this body.
b3Body_SetMotionLocks :: (bodyId: b3BodyId, locks: b3MotionLocks) -> void #foreign box3d;

/// Get the motion locks for this body.
b3Body_GetMotionLocks :: (bodyId: b3BodyId) -> b3MotionLocks #foreign box3d;

/// Set this body to be a bullet. A bullet does continuous collision detection
/// against dynamic bodies (but not other bullets).
b3Body_SetBullet :: (bodyId: b3BodyId, flag: bool) -> void #foreign box3d;

/// Is this body a bullet?
b3Body_IsBullet :: (bodyId: b3BodyId) -> bool #foreign box3d;

/// Allow this body to rotate fast. Useful for axially symmetric bodies, such as vehicle wheels.
/// Normally rotation speed is clamped to improve CCD. However, this clamping is unnecessary for
/// bodies that only rotate fast around an axis of symmetry.
b3Body_AllowFastRotation :: (bodyId: b3BodyId, flag: bool) -> void #foreign box3d;

/// Is this body allowed to rotate fast?
b3Body_IsFastRotationAllowed :: (bodyId: b3BodyId) -> bool #foreign box3d;

/// Enable or disable contact recycling for this body. Contact recycling is a performance optimization
/// that reuses contact manifolds when bodies move slightly. Disabling it can avoid ghost collisions
/// on characters at the cost of higher per-step work. Existing contacts retain their prior setting;
/// only contacts created after this call see the new value.
/// @see b3BodyDef::enableContactRecycling
b3Body_EnableContactRecycling :: (bodyId: b3BodyId, flag: bool) -> void #foreign box3d;

/// Is contact recycling enabled on this body?
b3Body_IsContactRecyclingEnabled :: (bodyId: b3BodyId) -> bool #foreign box3d;

/// Enable/disable hit events on all shapes
/// @see b3ShapeDef::enableHitEvents
b3Body_EnableHitEvents :: (bodyId: b3BodyId, flag: bool) -> void #foreign box3d;

/// Get the world that owns this body
b3Body_GetWorld :: (bodyId: b3BodyId) -> b3WorldId #foreign box3d;

/// Get the number of shapes on this body
b3Body_GetShapeCount :: (bodyId: b3BodyId) -> s32 #foreign box3d;

/// Get the shape ids for all shapes on this body, up to the provided capacity.
/// @returns the number of shape ids stored in the user array
b3Body_GetShapes :: (bodyId: b3BodyId, shapeArray: *b3ShapeId, capacity: s32) -> s32 #foreign box3d;

/// Get the number of joints on this body
b3Body_GetJointCount :: (bodyId: b3BodyId) -> s32 #foreign box3d;

/// Get the joint ids for all joints on this body, up to the provided capacity
/// @returns the number of joint ids stored in the user array
b3Body_GetJoints :: (bodyId: b3BodyId, jointArray: *b3JointId, capacity: s32) -> s32 #foreign box3d;

/// Get the maximum capacity required for retrieving all the touching contacts on a body
b3Body_GetContactCapacity :: (bodyId: b3BodyId) -> s32 #foreign box3d;

/// Get the touching contact data for a body
b3Body_GetContactData :: (bodyId: b3BodyId, contactData: *b3ContactData, capacity: s32) -> s32 #foreign box3d;

/// Get the current world AABB that contains all the attached shapes. Note that this may not encompass the body origin.
/// If there are no shapes attached then the returned AABB is empty and centered on the body origin.
b3Body_ComputeAABB :: (bodyId: b3BodyId) -> b3AABB #foreign box3d;

/// Get the closest point on a body to a world target.
b3Body_GetClosestPoint :: (bodyId: b3BodyId, result: *b3Vec3, target: b3Vec3) -> float #foreign box3d;

/// Cast a ray at a specific body using a specified body transform.
b3Body_CastRay :: (bodyId: b3BodyId, origin: b3Pos, translation: b3Vec3, filter: b3QueryFilter, maxFraction: float, bodyTransform: b3WorldTransform) -> b3BodyCastResult #foreign box3d;

/// Cast a shape at a specific body using a specified body transform.
b3Body_CastShape :: (bodyId: b3BodyId, origin: b3Pos, proxy: *b3ShapeProxy, translation: b3Vec3, filter: b3QueryFilter, maxFraction: float, canEncroach: bool, bodyTransform: b3WorldTransform) -> b3BodyCastResult #foreign box3d;

/// Overlap a shape with a specific body using a specified body transform.
b3Body_OverlapShape :: (bodyId: b3BodyId, origin: b3Pos, proxy: *b3ShapeProxy, filter: b3QueryFilter, bodyTransform: b3WorldTransform) -> bool #foreign box3d;

/// Collide a character mover with a specific body using a specified body transform.
b3Body_CollideMover :: (bodyId: b3BodyId, bodyPlanes: *b3BodyPlaneResult, planeCapacity: s32, origin: b3Pos, mover: *b3Capsule, filter: b3QueryFilter, bodyTransform: b3WorldTransform) -> s32 #foreign box3d;

/// Create a circle shape and attach it to a body. The shape definition and geometry are fully cloned.
/// Contacts are not created until the next time step.
/// @return the shape id for accessing the shape
b3CreateSphereShape :: (bodyId: b3BodyId, def: *b3ShapeDef, sphere: *b3Sphere) -> b3ShapeId #foreign box3d;

/// Create a capsule shape and attach it to a body. The shape definition and geometry are fully cloned.
/// Contacts are not created until the next time step.
/// @return the shape id for accessing the shape
b3CreateCapsuleShape :: (bodyId: b3BodyId, def: *b3ShapeDef, capsule: *b3Capsule) -> b3ShapeId #foreign box3d;

/// Create a convex hull shape and attach it to a body. The shape definition is fully cloned. Contacts are not created
/// until the next time step.
/// @return the shape id for accessing the shape
b3CreateHullShape :: (bodyId: b3BodyId, def: *b3ShapeDef, hull: *b3HullData) -> b3ShapeId #foreign box3d;

/// Create a convex hull shape and attach it to a body. The hull is cloned then transformed with scale applied first.
/// Use this for non-uniform or mirrored scale or a baked local transform. The baked result is shared through the
/// world hull database. The shape definition and geometry are fully cloned. Contacts are not created until the next time step.
/// @return the shape id for accessing the shape
b3CreateTransformedHullShape :: (bodyId: b3BodyId, def: *b3ShapeDef, hull: *b3HullData, transform: b3Transform, scale: b3Vec3) -> b3ShapeId #foreign box3d;

/// Create a mesh hull shape and attach it to a body. The shape definition is fully cloned but the mesh is not.
/// Contacts are not created until the next time step.
/// Mesh collision only creates contacts on static bodies.
/// @warning this holds reference to the input mesh data which must remain valid for the lifetime of this shape
/// @return the shape id for accessing the shape
b3CreateMeshShape :: (bodyId: b3BodyId, def: *b3ShapeDef, mesh: *b3MeshData, scale: b3Vec3) -> b3ShapeId #foreign box3d;

/// Create a height-field shape and attach it to a body. The shape definition is fully cloned but the height field is not.
/// Contacts are not created until the next time step.
/// Height field is only allowed on static bodies.
/// @warning this holds reference to the input height field which must remain valid for the lifetime of this shape
/// @return the shape id for accessing the shape
b3CreateHeightFieldShape :: (bodyId: b3BodyId, def: *b3ShapeDef, heightField: *b3HeightFieldData) -> b3ShapeId #foreign box3d;

/// Baked compound shapes are only allowed on static bodies.
/// Note: runtime compounds are achieved by adding multiple shapes to a body.
/// Runtime compounds can be dynamic and/or kinematic.
b3CreateBakedCompoundShape :: (bodyId: b3BodyId, def: *b3ShapeDef, compound: *b3CompoundData) -> b3ShapeId #foreign box3d;

/// Destroy a shape. You may defer the body mass update which can improve performance if several shapes on a
///	body are destroyed at once.
///	@see b3Body_ApplyMassFromShapes
b3DestroyShape :: (shapeId: b3ShapeId, updateBodyMass: bool) -> void #foreign box3d;

/// Shape identifier validation. Provides validation for up to 64K allocations.
b3Shape_IsValid :: (id: b3ShapeId) -> bool #foreign box3d;

/// Get the type of a shape
b3Shape_GetType :: (shapeId: b3ShapeId) -> b3ShapeType #foreign box3d;

/// Get the id of the body that a shape is attached to
b3Shape_GetBody :: (shapeId: b3ShapeId) -> b3BodyId #foreign box3d;

/// Get the world that owns this shape
b3Shape_GetWorld :: (shapeId: b3ShapeId) -> b3WorldId #foreign box3d;

/// Returns true if the shape is a sensor
b3Shape_IsSensor :: (shapeId: b3ShapeId) -> bool #foreign box3d;

/// Set the shape name.
b3Shape_SetName :: (shapeId: b3ShapeId, name: *u8) -> void #foreign box3d;

/// Get the shape name. Returns an empty string if the name isn't set.
b3Shape_GetName :: (shapeId: b3ShapeId) -> *u8 #foreign box3d;

/// Set the user data for a shape
b3Shape_SetUserData :: (shapeId: b3ShapeId, userData: *void) -> void #foreign box3d;

/// Get the user data for a shape. This is useful when you get a shape id
/// from an event or query.
b3Shape_GetUserData :: (shapeId: b3ShapeId) -> *void #foreign box3d;

/// Set the mass density of a shape, usually in kg/m^3.
/// This will optionally update the mass properties on the parent body.
/// @see b3ShapeDef::density, b3Body_ApplyMassFromShapes
b3Shape_SetDensity :: (shapeId: b3ShapeId, density: float, updateBodyMass: bool) -> void #foreign box3d;

/// Get the density of a shape, usually in kg/m^3
b3Shape_GetDensity :: (shapeId: b3ShapeId) -> float #foreign box3d;

/// Set the friction on a shape
b3Shape_SetFriction :: (shapeId: b3ShapeId, friction: float) -> void #foreign box3d;

/// Get the friction of a shape
b3Shape_GetFriction :: (shapeId: b3ShapeId) -> float #foreign box3d;

/// Set the shape restitution (bounciness)
b3Shape_SetRestitution :: (shapeId: b3ShapeId, restitution: float) -> void #foreign box3d;

/// Get the shape restitution
b3Shape_GetRestitution :: (shapeId: b3ShapeId) -> float #foreign box3d;

/// Set the shape base surface material. Does not change per triangle materials.
b3Shape_SetSurfaceMaterial :: (shapeId: b3ShapeId, surfaceMaterial: b3SurfaceMaterial) -> void #foreign box3d;

/// Get the base shape surface material.
b3Shape_GetSurfaceMaterial :: (shapeId: b3ShapeId) -> b3SurfaceMaterial #foreign box3d;

/// Get the number of mesh surface materials.
b3Shape_GetMeshMaterialCount :: (shapeId: b3ShapeId) -> s32 #foreign box3d;

/// Set a surface material for a mesh shape.
b3Shape_SetMeshMaterial :: (shapeId: b3ShapeId, surfaceMaterial: b3SurfaceMaterial, index: s32) -> void #foreign box3d;

/// Get a surface material for a mesh shape
b3Shape_GetMeshSurfaceMaterial :: (shapeId: b3ShapeId, index: s32) -> b3SurfaceMaterial #foreign box3d;

/// Resolve the user material id for a contact point.
/// For discrete contacts, use the child index from b3PreSolveData and triangle index from b3ManifoldPoint.
/// For continuous candidates, use the child and triangle indices from b3PreSolveData.
/// Pass B3_NULL_INDEX for shapes without a participating child or triangle.
/// This is a read-only query and may be called from a pre-solve callback.
b3Shape_GetContactMaterialId :: (shapeId: b3ShapeId, childIndex: s32, triangleIndex: s32) -> u64 #foreign box3d;

/// Get the shape filter
b3Shape_GetFilter :: (shapeId: b3ShapeId) -> b3Filter #foreign box3d;

/// Set the current filter. This is almost as expensive as recreating the shape.
/// @see b3ShapeDef::filter
/// @param shapeId the shape
/// @param filter the new filter
/// @param invokeContacts if true then the shape will have all contacts recomputed the next time step (expensive)
b3Shape_SetFilter :: (shapeId: b3ShapeId, filter: b3Filter, invokeContacts: bool) -> void #foreign box3d;

/// Enable sensor events for this shape. Only applies to kinematic and dynamic bodies. Ignored for sensors.
/// @see b3ShapeDef::isSensor
b3Shape_EnableSensorEvents :: (shapeId: b3ShapeId, flag: bool) -> void #foreign box3d;

/// Returns true if sensor events are enabled
b3Shape_AreSensorEventsEnabled :: (shapeId: b3ShapeId) -> bool #foreign box3d;

/// Enable contact events for this shape. Only applies to kinematic and dynamic bodies. Ignored for sensors.
/// @see b3ShapeDef::enableContactEvents
b3Shape_EnableContactEvents :: (shapeId: b3ShapeId, flag: bool) -> void #foreign box3d;

/// Returns true if contact events are enabled
b3Shape_AreContactEventsEnabled :: (shapeId: b3ShapeId) -> bool #foreign box3d;

/// Enable pre-solve contact events for this shape. Only applies to dynamic bodies. These are expensive
/// and must be carefully handled due to multithreading. Ignored for sensors.
/// @see b3PreSolveFcn
b3Shape_EnablePreSolveEvents :: (shapeId: b3ShapeId, flag: bool) -> void #foreign box3d;

/// Returns true if pre-solve events are enabled
b3Shape_ArePreSolveEventsEnabled :: (shapeId: b3ShapeId) -> bool #foreign box3d;

/// Enable contact hit events for this shape. Ignored for sensors.
/// @see b3WorldDef.hitEventThreshold
b3Shape_EnableHitEvents :: (shapeId: b3ShapeId, flag: bool) -> void #foreign box3d;

/// Returns true if hit events are enabled
b3Shape_AreHitEventsEnabled :: (shapeId: b3ShapeId) -> bool #foreign box3d;

/// Ray cast a shape directly. The ray runs from origin to origin + translation and the hit point
/// comes back as a world position, so the cast stays precise far from the world origin.
b3Shape_RayCast :: (shapeId: b3ShapeId, origin: b3Pos, translation: b3Vec3) -> b3WorldCastOutput #foreign box3d;

/// Get a copy of the shape's sphere. Asserts the type is correct.
b3Shape_GetSphere :: (shapeId: b3ShapeId) -> b3Sphere #foreign box3d;

/// Get a copy of the shape's capsule. Asserts the type is correct.
b3Shape_GetCapsule :: (shapeId: b3ShapeId) -> b3Capsule #foreign box3d;

/// Get the shape's convex hull. Asserts the type is correct.
b3Shape_GetHull :: (shapeId: b3ShapeId) -> *b3HullData #foreign box3d;

/// Get the shape's mesh. Asserts the type is correct.
b3Shape_GetMesh :: (shapeId: b3ShapeId) -> b3Mesh #foreign box3d;

/// Get the shape's height field. Asserts the type is correct.
b3Shape_GetHeightField :: (shapeId: b3ShapeId) -> *b3HeightFieldData #foreign box3d;

/// Allows you to change a shape to be a sphere or update the current sphere.
/// This does not modify the mass properties.
/// @see b3Body_ApplyMassFromShapes
b3Shape_SetSphere :: (shapeId: b3ShapeId, sphere: *b3Sphere) -> void #foreign box3d;

/// Allows you to change a shape to be a capsule or update the current capsule.
/// This does not modify the mass properties.
/// @see b3Body_ApplyMassFromShapes
b3Shape_SetCapsule :: (shapeId: b3ShapeId, capsule: *b3Capsule) -> void #foreign box3d;

/// Allows you to change a shape to be a hull or update the current hull.
/// This does not modify the mass properties.
/// @see b3Body_ApplyMassFromShapes
b3Shape_SetHull :: (shapeId: b3ShapeId, hull: *b3HullData) -> void #foreign box3d;

/// Allows you to change a shape to be a mesh or update the current mesh.
/// This does not modify the mass properties.
/// @see b3Body_ApplyMassFromShapes
b3Shape_SetMesh :: (shapeId: b3ShapeId, meshData: *b3MeshData, scale: b3Vec3) -> void #foreign box3d;

/// Get the maximum capacity required for retrieving all the touching contacts on a shape
b3Shape_GetContactCapacity :: (shapeId: b3ShapeId) -> s32 #foreign box3d;

/// Get the touching contact data for a shape. The provided shapeId will be either shapeIdA or shapeIdB on the contact data.
/// @note Box3D uses speculative collision so some contact points may be separated.
/// @returns the number of elements filled in the provided array
/// @warning do not ignore the return value, it specifies the valid number of elements
b3Shape_GetContactData :: (shapeId: b3ShapeId, contactData: *b3ContactData, capacity: s32) -> s32 #foreign box3d;

/// Get the maximum capacity required for retrieving all the overlapped shapes on a sensor shape.
/// This returns 0 if the provided shape is not a sensor.
/// @param shapeId the id of a sensor shape
/// @returns the required capacity to get all the overlaps in b3Shape_GetSensorOverlaps
b3Shape_GetSensorCapacity :: (shapeId: b3ShapeId) -> s32 #foreign box3d;

/// Get the overlap data for a sensor shape.
/// @param shapeId the id of a sensor shape
/// @param visitorIds a user allocated array that is filled with the overlapping shapes (visitors)
/// @param capacity the capacity of overlappedShapes
/// @returns the number of elements filled in the provided array
/// @warning do not ignore the return value, it specifies the valid number of elements
/// @warning overlaps may contain destroyed shapes so use b3Shape_IsValid to confirm each overlap
b3Shape_GetSensorData :: (shapeId: b3ShapeId, visitorIds: *b3ShapeId, capacity: s32) -> s32 #foreign box3d;

/// Get the current world AABB
b3Shape_GetAABB :: (shapeId: b3ShapeId) -> b3AABB #foreign box3d;

/// Compute the mass data for a shape
b3Shape_ComputeMassData :: (shapeId: b3ShapeId) -> b3MassData #foreign box3d;

/// Get the closest point on a shape to a target point. Target and result are in world space.
b3Shape_GetClosestPoint :: (shapeId: b3ShapeId, target: b3Vec3) -> b3Vec3 #foreign box3d;

/// Apply a wind force to the body for this shape using the density of air. This considers
/// the projected area of the shape in the wind direction. This also considers
/// the relative velocity of the shape.
/// @param shapeId the shape id
/// @param wind the wind velocity in world space
/// @param drag the drag coefficient, the force that opposes the relative velocity
/// @param lift the lift coefficient, the force that is perpendicular to the relative velocity
/// @param maxSpeed the maximum relative speed. Speed cap is necessary for stability. Typically 10m/s or less.
/// @param wake should this wake the body
b3Shape_ApplyWind :: (shapeId: b3ShapeId, wind: b3Vec3, drag: float, lift: float, maxSpeed: float, wake: bool) -> void #foreign box3d;

/// Destroy a joint
b3DestroyJoint :: (jointId: b3JointId, wakeAttached: bool) -> void #foreign box3d;

/// Joint identifier validation. Provides validation for up to 64K allocations.
b3Joint_IsValid :: (id: b3JointId) -> bool #foreign box3d;

/// Get the joint type
b3Joint_GetType :: (jointId: b3JointId) -> b3JointType #foreign box3d;

/// Get body A id on a joint
b3Joint_GetBodyA :: (jointId: b3JointId) -> b3BodyId #foreign box3d;

/// Get body B id on a joint
b3Joint_GetBodyB :: (jointId: b3JointId) -> b3BodyId #foreign box3d;

/// Get the world that owns this joint
b3Joint_GetWorld :: (jointId: b3JointId) -> b3WorldId #foreign box3d;

/// Set the local frame on bodyA
b3Joint_SetLocalFrameA :: (jointId: b3JointId, localFrame: b3Transform) -> void #foreign box3d;

/// Get the local frame on bodyA
b3Joint_GetLocalFrameA :: (jointId: b3JointId) -> b3Transform #foreign box3d;

/// Set the local frame on bodyB
b3Joint_SetLocalFrameB :: (jointId: b3JointId, localFrame: b3Transform) -> void #foreign box3d;

/// Get the local frame on bodyB
b3Joint_GetLocalFrameB :: (jointId: b3JointId) -> b3Transform #foreign box3d;

/// Toggle collision between connected bodies
b3Joint_SetCollideConnected :: (jointId: b3JointId, shouldCollide: bool) -> void #foreign box3d;

/// Is collision allowed between connected bodies?
b3Joint_GetCollideConnected :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the user data on a joint
b3Joint_SetUserData :: (jointId: b3JointId, userData: *void) -> void #foreign box3d;

/// Get the user data on a joint
b3Joint_GetUserData :: (jointId: b3JointId) -> *void #foreign box3d;

/// Wake the bodies connect to this joint
b3Joint_WakeBodies :: (jointId: b3JointId) -> void #foreign box3d;

/// Get the current constraint force for this joint
b3Joint_GetConstraintForce :: (jointId: b3JointId) -> b3Vec3 #foreign box3d;

/// Get the current constraint torque for this joint
b3Joint_GetConstraintTorque :: (jointId: b3JointId) -> b3Vec3 #foreign box3d;

/// Get the current linear separation error for this joint. Does not consider admissible movement. Usually in meters.
b3Joint_GetLinearSeparation :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the current angular separation error for this joint. Does not consider admissible movement. Usually in radians.
b3Joint_GetAngularSeparation :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the joint constraint tuning. Advanced feature.
/// @param jointId the joint
/// @param hertz the stiffness in Hertz (cycles per second)
/// @param dampingRatio the non-dimensional damping ratio (one for critical damping)
b3Joint_SetConstraintTuning :: (jointId: b3JointId, hertz: float, dampingRatio: float) -> void #foreign box3d;

/// Get the joint constraint tuning. Advanced feature.
b3Joint_GetConstraintTuning :: (jointId: b3JointId, hertz: *float, dampingRatio: *float) -> void #foreign box3d;

/// Set the force threshold for joint events (Newtons)
b3Joint_SetForceThreshold :: (jointId: b3JointId, threshold: float) -> void #foreign box3d;

/// Get the force threshold for joint events (Newtons)
b3Joint_GetForceThreshold :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the torque threshold for joint events (N-m)
b3Joint_SetTorqueThreshold :: (jointId: b3JointId, threshold: float) -> void #foreign box3d;

/// Get the torque threshold for joint events (N-m)
b3Joint_GetTorqueThreshold :: (jointId: b3JointId) -> float #foreign box3d;

/// Create a parallel joint
/// @see b3ParallelJointDef for details
b3CreateParallelJoint :: (worldId: b3WorldId, def: *b3ParallelJointDef) -> b3JointId #foreign box3d;

/// Set the spring stiffness in Hertz
b3ParallelJoint_SetSpringHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Set the spring damping ratio, non-dimensional
b3ParallelJoint_SetSpringDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the spring Hertz
b3ParallelJoint_GetSpringHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the spring damping ratio
b3ParallelJoint_GetSpringDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the maximum spring torque, usually in newton-meters
b3ParallelJoint_SetMaxTorque :: (jointId: b3JointId, force: float) -> void #foreign box3d;

/// Get the maximum spring torque, usually in newton-meters
b3ParallelJoint_GetMaxTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Create a distance joint
/// @see b3DistanceJointDef for details
b3CreateDistanceJoint :: (worldId: b3WorldId, def: *b3DistanceJointDef) -> b3JointId #foreign box3d;

/// Set the rest length of a distance joint
/// @param jointId The id for a distance joint
/// @param length The new distance joint length
b3DistanceJoint_SetLength :: (jointId: b3JointId, length: float) -> void #foreign box3d;

/// Get the rest length of a distance joint
b3DistanceJoint_GetLength :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable the distance joint spring. When disabled the distance joint is rigid.
b3DistanceJoint_EnableSpring :: (jointId: b3JointId, enableSpring: bool) -> void #foreign box3d;

/// Is the distance joint spring enabled?
b3DistanceJoint_IsSpringEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the force range for the spring.
b3DistanceJoint_SetSpringForceRange :: (jointId: b3JointId, lowerForce: float, upperForce: float) -> void #foreign box3d;

/// Get the force range for the spring.
b3DistanceJoint_GetSpringForceRange :: (jointId: b3JointId, lowerForce: *float, upperForce: *float) -> void #foreign box3d;

/// Set the spring stiffness in Hertz
b3DistanceJoint_SetSpringHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Set the spring damping ratio, non-dimensional
b3DistanceJoint_SetSpringDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the spring Hertz
b3DistanceJoint_GetSpringHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the spring damping ratio
b3DistanceJoint_GetSpringDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable joint limit. The limit only works if the joint spring is enabled. Otherwise the joint is rigid
/// and the limit has no effect.
b3DistanceJoint_EnableLimit :: (jointId: b3JointId, enableLimit: bool) -> void #foreign box3d;

/// Is the distance joint limit enabled?
b3DistanceJoint_IsLimitEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the minimum and maximum length parameters of a distance joint
b3DistanceJoint_SetLengthRange :: (jointId: b3JointId, minLength: float, maxLength: float) -> void #foreign box3d;

/// Get the distance joint minimum length
b3DistanceJoint_GetMinLength :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the distance joint maximum length
b3DistanceJoint_GetMaxLength :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the current length of a distance joint
b3DistanceJoint_GetCurrentLength :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable the distance joint motor
b3DistanceJoint_EnableMotor :: (jointId: b3JointId, enableMotor: bool) -> void #foreign box3d;

/// Is the distance joint motor enabled?
b3DistanceJoint_IsMotorEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the distance joint motor speed, usually in meters per second
b3DistanceJoint_SetMotorSpeed :: (jointId: b3JointId, motorSpeed: float) -> void #foreign box3d;

/// Get the distance joint motor speed, usually in meters per second
b3DistanceJoint_GetMotorSpeed :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the distance joint maximum motor force, usually in newtons
b3DistanceJoint_SetMaxMotorForce :: (jointId: b3JointId, force: float) -> void #foreign box3d;

/// Get the distance joint maximum motor force, usually in newtons
b3DistanceJoint_GetMaxMotorForce :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the distance joint current motor force, usually in newtons
b3DistanceJoint_GetMotorForce :: (jointId: b3JointId) -> float #foreign box3d;

/// Create a motor joint
/// @see b3MotorJointDef for details
b3CreateMotorJoint :: (worldId: b3WorldId, def: *b3MotorJointDef) -> b3JointId #foreign box3d;

/// Set the desired relative linear velocity in meters per second
b3MotorJoint_SetLinearVelocity :: (jointId: b3JointId, velocity: b3Vec3) -> void #foreign box3d;

/// Get the desired relative linear velocity in meters per second
b3MotorJoint_GetLinearVelocity :: (jointId: b3JointId) -> b3Vec3 #foreign box3d;

/// Set the desired relative angular velocity in radians per second
b3MotorJoint_SetAngularVelocity :: (jointId: b3JointId, velocity: b3Vec3) -> void #foreign box3d;

/// Get the desired relative angular velocity in radians per second
b3MotorJoint_GetAngularVelocity :: (jointId: b3JointId) -> b3Vec3 #foreign box3d;

/// Set the motor joint maximum force, usually in newtons
b3MotorJoint_SetMaxVelocityForce :: (jointId: b3JointId, maxForce: float) -> void #foreign box3d;

/// Get the motor joint maximum force, usually in newtons
b3MotorJoint_GetMaxVelocityForce :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the motor joint maximum torque, usually in newton-meters
b3MotorJoint_SetMaxVelocityTorque :: (jointId: b3JointId, maxTorque: float) -> void #foreign box3d;

/// Get the motor joint maximum torque, usually in newton-meters
b3MotorJoint_GetMaxVelocityTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the spring linear hertz stiffness
b3MotorJoint_SetLinearHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the spring linear hertz stiffness
b3MotorJoint_GetLinearHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the spring linear damping ratio. Use 1.0 for critical damping.
b3MotorJoint_SetLinearDampingRatio :: (jointId: b3JointId, damping: float) -> void #foreign box3d;

/// Get the spring linear damping ratio.
b3MotorJoint_GetLinearDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the spring angular hertz stiffness
b3MotorJoint_SetAngularHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the spring angular hertz stiffness
b3MotorJoint_GetAngularHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the spring angular damping ratio. Use 1.0 for critical damping.
b3MotorJoint_SetAngularDampingRatio :: (jointId: b3JointId, damping: float) -> void #foreign box3d;

/// Get the spring angular damping ratio.
b3MotorJoint_GetAngularDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the maximum spring force in newtons.
b3MotorJoint_SetMaxSpringForce :: (jointId: b3JointId, maxForce: float) -> void #foreign box3d;

/// Get the maximum spring force in newtons.
b3MotorJoint_GetMaxSpringForce :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the maximum spring torque in newtons * meters
b3MotorJoint_SetMaxSpringTorque :: (jointId: b3JointId, maxTorque: float) -> void #foreign box3d;

/// Get the maximum spring torque in newtons * meters
b3MotorJoint_GetMaxSpringTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Create a filter joint.
/// @see b3FilterJointDef for details
b3CreateFilterJoint :: (worldId: b3WorldId, def: *b3FilterJointDef) -> b3JointId #foreign box3d;

/// Create a prismatic (slider) joint.
/// @see b3PrismaticJointDef for details
b3CreatePrismaticJoint :: (worldId: b3WorldId, def: *b3PrismaticJointDef) -> b3JointId #foreign box3d;

/// Enable/disable the joint spring.
b3PrismaticJoint_EnableSpring :: (jointId: b3JointId, enableSpring: bool) -> void #foreign box3d;

/// Is the prismatic joint spring enabled or not?
b3PrismaticJoint_IsSpringEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the prismatic joint stiffness in Hertz.
/// This should usually be less than a quarter of the simulation rate. For example, if the simulation
/// runs at 60Hz then the joint stiffness should be 15Hz or less.
b3PrismaticJoint_SetSpringHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the prismatic joint stiffness in Hertz
b3PrismaticJoint_GetSpringHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the prismatic joint damping ratio (non-dimensional)
b3PrismaticJoint_SetSpringDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the prismatic spring damping ratio (non-dimensional)
b3PrismaticJoint_GetSpringDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the prismatic joint target translation. Usually in meters.
b3PrismaticJoint_SetTargetTranslation :: (jointId: b3JointId, targetTranslation: float) -> void #foreign box3d;

/// Get the prismatic joint target translation. Usually in meters.
b3PrismaticJoint_GetTargetTranslation :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable a prismatic joint limit
b3PrismaticJoint_EnableLimit :: (jointId: b3JointId, enableLimit: bool) -> void #foreign box3d;

/// Is the prismatic joint limit enabled?
b3PrismaticJoint_IsLimitEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Get the prismatic joint lower limit
b3PrismaticJoint_GetLowerLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the prismatic joint upper limit
b3PrismaticJoint_GetUpperLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the prismatic joint limits
b3PrismaticJoint_SetLimits :: (jointId: b3JointId, lower: float, upper: float) -> void #foreign box3d;

/// Enable/disable a prismatic joint motor
b3PrismaticJoint_EnableMotor :: (jointId: b3JointId, enableMotor: bool) -> void #foreign box3d;

/// Is the prismatic joint motor enabled?
b3PrismaticJoint_IsMotorEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the prismatic joint motor speed, usually in meters per second
b3PrismaticJoint_SetMotorSpeed :: (jointId: b3JointId, motorSpeed: float) -> void #foreign box3d;

/// Get the prismatic joint motor speed, usually in meters per second
b3PrismaticJoint_GetMotorSpeed :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the prismatic joint maximum motor force, usually in newtons
b3PrismaticJoint_SetMaxMotorForce :: (jointId: b3JointId, force: float) -> void #foreign box3d;

/// Get the prismatic joint maximum motor force, usually in newtons
b3PrismaticJoint_GetMaxMotorForce :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the prismatic joint current motor force, usually in newtons
b3PrismaticJoint_GetMotorForce :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the current joint translation, usually in meters.
b3PrismaticJoint_GetTranslation :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the current joint translation speed, usually in meters per second.
b3PrismaticJoint_GetSpeed :: (jointId: b3JointId) -> float #foreign box3d;

/// Create a revolute joint
/// @see b3RevoluteJointDef for details
b3CreateRevoluteJoint :: (worldId: b3WorldId, def: *b3RevoluteJointDef) -> b3JointId #foreign box3d;

/// Enable/disable the revolute joint spring
b3RevoluteJoint_EnableSpring :: (jointId: b3JointId, enableSpring: bool) -> void #foreign box3d;

/// Is the revolute angular spring enabled?
b3RevoluteJoint_IsSpringEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the revolute joint spring stiffness in Hertz
b3RevoluteJoint_SetSpringHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the revolute joint spring stiffness in Hertz
b3RevoluteJoint_GetSpringHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the revolute joint spring damping ratio, non-dimensional
b3RevoluteJoint_SetSpringDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the revolute joint spring damping ratio, non-dimensional
b3RevoluteJoint_GetSpringDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the revolute joint target angle in radians
b3RevoluteJoint_SetTargetAngle :: (jointId: b3JointId, targetRadians: float) -> void #foreign box3d;

/// Get the revolute joint target angle in radians
b3RevoluteJoint_GetTargetAngle :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the revolute joint current angle in radians relative to the reference angle
/// @see b3RevoluteJointDef::referenceAngle
b3RevoluteJoint_GetAngle :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable the revolute joint limit
b3RevoluteJoint_EnableLimit :: (jointId: b3JointId, enableLimit: bool) -> void #foreign box3d;

/// Is the revolute joint limit enabled?
b3RevoluteJoint_IsLimitEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Get the revolute joint lower limit in radians
b3RevoluteJoint_GetLowerLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the revolute joint upper limit in radians
b3RevoluteJoint_GetUpperLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the revolute joint limits in radians
b3RevoluteJoint_SetLimits :: (jointId: b3JointId, lowerLimitRadians: float, upperLimitRadians: float) -> void #foreign box3d;

/// Enable/disable a revolute joint motor
b3RevoluteJoint_EnableMotor :: (jointId: b3JointId, enableMotor: bool) -> void #foreign box3d;

/// Is the revolute joint motor enabled?
b3RevoluteJoint_IsMotorEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the revolute joint motor speed in radians per second
b3RevoluteJoint_SetMotorSpeed :: (jointId: b3JointId, motorSpeed: float) -> void #foreign box3d;

/// Get the revolute joint motor speed in radians per second
b3RevoluteJoint_GetMotorSpeed :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the revolute joint current motor torque, usually in newton-meters
b3RevoluteJoint_GetMotorTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the revolute joint maximum motor torque, usually in newton-meters
b3RevoluteJoint_SetMaxMotorTorque :: (jointId: b3JointId, torque: float) -> void #foreign box3d;

/// Get the revolute joint maximum motor torque, usually in newton-meters
b3RevoluteJoint_GetMaxMotorTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Create a spherical joint
/// @see b3SphericalJointDef for details
b3CreateSphericalJoint :: (worldId: b3WorldId, def: *b3SphericalJointDef) -> b3JointId #foreign box3d;

/// Enable/disable the spherical joint cone limit
b3SphericalJoint_EnableConeLimit :: (jointId: b3JointId, enableLimit: bool) -> void #foreign box3d;

/// Is the spherical joint cone limit enabled?
b3SphericalJoint_IsConeLimitEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Get the spherical joint cone limit in radians
b3SphericalJoint_GetConeLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the spherical joint limits in radians
b3SphericalJoint_SetConeLimit :: (jointId: b3JointId, angleRadians: float) -> void #foreign box3d;

/// Get the spherical joint current cone angle in radians.
b3SphericalJoint_GetConeAngle :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable the spherical joint limit
b3SphericalJoint_EnableTwistLimit :: (jointId: b3JointId, enableLimit: bool) -> void #foreign box3d;

/// Is the spherical joint limit enabled?
b3SphericalJoint_IsTwistLimitEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Get the spherical joint lower limit in radians
b3SphericalJoint_GetLowerTwistLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the spherical joint upper limit in radians
b3SphericalJoint_GetUpperTwistLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the spherical joint limits in radians
b3SphericalJoint_SetTwistLimits :: (jointId: b3JointId, lowerLimitRadians: float, upperLimitRadians: float) -> void #foreign box3d;

/// Get the spherical joint current twist angle in radians.
b3SphericalJoint_GetTwistAngle :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable the spherical joint spring
b3SphericalJoint_EnableSpring :: (jointId: b3JointId, enableSpring: bool) -> void #foreign box3d;

/// Is the spherical angular spring enabled?
b3SphericalJoint_IsSpringEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the spherical joint spring stiffness in Hertz
b3SphericalJoint_SetSpringHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the spherical joint spring stiffness in Hertz
b3SphericalJoint_GetSpringHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the spherical joint spring damping ratio, non-dimensional
b3SphericalJoint_SetSpringDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the spherical joint spring damping ratio, non-dimensional
b3SphericalJoint_GetSpringDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the spherical joint spring target rotation
b3SphericalJoint_SetTargetRotation :: (jointId: b3JointId, targetRotation: b3Quat) -> void #foreign box3d;

/// Get the spherical joint spring target rotation
b3SphericalJoint_GetTargetRotation :: (jointId: b3JointId) -> b3Quat #foreign box3d;

/// Enable/disable a spherical joint motor
b3SphericalJoint_EnableMotor :: (jointId: b3JointId, enableMotor: bool) -> void #foreign box3d;

/// Is the spherical joint motor enabled?
b3SphericalJoint_IsMotorEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the spherical joint motor velocity in radians per second
b3SphericalJoint_SetMotorVelocity :: (jointId: b3JointId, motorVelocity: b3Vec3) -> void #foreign box3d;

/// Get the spherical joint motor velocity in radians per second
b3SphericalJoint_GetMotorVelocity :: (jointId: b3JointId) -> b3Vec3 #foreign box3d;

/// Get the spherical joint current motor torque, usually in newton-meters
b3SphericalJoint_GetMotorTorque :: (jointId: b3JointId) -> b3Vec3 #foreign box3d;

/// Set the spherical joint maximum motor torque, usually in newton-meters
b3SphericalJoint_SetMaxMotorTorque :: (jointId: b3JointId, torque: float) -> void #foreign box3d;

/// Get the spherical joint maximum motor torque, usually in newton-meters
b3SphericalJoint_GetMaxMotorTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Create a weld joint
/// @see b3WeldJointDef for details
b3CreateWeldJoint :: (worldId: b3WorldId, def: *b3WeldJointDef) -> b3JointId #foreign box3d;

/// Set the weld joint linear stiffness in Hertz. 0 is rigid.
b3WeldJoint_SetLinearHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the weld joint linear stiffness in Hertz
b3WeldJoint_GetLinearHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the weld joint linear damping ratio (non-dimensional)
b3WeldJoint_SetLinearDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the weld joint linear damping ratio (non-dimensional)
b3WeldJoint_GetLinearDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the weld joint angular stiffness in Hertz. 0 is rigid.
b3WeldJoint_SetAngularHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the weld joint angular stiffness in Hertz
b3WeldJoint_GetAngularHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set weld joint angular damping ratio, non-dimensional
b3WeldJoint_SetAngularDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the weld joint angular damping ratio, non-dimensional
b3WeldJoint_GetAngularDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Create a wheel joint.
/// @see b3WheelJointDef for details.
b3CreateWheelJoint :: (worldId: b3WorldId, def: *b3WheelJointDef) -> b3JointId #foreign box3d;

/// Enable/disable the wheel joint spring.
b3WheelJoint_EnableSuspension :: (jointId: b3JointId, flag: bool) -> void #foreign box3d;

/// Is the wheel joint spring enabled?
b3WheelJoint_IsSuspensionEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the wheel joint stiffness in Hertz.
b3WheelJoint_SetSuspensionHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the wheel joint stiffness in Hertz.
b3WheelJoint_GetSuspensionHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the wheel joint damping ratio, non-dimensional.
b3WheelJoint_SetSuspensionDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the wheel joint damping ratio, non-dimensional.
b3WheelJoint_GetSuspensionDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable the wheel joint limit.
b3WheelJoint_EnableSuspensionLimit :: (jointId: b3JointId, flag: bool) -> void #foreign box3d;

/// Is the wheel joint limit enabled?
b3WheelJoint_IsSuspensionLimitEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Get the wheel joint lower limit.
b3WheelJoint_GetLowerSuspensionLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the wheel joint upper limit.
b3WheelJoint_GetUpperSuspensionLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the wheel joint limits.
b3WheelJoint_SetSuspensionLimits :: (jointId: b3JointId, lower: float, upper: float) -> void #foreign box3d;

/// Enable/disable the wheel joint motor.
b3WheelJoint_EnableSpinMotor :: (jointId: b3JointId, flag: bool) -> void #foreign box3d;

/// Is the wheel joint motor enabled?
b3WheelJoint_IsSpinMotorEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the wheel joint motor speed in radians per second.
b3WheelJoint_SetSpinMotorSpeed :: (jointId: b3JointId, speed: float) -> void #foreign box3d;

/// Get the wheel joint motor speed in radians per second.
b3WheelJoint_GetSpinMotorSpeed :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the wheel joint maximum motor torque, usually in newton-meters.
b3WheelJoint_SetMaxSpinTorque :: (jointId: b3JointId, torque: float) -> void #foreign box3d;

/// Get the wheel joint maximum motor torque, usually in newton-meters.
b3WheelJoint_GetMaxSpinTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the current spin speed in radians per second.
b3WheelJoint_GetSpinSpeed :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the wheel joint current motor torque, usually in newton-meters.
b3WheelJoint_GetSpinTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable wheel steering. Steering allows the wheel to rotate about the suspension axis.
b3WheelJoint_EnableSteering :: (jointId: b3JointId, flag: bool) -> void #foreign box3d;

/// Can the wheel steer?
b3WheelJoint_IsSteeringEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Set the wheel joint steering stiffness in Hertz.
b3WheelJoint_SetSteeringHertz :: (jointId: b3JointId, hertz: float) -> void #foreign box3d;

/// Get the wheel joint steering stiffness in Hertz.
b3WheelJoint_GetSteeringHertz :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the wheel joint steering damping ratio, non-dimensional.
b3WheelJoint_SetSteeringDampingRatio :: (jointId: b3JointId, dampingRatio: float) -> void #foreign box3d;

/// Get the wheel joint steering damping ratio, non-dimensional.
b3WheelJoint_GetSteeringDampingRatio :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the wheel joint maximum steering torque in N*m.
b3WheelJoint_SetMaxSteeringTorque :: (jointId: b3JointId, torque: float) -> void #foreign box3d;

/// Get the wheel joint maximum steering torque in N*m.
b3WheelJoint_GetMaxSteeringTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Enable/disable the wheel joint steering limit.
b3WheelJoint_EnableSteeringLimit :: (jointId: b3JointId, flag: bool) -> void #foreign box3d;

/// Is the wheel joint steering limit enabled?
b3WheelJoint_IsSteeringLimitEnabled :: (jointId: b3JointId) -> bool #foreign box3d;

/// Get the wheel joint lower steering limit in radians.
b3WheelJoint_GetLowerSteeringLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the wheel joint upper steering limit in radians.
b3WheelJoint_GetUpperSteeringLimit :: (jointId: b3JointId) -> float #foreign box3d;

/// Set the wheel joint steering limits in radians.
b3WheelJoint_SetSteeringLimits :: (jointId: b3JointId, lowerRadians: float, upperRadians: float) -> void #foreign box3d;

/// Set the wheel joint target steering angle in radians.
b3WheelJoint_SetTargetSteeringAngle :: (jointId: b3JointId, radians: float) -> void #foreign box3d;

/// Get the wheel joint target steering angle in radians.
b3WheelJoint_GetTargetSteeringAngle :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the current steering angle in radians.
b3WheelJoint_GetSteeringAngle :: (jointId: b3JointId) -> float #foreign box3d;

/// Get the current steering torque in N*m.
b3WheelJoint_GetSteeringTorque :: (jointId: b3JointId) -> float #foreign box3d;

/// Contact identifier validation. Provides validation for up to 2^32 allocations.
b3Contact_IsValid :: (id: b3ContactId) -> bool #foreign box3d;

/// Get the manifolds for a contact. The manifold may have no points if the contact is not touching.
b3Contact_GetData :: (contactId: b3ContactId) -> b3ContactData #foreign box3d;

#scope_file

#import "Basic"; // For assert


#run {
    {
        info := type_info(b3Version);
        for info.members {
            if it.name == {
                case "major";
                    assert(it.offset_in_bytes == 0, "b3Version.major has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Version.major has unexpected size % instead of 4", it.type.runtime_size);
                case "minor";
                    assert(it.offset_in_bytes == 4, "b3Version.minor has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Version.minor has unexpected size % instead of 4", it.type.runtime_size);
                case "revision";
                    assert(it.offset_in_bytes == 8, "b3Version.revision has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Version.revision has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Version) == 12, "b3Version has size % instead of 12", size_of(b3Version));
    }

    {
        info := type_info(b3Vec2);
        for info.members {
            if it.name == {
                case "x";
                    assert(it.offset_in_bytes == 0, "b3Vec2.x has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Vec2.x has unexpected size % instead of 4", it.type.runtime_size);
                case "y";
                    assert(it.offset_in_bytes == 4, "b3Vec2.y has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Vec2.y has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Vec2) == 8, "b3Vec2 has size % instead of 8", size_of(b3Vec2));
    }

    {
        info := type_info(b3Vec3);
        for info.members {
            if it.name == {
                case "x";
                    assert(it.offset_in_bytes == 0, "b3Vec3.x has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Vec3.x has unexpected size % instead of 4", it.type.runtime_size);
                case "y";
                    assert(it.offset_in_bytes == 4, "b3Vec3.y has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Vec3.y has unexpected size % instead of 4", it.type.runtime_size);
                case "z";
                    assert(it.offset_in_bytes == 8, "b3Vec3.z has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Vec3.z has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Vec3) == 12, "b3Vec3 has size % instead of 12", size_of(b3Vec3));
    }

    {
        info := type_info(b3CosSin);
        for info.members {
            if it.name == {
                case "cosine";
                    assert(it.offset_in_bytes == 0, "b3CosSin.cosine has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CosSin.cosine has unexpected size % instead of 4", it.type.runtime_size);
                case "sine";
                    assert(it.offset_in_bytes == 4, "b3CosSin.sine has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CosSin.sine has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3CosSin) == 8, "b3CosSin has size % instead of 8", size_of(b3CosSin));
    }

    {
        info := type_info(b3Quat);
        for info.members {
            if it.name == {
                case "v";
                    assert(it.offset_in_bytes == 0, "b3Quat.v has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Quat.v has unexpected size % instead of 12", it.type.runtime_size);
                case "s";
                    assert(it.offset_in_bytes == 12, "b3Quat.s has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Quat.s has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Quat) == 16, "b3Quat has size % instead of 16", size_of(b3Quat));
    }

    {
        info := type_info(b3Transform);
        for info.members {
            if it.name == {
                case "p";
                    assert(it.offset_in_bytes == 0, "b3Transform.p has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Transform.p has unexpected size % instead of 12", it.type.runtime_size);
                case "q";
                    assert(it.offset_in_bytes == 12, "b3Transform.q has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3Transform.q has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(b3Transform) == 28, "b3Transform has size % instead of 28", size_of(b3Transform));
    }

    {
        info := type_info(b3Matrix3);
        for info.members {
            if it.name == {
                case "cx";
                    assert(it.offset_in_bytes == 0, "b3Matrix3.cx has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Matrix3.cx has unexpected size % instead of 12", it.type.runtime_size);
                case "cy";
                    assert(it.offset_in_bytes == 12, "b3Matrix3.cy has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Matrix3.cy has unexpected size % instead of 12", it.type.runtime_size);
                case "cz";
                    assert(it.offset_in_bytes == 24, "b3Matrix3.cz has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Matrix3.cz has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(b3Matrix3) == 36, "b3Matrix3 has size % instead of 36", size_of(b3Matrix3));
    }

    {
        info := type_info(b3AABB);
        for info.members {
            if it.name == {
                case "lowerBound";
                    assert(it.offset_in_bytes == 0, "b3AABB.lowerBound has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3AABB.lowerBound has unexpected size % instead of 12", it.type.runtime_size);
                case "upperBound";
                    assert(it.offset_in_bytes == 12, "b3AABB.upperBound has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3AABB.upperBound has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(b3AABB) == 24, "b3AABB has size % instead of 24", size_of(b3AABB));
    }

    {
        info := type_info(b3Plane);
        for info.members {
            if it.name == {
                case "normal";
                    assert(it.offset_in_bytes == 0, "b3Plane.normal has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Plane.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "offset";
                    assert(it.offset_in_bytes == 12, "b3Plane.offset has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Plane.offset has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Plane) == 16, "b3Plane has size % instead of 16", size_of(b3Plane));
    }

    {
        info := type_info(b3SegmentDistanceResult);
        for info.members {
            if it.name == {
                case "point1";
                    assert(it.offset_in_bytes == 0, "b3SegmentDistanceResult.point1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3SegmentDistanceResult.point1 has unexpected size % instead of 12", it.type.runtime_size);
                case "fraction1";
                    assert(it.offset_in_bytes == 12, "b3SegmentDistanceResult.fraction1 has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SegmentDistanceResult.fraction1 has unexpected size % instead of 4", it.type.runtime_size);
                case "point2";
                    assert(it.offset_in_bytes == 16, "b3SegmentDistanceResult.point2 has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3SegmentDistanceResult.point2 has unexpected size % instead of 12", it.type.runtime_size);
                case "fraction2";
                    assert(it.offset_in_bytes == 28, "b3SegmentDistanceResult.fraction2 has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SegmentDistanceResult.fraction2 has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3SegmentDistanceResult) == 32, "b3SegmentDistanceResult has size % instead of 32", size_of(b3SegmentDistanceResult));
    }

    {
        info := type_info(b3WorldId);
        for info.members {
            if it.name == {
                case "index1";
                    assert(it.offset_in_bytes == 0, "b3WorldId.index1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3WorldId.index1 has unexpected size % instead of 2", it.type.runtime_size);
                case "generation";
                    assert(it.offset_in_bytes == 2, "b3WorldId.generation has unexpected offset % instead of 2", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3WorldId.generation has unexpected size % instead of 2", it.type.runtime_size);
            }
        }
        assert(size_of(b3WorldId) == 4, "b3WorldId has size % instead of 4", size_of(b3WorldId));
    }

    {
        info := type_info(b3BodyId);
        for info.members {
            if it.name == {
                case "index1";
                    assert(it.offset_in_bytes == 0, "b3BodyId.index1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyId.index1 has unexpected size % instead of 4", it.type.runtime_size);
                case "world0";
                    assert(it.offset_in_bytes == 4, "b3BodyId.world0 has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3BodyId.world0 has unexpected size % instead of 2", it.type.runtime_size);
                case "generation";
                    assert(it.offset_in_bytes == 6, "b3BodyId.generation has unexpected offset % instead of 6", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3BodyId.generation has unexpected size % instead of 2", it.type.runtime_size);
            }
        }
        assert(size_of(b3BodyId) == 8, "b3BodyId has size % instead of 8", size_of(b3BodyId));
    }

    {
        info := type_info(b3ShapeId);
        for info.members {
            if it.name == {
                case "index1";
                    assert(it.offset_in_bytes == 0, "b3ShapeId.index1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeId.index1 has unexpected size % instead of 4", it.type.runtime_size);
                case "world0";
                    assert(it.offset_in_bytes == 4, "b3ShapeId.world0 has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3ShapeId.world0 has unexpected size % instead of 2", it.type.runtime_size);
                case "generation";
                    assert(it.offset_in_bytes == 6, "b3ShapeId.generation has unexpected offset % instead of 6", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3ShapeId.generation has unexpected size % instead of 2", it.type.runtime_size);
            }
        }
        assert(size_of(b3ShapeId) == 8, "b3ShapeId has size % instead of 8", size_of(b3ShapeId));
    }

    {
        info := type_info(b3JointId);
        for info.members {
            if it.name == {
                case "index1";
                    assert(it.offset_in_bytes == 0, "b3JointId.index1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3JointId.index1 has unexpected size % instead of 4", it.type.runtime_size);
                case "world0";
                    assert(it.offset_in_bytes == 4, "b3JointId.world0 has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3JointId.world0 has unexpected size % instead of 2", it.type.runtime_size);
                case "generation";
                    assert(it.offset_in_bytes == 6, "b3JointId.generation has unexpected offset % instead of 6", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3JointId.generation has unexpected size % instead of 2", it.type.runtime_size);
            }
        }
        assert(size_of(b3JointId) == 8, "b3JointId has size % instead of 8", size_of(b3JointId));
    }

    {
        info := type_info(b3ContactId);
        for info.members {
            if it.name == {
                case "index1";
                    assert(it.offset_in_bytes == 0, "b3ContactId.index1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ContactId.index1 has unexpected size % instead of 4", it.type.runtime_size);
                case "world0";
                    assert(it.offset_in_bytes == 4, "b3ContactId.world0 has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3ContactId.world0 has unexpected size % instead of 2", it.type.runtime_size);
                case "padding";
                    assert(it.offset_in_bytes == 6, "b3ContactId.padding has unexpected offset % instead of 6", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3ContactId.padding has unexpected size % instead of 2", it.type.runtime_size);
                case "generation";
                    assert(it.offset_in_bytes == 8, "b3ContactId.generation has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ContactId.generation has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3ContactId) == 12, "b3ContactId has size % instead of 12", size_of(b3ContactId));
    }

    {
        info := type_info(b3PreSolveData);
        for info.members {
            if it.name == {
                case "phase";
                    assert(it.offset_in_bytes == 0, "b3PreSolveData.phase has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PreSolveData.phase has unexpected size % instead of 4", it.type.runtime_size);
                case "manifolds";
                    assert(it.offset_in_bytes == 8, "b3PreSolveData.manifolds has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3PreSolveData.manifolds has unexpected size % instead of 8", it.type.runtime_size);
                case "manifoldCount";
                    assert(it.offset_in_bytes == 16, "b3PreSolveData.manifoldCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PreSolveData.manifoldCount has unexpected size % instead of 4", it.type.runtime_size);
                case "centerA";
                    assert(it.offset_in_bytes == 20, "b3PreSolveData.centerA has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3PreSolveData.centerA has unexpected size % instead of 12", it.type.runtime_size);
                case "centerB";
                    assert(it.offset_in_bytes == 32, "b3PreSolveData.centerB has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3PreSolveData.centerB has unexpected size % instead of 12", it.type.runtime_size);
                case "childIndexA";
                    assert(it.offset_in_bytes == 44, "b3PreSolveData.childIndexA has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PreSolveData.childIndexA has unexpected size % instead of 4", it.type.runtime_size);
                case "childIndexB";
                    assert(it.offset_in_bytes == 48, "b3PreSolveData.childIndexB has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PreSolveData.childIndexB has unexpected size % instead of 4", it.type.runtime_size);
                case "point";
                    assert(it.offset_in_bytes == 52, "b3PreSolveData.point has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3PreSolveData.point has unexpected size % instead of 12", it.type.runtime_size);
                case "normal";
                    assert(it.offset_in_bytes == 64, "b3PreSolveData.normal has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3PreSolveData.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "fraction";
                    assert(it.offset_in_bytes == 76, "b3PreSolveData.fraction has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PreSolveData.fraction has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleIndexA";
                    assert(it.offset_in_bytes == 80, "b3PreSolveData.triangleIndexA has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PreSolveData.triangleIndexA has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleIndexB";
                    assert(it.offset_in_bytes == 84, "b3PreSolveData.triangleIndexB has unexpected offset % instead of 84", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PreSolveData.triangleIndexB has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3PreSolveData) == 88, "b3PreSolveData has size % instead of 88", size_of(b3PreSolveData));
    }

    {
        info := type_info(b3Capacity);
        for info.members {
            if it.name == {
                case "staticShapeCount";
                    assert(it.offset_in_bytes == 0, "b3Capacity.staticShapeCount has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Capacity.staticShapeCount has unexpected size % instead of 4", it.type.runtime_size);
                case "dynamicShapeCount";
                    assert(it.offset_in_bytes == 4, "b3Capacity.dynamicShapeCount has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Capacity.dynamicShapeCount has unexpected size % instead of 4", it.type.runtime_size);
                case "staticBodyCount";
                    assert(it.offset_in_bytes == 8, "b3Capacity.staticBodyCount has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Capacity.staticBodyCount has unexpected size % instead of 4", it.type.runtime_size);
                case "dynamicBodyCount";
                    assert(it.offset_in_bytes == 12, "b3Capacity.dynamicBodyCount has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Capacity.dynamicBodyCount has unexpected size % instead of 4", it.type.runtime_size);
                case "contactCount";
                    assert(it.offset_in_bytes == 16, "b3Capacity.contactCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Capacity.contactCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Capacity) == 20, "b3Capacity has size % instead of 20", size_of(b3Capacity));
    }

    {
        info := type_info(b3WorldDef);
        for info.members {
            if it.name == {
                case "gravity";
                    assert(it.offset_in_bytes == 0, "b3WorldDef.gravity has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3WorldDef.gravity has unexpected size % instead of 12", it.type.runtime_size);
                case "restitutionThreshold";
                    assert(it.offset_in_bytes == 12, "b3WorldDef.restitutionThreshold has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WorldDef.restitutionThreshold has unexpected size % instead of 4", it.type.runtime_size);
                case "hitEventThreshold";
                    assert(it.offset_in_bytes == 16, "b3WorldDef.hitEventThreshold has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WorldDef.hitEventThreshold has unexpected size % instead of 4", it.type.runtime_size);
                case "contactHertz";
                    assert(it.offset_in_bytes == 20, "b3WorldDef.contactHertz has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WorldDef.contactHertz has unexpected size % instead of 4", it.type.runtime_size);
                case "contactDampingRatio";
                    assert(it.offset_in_bytes == 24, "b3WorldDef.contactDampingRatio has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WorldDef.contactDampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "contactSpeed";
                    assert(it.offset_in_bytes == 28, "b3WorldDef.contactSpeed has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WorldDef.contactSpeed has unexpected size % instead of 4", it.type.runtime_size);
                case "maximumLinearSpeed";
                    assert(it.offset_in_bytes == 32, "b3WorldDef.maximumLinearSpeed has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WorldDef.maximumLinearSpeed has unexpected size % instead of 4", it.type.runtime_size);
                case "frictionCallback";
                    assert(it.offset_in_bytes == 40, "b3WorldDef.frictionCallback has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.frictionCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "restitutionCallback";
                    assert(it.offset_in_bytes == 48, "b3WorldDef.restitutionCallback has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.restitutionCallback has unexpected size % instead of 8", it.type.runtime_size);
                case "enableSleep";
                    assert(it.offset_in_bytes == 56, "b3WorldDef.enableSleep has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3WorldDef.enableSleep has unexpected size % instead of 1", it.type.runtime_size);
                case "enableContinuous";
                    assert(it.offset_in_bytes == 57, "b3WorldDef.enableContinuous has unexpected offset % instead of 57", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3WorldDef.enableContinuous has unexpected size % instead of 1", it.type.runtime_size);
                case "workerCount";
                    assert(it.offset_in_bytes == 60, "b3WorldDef.workerCount has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WorldDef.workerCount has unexpected size % instead of 4", it.type.runtime_size);
                case "enqueueTask";
                    assert(it.offset_in_bytes == 64, "b3WorldDef.enqueueTask has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.enqueueTask has unexpected size % instead of 8", it.type.runtime_size);
                case "finishTask";
                    assert(it.offset_in_bytes == 72, "b3WorldDef.finishTask has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.finishTask has unexpected size % instead of 8", it.type.runtime_size);
                case "userTaskContext";
                    assert(it.offset_in_bytes == 80, "b3WorldDef.userTaskContext has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.userTaskContext has unexpected size % instead of 8", it.type.runtime_size);
                case "userData";
                    assert(it.offset_in_bytes == 88, "b3WorldDef.userData has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.userData has unexpected size % instead of 8", it.type.runtime_size);
                case "createDebugShape";
                    assert(it.offset_in_bytes == 96, "b3WorldDef.createDebugShape has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.createDebugShape has unexpected size % instead of 8", it.type.runtime_size);
                case "destroyDebugShape";
                    assert(it.offset_in_bytes == 104, "b3WorldDef.destroyDebugShape has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.destroyDebugShape has unexpected size % instead of 8", it.type.runtime_size);
                case "userDebugShapeContext";
                    assert(it.offset_in_bytes == 112, "b3WorldDef.userDebugShapeContext has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3WorldDef.userDebugShapeContext has unexpected size % instead of 8", it.type.runtime_size);
                case "capacity";
                    assert(it.offset_in_bytes == 120, "b3WorldDef.capacity has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 20, "b3WorldDef.capacity has unexpected size % instead of 20", it.type.runtime_size);
                case "internalValue";
                    assert(it.offset_in_bytes == 140, "b3WorldDef.internalValue has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WorldDef.internalValue has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3WorldDef) == 144, "b3WorldDef has size % instead of 144", size_of(b3WorldDef));
    }

    {
        info := type_info(b3MotionLocks);
        for info.members {
            if it.name == {
                case "linearX";
                    assert(it.offset_in_bytes == 0, "b3MotionLocks.linearX has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MotionLocks.linearX has unexpected size % instead of 1", it.type.runtime_size);
                case "linearY";
                    assert(it.offset_in_bytes == 1, "b3MotionLocks.linearY has unexpected offset % instead of 1", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MotionLocks.linearY has unexpected size % instead of 1", it.type.runtime_size);
                case "linearZ";
                    assert(it.offset_in_bytes == 2, "b3MotionLocks.linearZ has unexpected offset % instead of 2", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MotionLocks.linearZ has unexpected size % instead of 1", it.type.runtime_size);
                case "angularX";
                    assert(it.offset_in_bytes == 3, "b3MotionLocks.angularX has unexpected offset % instead of 3", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MotionLocks.angularX has unexpected size % instead of 1", it.type.runtime_size);
                case "angularY";
                    assert(it.offset_in_bytes == 4, "b3MotionLocks.angularY has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MotionLocks.angularY has unexpected size % instead of 1", it.type.runtime_size);
                case "angularZ";
                    assert(it.offset_in_bytes == 5, "b3MotionLocks.angularZ has unexpected offset % instead of 5", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MotionLocks.angularZ has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3MotionLocks) == 6, "b3MotionLocks has size % instead of 6", size_of(b3MotionLocks));
    }

    {
        info := type_info(b3BodyDef);
        for info.members {
            if it.name == {
                case "type";
                    assert(it.offset_in_bytes == 0, "b3BodyDef.type has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyDef.type has unexpected size % instead of 4", it.type.runtime_size);
                case "position";
                    assert(it.offset_in_bytes == 4, "b3BodyDef.position has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3BodyDef.position has unexpected size % instead of 12", it.type.runtime_size);
                case "rotation";
                    assert(it.offset_in_bytes == 16, "b3BodyDef.rotation has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3BodyDef.rotation has unexpected size % instead of 16", it.type.runtime_size);
                case "linearVelocity";
                    assert(it.offset_in_bytes == 32, "b3BodyDef.linearVelocity has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3BodyDef.linearVelocity has unexpected size % instead of 12", it.type.runtime_size);
                case "angularVelocity";
                    assert(it.offset_in_bytes == 44, "b3BodyDef.angularVelocity has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3BodyDef.angularVelocity has unexpected size % instead of 12", it.type.runtime_size);
                case "linearDamping";
                    assert(it.offset_in_bytes == 56, "b3BodyDef.linearDamping has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyDef.linearDamping has unexpected size % instead of 4", it.type.runtime_size);
                case "angularDamping";
                    assert(it.offset_in_bytes == 60, "b3BodyDef.angularDamping has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyDef.angularDamping has unexpected size % instead of 4", it.type.runtime_size);
                case "gravityScale";
                    assert(it.offset_in_bytes == 64, "b3BodyDef.gravityScale has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyDef.gravityScale has unexpected size % instead of 4", it.type.runtime_size);
                case "sleepThreshold";
                    assert(it.offset_in_bytes == 68, "b3BodyDef.sleepThreshold has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyDef.sleepThreshold has unexpected size % instead of 4", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 72, "b3BodyDef.name has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BodyDef.name has unexpected size % instead of 8", it.type.runtime_size);
                case "userData";
                    assert(it.offset_in_bytes == 80, "b3BodyDef.userData has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BodyDef.userData has unexpected size % instead of 8", it.type.runtime_size);
                case "motionLocks";
                    assert(it.offset_in_bytes == 88, "b3BodyDef.motionLocks has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 6, "b3BodyDef.motionLocks has unexpected size % instead of 6", it.type.runtime_size);
                case "enableSleep";
                    assert(it.offset_in_bytes == 94, "b3BodyDef.enableSleep has unexpected offset % instead of 94", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3BodyDef.enableSleep has unexpected size % instead of 1", it.type.runtime_size);
                case "isAwake";
                    assert(it.offset_in_bytes == 95, "b3BodyDef.isAwake has unexpected offset % instead of 95", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3BodyDef.isAwake has unexpected size % instead of 1", it.type.runtime_size);
                case "isBullet";
                    assert(it.offset_in_bytes == 96, "b3BodyDef.isBullet has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3BodyDef.isBullet has unexpected size % instead of 1", it.type.runtime_size);
                case "isEnabled";
                    assert(it.offset_in_bytes == 97, "b3BodyDef.isEnabled has unexpected offset % instead of 97", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3BodyDef.isEnabled has unexpected size % instead of 1", it.type.runtime_size);
                case "allowFastRotation";
                    assert(it.offset_in_bytes == 98, "b3BodyDef.allowFastRotation has unexpected offset % instead of 98", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3BodyDef.allowFastRotation has unexpected size % instead of 1", it.type.runtime_size);
                case "enableContactRecycling";
                    assert(it.offset_in_bytes == 99, "b3BodyDef.enableContactRecycling has unexpected offset % instead of 99", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3BodyDef.enableContactRecycling has unexpected size % instead of 1", it.type.runtime_size);
                case "internalValue";
                    assert(it.offset_in_bytes == 100, "b3BodyDef.internalValue has unexpected offset % instead of 100", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyDef.internalValue has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3BodyDef) == 104, "b3BodyDef has size % instead of 104", size_of(b3BodyDef));
    }

    {
        info := type_info(b3Filter);
        for info.members {
            if it.name == {
                case "categoryBits";
                    assert(it.offset_in_bytes == 0, "b3Filter.categoryBits has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3Filter.categoryBits has unexpected size % instead of 8", it.type.runtime_size);
                case "maskBits";
                    assert(it.offset_in_bytes == 8, "b3Filter.maskBits has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3Filter.maskBits has unexpected size % instead of 8", it.type.runtime_size);
                case "groupIndex";
                    assert(it.offset_in_bytes == 16, "b3Filter.groupIndex has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Filter.groupIndex has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Filter) == 24, "b3Filter has size % instead of 24", size_of(b3Filter));
    }

    {
        info := type_info(b3SurfaceMaterial);
        for info.members {
            if it.name == {
                case "friction";
                    assert(it.offset_in_bytes == 0, "b3SurfaceMaterial.friction has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SurfaceMaterial.friction has unexpected size % instead of 4", it.type.runtime_size);
                case "restitution";
                    assert(it.offset_in_bytes == 4, "b3SurfaceMaterial.restitution has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SurfaceMaterial.restitution has unexpected size % instead of 4", it.type.runtime_size);
                case "rollingResistance";
                    assert(it.offset_in_bytes == 8, "b3SurfaceMaterial.rollingResistance has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SurfaceMaterial.rollingResistance has unexpected size % instead of 4", it.type.runtime_size);
                case "tangentVelocity";
                    assert(it.offset_in_bytes == 12, "b3SurfaceMaterial.tangentVelocity has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3SurfaceMaterial.tangentVelocity has unexpected size % instead of 12", it.type.runtime_size);
                case "userMaterialId";
                    assert(it.offset_in_bytes == 24, "b3SurfaceMaterial.userMaterialId has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3SurfaceMaterial.userMaterialId has unexpected size % instead of 8", it.type.runtime_size);
                case "customColor";
                    assert(it.offset_in_bytes == 32, "b3SurfaceMaterial.customColor has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SurfaceMaterial.customColor has unexpected size % instead of 4", it.type.runtime_size);
                case "padding";
                    assert(it.offset_in_bytes == 36, "b3SurfaceMaterial.padding has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SurfaceMaterial.padding has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3SurfaceMaterial) == 40, "b3SurfaceMaterial has size % instead of 40", size_of(b3SurfaceMaterial));
    }

    {
        info := type_info(b3ShapeDef);
        for info.members {
            if it.name == {
                case "name";
                    assert(it.offset_in_bytes == 0, "b3ShapeDef.name has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ShapeDef.name has unexpected size % instead of 8", it.type.runtime_size);
                case "userData";
                    assert(it.offset_in_bytes == 8, "b3ShapeDef.userData has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ShapeDef.userData has unexpected size % instead of 8", it.type.runtime_size);
                case "materials";
                    assert(it.offset_in_bytes == 16, "b3ShapeDef.materials has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ShapeDef.materials has unexpected size % instead of 8", it.type.runtime_size);
                case "materialCount";
                    assert(it.offset_in_bytes == 24, "b3ShapeDef.materialCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeDef.materialCount has unexpected size % instead of 4", it.type.runtime_size);
                case "baseMaterial";
                    assert(it.offset_in_bytes == 32, "b3ShapeDef.baseMaterial has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "b3ShapeDef.baseMaterial has unexpected size % instead of 40", it.type.runtime_size);
                case "density";
                    assert(it.offset_in_bytes == 72, "b3ShapeDef.density has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeDef.density has unexpected size % instead of 4", it.type.runtime_size);
                case "explosionScale";
                    assert(it.offset_in_bytes == 76, "b3ShapeDef.explosionScale has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeDef.explosionScale has unexpected size % instead of 4", it.type.runtime_size);
                case "filter";
                    assert(it.offset_in_bytes == 80, "b3ShapeDef.filter has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3ShapeDef.filter has unexpected size % instead of 24", it.type.runtime_size);
                case "enableCustomFiltering";
                    assert(it.offset_in_bytes == 104, "b3ShapeDef.enableCustomFiltering has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.enableCustomFiltering has unexpected size % instead of 1", it.type.runtime_size);
                case "isSensor";
                    assert(it.offset_in_bytes == 105, "b3ShapeDef.isSensor has unexpected offset % instead of 105", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.isSensor has unexpected size % instead of 1", it.type.runtime_size);
                case "enableSensorEvents";
                    assert(it.offset_in_bytes == 106, "b3ShapeDef.enableSensorEvents has unexpected offset % instead of 106", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.enableSensorEvents has unexpected size % instead of 1", it.type.runtime_size);
                case "enableContactEvents";
                    assert(it.offset_in_bytes == 107, "b3ShapeDef.enableContactEvents has unexpected offset % instead of 107", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.enableContactEvents has unexpected size % instead of 1", it.type.runtime_size);
                case "enableHitEvents";
                    assert(it.offset_in_bytes == 108, "b3ShapeDef.enableHitEvents has unexpected offset % instead of 108", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.enableHitEvents has unexpected size % instead of 1", it.type.runtime_size);
                case "enablePreSolveEvents";
                    assert(it.offset_in_bytes == 109, "b3ShapeDef.enablePreSolveEvents has unexpected offset % instead of 109", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.enablePreSolveEvents has unexpected size % instead of 1", it.type.runtime_size);
                case "invokeContactCreation";
                    assert(it.offset_in_bytes == 110, "b3ShapeDef.invokeContactCreation has unexpected offset % instead of 110", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.invokeContactCreation has unexpected size % instead of 1", it.type.runtime_size);
                case "updateBodyMass";
                    assert(it.offset_in_bytes == 111, "b3ShapeDef.updateBodyMass has unexpected offset % instead of 111", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.updateBodyMass has unexpected size % instead of 1", it.type.runtime_size);
                case "enableSpeculativeContact";
                    assert(it.offset_in_bytes == 112, "b3ShapeDef.enableSpeculativeContact has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeDef.enableSpeculativeContact has unexpected size % instead of 1", it.type.runtime_size);
                case "internalValue";
                    assert(it.offset_in_bytes == 116, "b3ShapeDef.internalValue has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeDef.internalValue has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3ShapeDef) == 120, "b3ShapeDef has size % instead of 120", size_of(b3ShapeDef));
    }

    {
        info := type_info(b3Profile);
        for info.members {
            if it.name == {
                case "step";
                    assert(it.offset_in_bytes == 0, "b3Profile.step has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.step has unexpected size % instead of 4", it.type.runtime_size);
                case "pairs";
                    assert(it.offset_in_bytes == 4, "b3Profile.pairs has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.pairs has unexpected size % instead of 4", it.type.runtime_size);
                case "collide";
                    assert(it.offset_in_bytes == 8, "b3Profile.collide has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.collide has unexpected size % instead of 4", it.type.runtime_size);
                case "solve";
                    assert(it.offset_in_bytes == 12, "b3Profile.solve has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.solve has unexpected size % instead of 4", it.type.runtime_size);
                case "solverSetup";
                    assert(it.offset_in_bytes == 16, "b3Profile.solverSetup has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.solverSetup has unexpected size % instead of 4", it.type.runtime_size);
                case "constraints";
                    assert(it.offset_in_bytes == 20, "b3Profile.constraints has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.constraints has unexpected size % instead of 4", it.type.runtime_size);
                case "prepareConstraints";
                    assert(it.offset_in_bytes == 24, "b3Profile.prepareConstraints has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.prepareConstraints has unexpected size % instead of 4", it.type.runtime_size);
                case "integrateVelocities";
                    assert(it.offset_in_bytes == 28, "b3Profile.integrateVelocities has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.integrateVelocities has unexpected size % instead of 4", it.type.runtime_size);
                case "warmStart";
                    assert(it.offset_in_bytes == 32, "b3Profile.warmStart has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.warmStart has unexpected size % instead of 4", it.type.runtime_size);
                case "solveImpulses";
                    assert(it.offset_in_bytes == 36, "b3Profile.solveImpulses has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.solveImpulses has unexpected size % instead of 4", it.type.runtime_size);
                case "integratePositions";
                    assert(it.offset_in_bytes == 40, "b3Profile.integratePositions has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.integratePositions has unexpected size % instead of 4", it.type.runtime_size);
                case "relaxImpulses";
                    assert(it.offset_in_bytes == 44, "b3Profile.relaxImpulses has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.relaxImpulses has unexpected size % instead of 4", it.type.runtime_size);
                case "applyRestitution";
                    assert(it.offset_in_bytes == 48, "b3Profile.applyRestitution has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.applyRestitution has unexpected size % instead of 4", it.type.runtime_size);
                case "storeImpulses";
                    assert(it.offset_in_bytes == 52, "b3Profile.storeImpulses has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.storeImpulses has unexpected size % instead of 4", it.type.runtime_size);
                case "splitIslands";
                    assert(it.offset_in_bytes == 56, "b3Profile.splitIslands has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.splitIslands has unexpected size % instead of 4", it.type.runtime_size);
                case "transforms";
                    assert(it.offset_in_bytes == 60, "b3Profile.transforms has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.transforms has unexpected size % instead of 4", it.type.runtime_size);
                case "sensorHits";
                    assert(it.offset_in_bytes == 64, "b3Profile.sensorHits has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.sensorHits has unexpected size % instead of 4", it.type.runtime_size);
                case "jointEvents";
                    assert(it.offset_in_bytes == 68, "b3Profile.jointEvents has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.jointEvents has unexpected size % instead of 4", it.type.runtime_size);
                case "hitEvents";
                    assert(it.offset_in_bytes == 72, "b3Profile.hitEvents has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.hitEvents has unexpected size % instead of 4", it.type.runtime_size);
                case "refit";
                    assert(it.offset_in_bytes == 76, "b3Profile.refit has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.refit has unexpected size % instead of 4", it.type.runtime_size);
                case "bullets";
                    assert(it.offset_in_bytes == 80, "b3Profile.bullets has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.bullets has unexpected size % instead of 4", it.type.runtime_size);
                case "sleepIslands";
                    assert(it.offset_in_bytes == 84, "b3Profile.sleepIslands has unexpected offset % instead of 84", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.sleepIslands has unexpected size % instead of 4", it.type.runtime_size);
                case "sensors";
                    assert(it.offset_in_bytes == 88, "b3Profile.sensors has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Profile.sensors has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Profile) == 92, "b3Profile has size % instead of 92", size_of(b3Profile));
    }

    {
        info := type_info(b3Counters);
        for info.members {
            if it.name == {
                case "bodyCount";
                    assert(it.offset_in_bytes == 0, "b3Counters.bodyCount has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.bodyCount has unexpected size % instead of 4", it.type.runtime_size);
                case "shapeCount";
                    assert(it.offset_in_bytes == 4, "b3Counters.shapeCount has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.shapeCount has unexpected size % instead of 4", it.type.runtime_size);
                case "contactCount";
                    assert(it.offset_in_bytes == 8, "b3Counters.contactCount has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.contactCount has unexpected size % instead of 4", it.type.runtime_size);
                case "jointCount";
                    assert(it.offset_in_bytes == 12, "b3Counters.jointCount has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.jointCount has unexpected size % instead of 4", it.type.runtime_size);
                case "islandCount";
                    assert(it.offset_in_bytes == 16, "b3Counters.islandCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.islandCount has unexpected size % instead of 4", it.type.runtime_size);
                case "stackUsed";
                    assert(it.offset_in_bytes == 20, "b3Counters.stackUsed has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.stackUsed has unexpected size % instead of 4", it.type.runtime_size);
                case "arenaCapacity";
                    assert(it.offset_in_bytes == 24, "b3Counters.arenaCapacity has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.arenaCapacity has unexpected size % instead of 4", it.type.runtime_size);
                case "staticTreeHeight";
                    assert(it.offset_in_bytes == 28, "b3Counters.staticTreeHeight has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.staticTreeHeight has unexpected size % instead of 4", it.type.runtime_size);
                case "treeHeight";
                    assert(it.offset_in_bytes == 32, "b3Counters.treeHeight has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.treeHeight has unexpected size % instead of 4", it.type.runtime_size);
                case "satCallCount";
                    assert(it.offset_in_bytes == 36, "b3Counters.satCallCount has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.satCallCount has unexpected size % instead of 4", it.type.runtime_size);
                case "satCacheHitCount";
                    assert(it.offset_in_bytes == 40, "b3Counters.satCacheHitCount has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.satCacheHitCount has unexpected size % instead of 4", it.type.runtime_size);
                case "byteCount";
                    assert(it.offset_in_bytes == 44, "b3Counters.byteCount has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.byteCount has unexpected size % instead of 4", it.type.runtime_size);
                case "taskCount";
                    assert(it.offset_in_bytes == 48, "b3Counters.taskCount has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.taskCount has unexpected size % instead of 4", it.type.runtime_size);
                case "colorCounts";
                    assert(it.offset_in_bytes == 52, "b3Counters.colorCounts has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "b3Counters.colorCounts has unexpected size % instead of 96", it.type.runtime_size);
                case "manifoldCounts";
                    assert(it.offset_in_bytes == 148, "b3Counters.manifoldCounts has unexpected offset % instead of 148", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "b3Counters.manifoldCounts has unexpected size % instead of 32", it.type.runtime_size);
                case "awakeContactCount";
                    assert(it.offset_in_bytes == 180, "b3Counters.awakeContactCount has unexpected offset % instead of 180", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.awakeContactCount has unexpected size % instead of 4", it.type.runtime_size);
                case "recycledContactCount";
                    assert(it.offset_in_bytes == 184, "b3Counters.recycledContactCount has unexpected offset % instead of 184", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.recycledContactCount has unexpected size % instead of 4", it.type.runtime_size);
                case "distanceIterations";
                    assert(it.offset_in_bytes == 188, "b3Counters.distanceIterations has unexpected offset % instead of 188", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.distanceIterations has unexpected size % instead of 4", it.type.runtime_size);
                case "pushBackIterations";
                    assert(it.offset_in_bytes == 192, "b3Counters.pushBackIterations has unexpected offset % instead of 192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.pushBackIterations has unexpected size % instead of 4", it.type.runtime_size);
                case "rootIterations";
                    assert(it.offset_in_bytes == 196, "b3Counters.rootIterations has unexpected offset % instead of 196", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Counters.rootIterations has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Counters) == 200, "b3Counters has size % instead of 200", size_of(b3Counters));
    }

    {
        info := type_info(b3JointDef);
        for info.members {
            if it.name == {
                case "userData";
                    assert(it.offset_in_bytes == 0, "b3JointDef.userData has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3JointDef.userData has unexpected size % instead of 8", it.type.runtime_size);
                case "bodyIdA";
                    assert(it.offset_in_bytes == 8, "b3JointDef.bodyIdA has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3JointDef.bodyIdA has unexpected size % instead of 8", it.type.runtime_size);
                case "bodyIdB";
                    assert(it.offset_in_bytes == 16, "b3JointDef.bodyIdB has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3JointDef.bodyIdB has unexpected size % instead of 8", it.type.runtime_size);
                case "localFrameA";
                    assert(it.offset_in_bytes == 24, "b3JointDef.localFrameA has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3JointDef.localFrameA has unexpected size % instead of 28", it.type.runtime_size);
                case "localFrameB";
                    assert(it.offset_in_bytes == 52, "b3JointDef.localFrameB has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3JointDef.localFrameB has unexpected size % instead of 28", it.type.runtime_size);
                case "forceThreshold";
                    assert(it.offset_in_bytes == 80, "b3JointDef.forceThreshold has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3JointDef.forceThreshold has unexpected size % instead of 4", it.type.runtime_size);
                case "torqueThreshold";
                    assert(it.offset_in_bytes == 84, "b3JointDef.torqueThreshold has unexpected offset % instead of 84", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3JointDef.torqueThreshold has unexpected size % instead of 4", it.type.runtime_size);
                case "constraintHertz";
                    assert(it.offset_in_bytes == 88, "b3JointDef.constraintHertz has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3JointDef.constraintHertz has unexpected size % instead of 4", it.type.runtime_size);
                case "constraintDampingRatio";
                    assert(it.offset_in_bytes == 92, "b3JointDef.constraintDampingRatio has unexpected offset % instead of 92", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3JointDef.constraintDampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "drawScale";
                    assert(it.offset_in_bytes == 96, "b3JointDef.drawScale has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3JointDef.drawScale has unexpected size % instead of 4", it.type.runtime_size);
                case "collideConnected";
                    assert(it.offset_in_bytes == 100, "b3JointDef.collideConnected has unexpected offset % instead of 100", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3JointDef.collideConnected has unexpected size % instead of 1", it.type.runtime_size);
                case "internalValue";
                    assert(it.offset_in_bytes == 104, "b3JointDef.internalValue has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3JointDef.internalValue has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3JointDef) == 112, "b3JointDef has size % instead of 112", size_of(b3JointDef));
    }

    {
        info := type_info(b3DistanceJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3DistanceJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3DistanceJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
                case "length";
                    assert(it.offset_in_bytes == 112, "b3DistanceJointDef.length has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.length has unexpected size % instead of 4", it.type.runtime_size);
                case "enableSpring";
                    assert(it.offset_in_bytes == 116, "b3DistanceJointDef.enableSpring has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DistanceJointDef.enableSpring has unexpected size % instead of 1", it.type.runtime_size);
                case "lowerSpringForce";
                    assert(it.offset_in_bytes == 120, "b3DistanceJointDef.lowerSpringForce has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.lowerSpringForce has unexpected size % instead of 4", it.type.runtime_size);
                case "upperSpringForce";
                    assert(it.offset_in_bytes == 124, "b3DistanceJointDef.upperSpringForce has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.upperSpringForce has unexpected size % instead of 4", it.type.runtime_size);
                case "hertz";
                    assert(it.offset_in_bytes == 128, "b3DistanceJointDef.hertz has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.hertz has unexpected size % instead of 4", it.type.runtime_size);
                case "dampingRatio";
                    assert(it.offset_in_bytes == 132, "b3DistanceJointDef.dampingRatio has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.dampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "enableLimit";
                    assert(it.offset_in_bytes == 136, "b3DistanceJointDef.enableLimit has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DistanceJointDef.enableLimit has unexpected size % instead of 1", it.type.runtime_size);
                case "minLength";
                    assert(it.offset_in_bytes == 140, "b3DistanceJointDef.minLength has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.minLength has unexpected size % instead of 4", it.type.runtime_size);
                case "maxLength";
                    assert(it.offset_in_bytes == 144, "b3DistanceJointDef.maxLength has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.maxLength has unexpected size % instead of 4", it.type.runtime_size);
                case "enableMotor";
                    assert(it.offset_in_bytes == 148, "b3DistanceJointDef.enableMotor has unexpected offset % instead of 148", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DistanceJointDef.enableMotor has unexpected size % instead of 1", it.type.runtime_size);
                case "maxMotorForce";
                    assert(it.offset_in_bytes == 152, "b3DistanceJointDef.maxMotorForce has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.maxMotorForce has unexpected size % instead of 4", it.type.runtime_size);
                case "motorSpeed";
                    assert(it.offset_in_bytes == 156, "b3DistanceJointDef.motorSpeed has unexpected offset % instead of 156", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceJointDef.motorSpeed has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3DistanceJointDef) == 160, "b3DistanceJointDef has size % instead of 160", size_of(b3DistanceJointDef));
    }

    {
        info := type_info(b3MotorJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3MotorJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3MotorJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
                case "linearVelocity";
                    assert(it.offset_in_bytes == 112, "b3MotorJointDef.linearVelocity has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3MotorJointDef.linearVelocity has unexpected size % instead of 12", it.type.runtime_size);
                case "maxVelocityForce";
                    assert(it.offset_in_bytes == 124, "b3MotorJointDef.maxVelocityForce has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MotorJointDef.maxVelocityForce has unexpected size % instead of 4", it.type.runtime_size);
                case "angularVelocity";
                    assert(it.offset_in_bytes == 128, "b3MotorJointDef.angularVelocity has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3MotorJointDef.angularVelocity has unexpected size % instead of 12", it.type.runtime_size);
                case "maxVelocityTorque";
                    assert(it.offset_in_bytes == 140, "b3MotorJointDef.maxVelocityTorque has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MotorJointDef.maxVelocityTorque has unexpected size % instead of 4", it.type.runtime_size);
                case "linearHertz";
                    assert(it.offset_in_bytes == 144, "b3MotorJointDef.linearHertz has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MotorJointDef.linearHertz has unexpected size % instead of 4", it.type.runtime_size);
                case "linearDampingRatio";
                    assert(it.offset_in_bytes == 148, "b3MotorJointDef.linearDampingRatio has unexpected offset % instead of 148", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MotorJointDef.linearDampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "maxSpringForce";
                    assert(it.offset_in_bytes == 152, "b3MotorJointDef.maxSpringForce has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MotorJointDef.maxSpringForce has unexpected size % instead of 4", it.type.runtime_size);
                case "angularHertz";
                    assert(it.offset_in_bytes == 156, "b3MotorJointDef.angularHertz has unexpected offset % instead of 156", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MotorJointDef.angularHertz has unexpected size % instead of 4", it.type.runtime_size);
                case "angularDampingRatio";
                    assert(it.offset_in_bytes == 160, "b3MotorJointDef.angularDampingRatio has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MotorJointDef.angularDampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "maxSpringTorque";
                    assert(it.offset_in_bytes == 164, "b3MotorJointDef.maxSpringTorque has unexpected offset % instead of 164", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MotorJointDef.maxSpringTorque has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3MotorJointDef) == 168, "b3MotorJointDef has size % instead of 168", size_of(b3MotorJointDef));
    }

    {
        info := type_info(b3FilterJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3FilterJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3FilterJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
            }
        }
        assert(size_of(b3FilterJointDef) == 112, "b3FilterJointDef has size % instead of 112", size_of(b3FilterJointDef));
    }

    {
        info := type_info(b3ParallelJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3ParallelJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3ParallelJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
                case "hertz";
                    assert(it.offset_in_bytes == 112, "b3ParallelJointDef.hertz has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ParallelJointDef.hertz has unexpected size % instead of 4", it.type.runtime_size);
                case "dampingRatio";
                    assert(it.offset_in_bytes == 116, "b3ParallelJointDef.dampingRatio has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ParallelJointDef.dampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "maxTorque";
                    assert(it.offset_in_bytes == 120, "b3ParallelJointDef.maxTorque has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ParallelJointDef.maxTorque has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3ParallelJointDef) == 128, "b3ParallelJointDef has size % instead of 128", size_of(b3ParallelJointDef));
    }

    {
        info := type_info(b3PrismaticJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3PrismaticJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3PrismaticJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
                case "enableSpring";
                    assert(it.offset_in_bytes == 112, "b3PrismaticJointDef.enableSpring has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3PrismaticJointDef.enableSpring has unexpected size % instead of 1", it.type.runtime_size);
                case "hertz";
                    assert(it.offset_in_bytes == 116, "b3PrismaticJointDef.hertz has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PrismaticJointDef.hertz has unexpected size % instead of 4", it.type.runtime_size);
                case "dampingRatio";
                    assert(it.offset_in_bytes == 120, "b3PrismaticJointDef.dampingRatio has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PrismaticJointDef.dampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "targetTranslation";
                    assert(it.offset_in_bytes == 124, "b3PrismaticJointDef.targetTranslation has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PrismaticJointDef.targetTranslation has unexpected size % instead of 4", it.type.runtime_size);
                case "enableLimit";
                    assert(it.offset_in_bytes == 128, "b3PrismaticJointDef.enableLimit has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3PrismaticJointDef.enableLimit has unexpected size % instead of 1", it.type.runtime_size);
                case "lowerTranslation";
                    assert(it.offset_in_bytes == 132, "b3PrismaticJointDef.lowerTranslation has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PrismaticJointDef.lowerTranslation has unexpected size % instead of 4", it.type.runtime_size);
                case "upperTranslation";
                    assert(it.offset_in_bytes == 136, "b3PrismaticJointDef.upperTranslation has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PrismaticJointDef.upperTranslation has unexpected size % instead of 4", it.type.runtime_size);
                case "enableMotor";
                    assert(it.offset_in_bytes == 140, "b3PrismaticJointDef.enableMotor has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3PrismaticJointDef.enableMotor has unexpected size % instead of 1", it.type.runtime_size);
                case "maxMotorForce";
                    assert(it.offset_in_bytes == 144, "b3PrismaticJointDef.maxMotorForce has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PrismaticJointDef.maxMotorForce has unexpected size % instead of 4", it.type.runtime_size);
                case "motorSpeed";
                    assert(it.offset_in_bytes == 148, "b3PrismaticJointDef.motorSpeed has unexpected offset % instead of 148", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PrismaticJointDef.motorSpeed has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3PrismaticJointDef) == 152, "b3PrismaticJointDef has size % instead of 152", size_of(b3PrismaticJointDef));
    }

    {
        info := type_info(b3RevoluteJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3RevoluteJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3RevoluteJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
                case "targetAngle";
                    assert(it.offset_in_bytes == 112, "b3RevoluteJointDef.targetAngle has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RevoluteJointDef.targetAngle has unexpected size % instead of 4", it.type.runtime_size);
                case "enableSpring";
                    assert(it.offset_in_bytes == 116, "b3RevoluteJointDef.enableSpring has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3RevoluteJointDef.enableSpring has unexpected size % instead of 1", it.type.runtime_size);
                case "hertz";
                    assert(it.offset_in_bytes == 120, "b3RevoluteJointDef.hertz has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RevoluteJointDef.hertz has unexpected size % instead of 4", it.type.runtime_size);
                case "dampingRatio";
                    assert(it.offset_in_bytes == 124, "b3RevoluteJointDef.dampingRatio has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RevoluteJointDef.dampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "enableLimit";
                    assert(it.offset_in_bytes == 128, "b3RevoluteJointDef.enableLimit has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3RevoluteJointDef.enableLimit has unexpected size % instead of 1", it.type.runtime_size);
                case "lowerAngle";
                    assert(it.offset_in_bytes == 132, "b3RevoluteJointDef.lowerAngle has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RevoluteJointDef.lowerAngle has unexpected size % instead of 4", it.type.runtime_size);
                case "upperAngle";
                    assert(it.offset_in_bytes == 136, "b3RevoluteJointDef.upperAngle has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RevoluteJointDef.upperAngle has unexpected size % instead of 4", it.type.runtime_size);
                case "enableMotor";
                    assert(it.offset_in_bytes == 140, "b3RevoluteJointDef.enableMotor has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3RevoluteJointDef.enableMotor has unexpected size % instead of 1", it.type.runtime_size);
                case "maxMotorTorque";
                    assert(it.offset_in_bytes == 144, "b3RevoluteJointDef.maxMotorTorque has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RevoluteJointDef.maxMotorTorque has unexpected size % instead of 4", it.type.runtime_size);
                case "motorSpeed";
                    assert(it.offset_in_bytes == 148, "b3RevoluteJointDef.motorSpeed has unexpected offset % instead of 148", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RevoluteJointDef.motorSpeed has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3RevoluteJointDef) == 152, "b3RevoluteJointDef has size % instead of 152", size_of(b3RevoluteJointDef));
    }

    {
        info := type_info(b3SphericalJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3SphericalJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3SphericalJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
                case "enableSpring";
                    assert(it.offset_in_bytes == 112, "b3SphericalJointDef.enableSpring has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3SphericalJointDef.enableSpring has unexpected size % instead of 1", it.type.runtime_size);
                case "hertz";
                    assert(it.offset_in_bytes == 116, "b3SphericalJointDef.hertz has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SphericalJointDef.hertz has unexpected size % instead of 4", it.type.runtime_size);
                case "dampingRatio";
                    assert(it.offset_in_bytes == 120, "b3SphericalJointDef.dampingRatio has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SphericalJointDef.dampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "targetRotation";
                    assert(it.offset_in_bytes == 124, "b3SphericalJointDef.targetRotation has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3SphericalJointDef.targetRotation has unexpected size % instead of 16", it.type.runtime_size);
                case "enableConeLimit";
                    assert(it.offset_in_bytes == 140, "b3SphericalJointDef.enableConeLimit has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3SphericalJointDef.enableConeLimit has unexpected size % instead of 1", it.type.runtime_size);
                case "coneAngle";
                    assert(it.offset_in_bytes == 144, "b3SphericalJointDef.coneAngle has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SphericalJointDef.coneAngle has unexpected size % instead of 4", it.type.runtime_size);
                case "enableTwistLimit";
                    assert(it.offset_in_bytes == 148, "b3SphericalJointDef.enableTwistLimit has unexpected offset % instead of 148", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3SphericalJointDef.enableTwistLimit has unexpected size % instead of 1", it.type.runtime_size);
                case "lowerTwistAngle";
                    assert(it.offset_in_bytes == 152, "b3SphericalJointDef.lowerTwistAngle has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SphericalJointDef.lowerTwistAngle has unexpected size % instead of 4", it.type.runtime_size);
                case "upperTwistAngle";
                    assert(it.offset_in_bytes == 156, "b3SphericalJointDef.upperTwistAngle has unexpected offset % instead of 156", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SphericalJointDef.upperTwistAngle has unexpected size % instead of 4", it.type.runtime_size);
                case "enableMotor";
                    assert(it.offset_in_bytes == 160, "b3SphericalJointDef.enableMotor has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3SphericalJointDef.enableMotor has unexpected size % instead of 1", it.type.runtime_size);
                case "maxMotorTorque";
                    assert(it.offset_in_bytes == 164, "b3SphericalJointDef.maxMotorTorque has unexpected offset % instead of 164", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SphericalJointDef.maxMotorTorque has unexpected size % instead of 4", it.type.runtime_size);
                case "motorVelocity";
                    assert(it.offset_in_bytes == 168, "b3SphericalJointDef.motorVelocity has unexpected offset % instead of 168", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3SphericalJointDef.motorVelocity has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(b3SphericalJointDef) == 184, "b3SphericalJointDef has size % instead of 184", size_of(b3SphericalJointDef));
    }

    {
        info := type_info(b3WeldJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3WeldJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3WeldJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
                case "linearHertz";
                    assert(it.offset_in_bytes == 112, "b3WeldJointDef.linearHertz has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WeldJointDef.linearHertz has unexpected size % instead of 4", it.type.runtime_size);
                case "angularHertz";
                    assert(it.offset_in_bytes == 116, "b3WeldJointDef.angularHertz has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WeldJointDef.angularHertz has unexpected size % instead of 4", it.type.runtime_size);
                case "linearDampingRatio";
                    assert(it.offset_in_bytes == 120, "b3WeldJointDef.linearDampingRatio has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WeldJointDef.linearDampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "angularDampingRatio";
                    assert(it.offset_in_bytes == 124, "b3WeldJointDef.angularDampingRatio has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WeldJointDef.angularDampingRatio has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3WeldJointDef) == 128, "b3WeldJointDef has size % instead of 128", size_of(b3WeldJointDef));
    }

    {
        info := type_info(b3WheelJointDef);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3WheelJointDef.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 112, "b3WheelJointDef.base has unexpected size % instead of 112", it.type.runtime_size);
                case "enableSuspensionSpring";
                    assert(it.offset_in_bytes == 112, "b3WheelJointDef.enableSuspensionSpring has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3WheelJointDef.enableSuspensionSpring has unexpected size % instead of 1", it.type.runtime_size);
                case "suspensionHertz";
                    assert(it.offset_in_bytes == 116, "b3WheelJointDef.suspensionHertz has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.suspensionHertz has unexpected size % instead of 4", it.type.runtime_size);
                case "suspensionDampingRatio";
                    assert(it.offset_in_bytes == 120, "b3WheelJointDef.suspensionDampingRatio has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.suspensionDampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "enableSuspensionLimit";
                    assert(it.offset_in_bytes == 124, "b3WheelJointDef.enableSuspensionLimit has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3WheelJointDef.enableSuspensionLimit has unexpected size % instead of 1", it.type.runtime_size);
                case "lowerSuspensionLimit";
                    assert(it.offset_in_bytes == 128, "b3WheelJointDef.lowerSuspensionLimit has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.lowerSuspensionLimit has unexpected size % instead of 4", it.type.runtime_size);
                case "upperSuspensionLimit";
                    assert(it.offset_in_bytes == 132, "b3WheelJointDef.upperSuspensionLimit has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.upperSuspensionLimit has unexpected size % instead of 4", it.type.runtime_size);
                case "enableSpinMotor";
                    assert(it.offset_in_bytes == 136, "b3WheelJointDef.enableSpinMotor has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3WheelJointDef.enableSpinMotor has unexpected size % instead of 1", it.type.runtime_size);
                case "maxSpinTorque";
                    assert(it.offset_in_bytes == 140, "b3WheelJointDef.maxSpinTorque has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.maxSpinTorque has unexpected size % instead of 4", it.type.runtime_size);
                case "spinSpeed";
                    assert(it.offset_in_bytes == 144, "b3WheelJointDef.spinSpeed has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.spinSpeed has unexpected size % instead of 4", it.type.runtime_size);
                case "enableSteering";
                    assert(it.offset_in_bytes == 148, "b3WheelJointDef.enableSteering has unexpected offset % instead of 148", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3WheelJointDef.enableSteering has unexpected size % instead of 1", it.type.runtime_size);
                case "steeringHertz";
                    assert(it.offset_in_bytes == 152, "b3WheelJointDef.steeringHertz has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.steeringHertz has unexpected size % instead of 4", it.type.runtime_size);
                case "steeringDampingRatio";
                    assert(it.offset_in_bytes == 156, "b3WheelJointDef.steeringDampingRatio has unexpected offset % instead of 156", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.steeringDampingRatio has unexpected size % instead of 4", it.type.runtime_size);
                case "targetSteeringAngle";
                    assert(it.offset_in_bytes == 160, "b3WheelJointDef.targetSteeringAngle has unexpected offset % instead of 160", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.targetSteeringAngle has unexpected size % instead of 4", it.type.runtime_size);
                case "maxSteeringTorque";
                    assert(it.offset_in_bytes == 164, "b3WheelJointDef.maxSteeringTorque has unexpected offset % instead of 164", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.maxSteeringTorque has unexpected size % instead of 4", it.type.runtime_size);
                case "enableSteeringLimit";
                    assert(it.offset_in_bytes == 168, "b3WheelJointDef.enableSteeringLimit has unexpected offset % instead of 168", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3WheelJointDef.enableSteeringLimit has unexpected size % instead of 1", it.type.runtime_size);
                case "lowerSteeringLimit";
                    assert(it.offset_in_bytes == 172, "b3WheelJointDef.lowerSteeringLimit has unexpected offset % instead of 172", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.lowerSteeringLimit has unexpected size % instead of 4", it.type.runtime_size);
                case "upperSteeringLimit";
                    assert(it.offset_in_bytes == 176, "b3WheelJointDef.upperSteeringLimit has unexpected offset % instead of 176", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3WheelJointDef.upperSteeringLimit has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3WheelJointDef) == 184, "b3WheelJointDef has size % instead of 184", size_of(b3WheelJointDef));
    }

    {
        info := type_info(b3ExplosionDef);
        for info.members {
            if it.name == {
                case "maskBits";
                    assert(it.offset_in_bytes == 0, "b3ExplosionDef.maskBits has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ExplosionDef.maskBits has unexpected size % instead of 8", it.type.runtime_size);
                case "position";
                    assert(it.offset_in_bytes == 8, "b3ExplosionDef.position has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ExplosionDef.position has unexpected size % instead of 12", it.type.runtime_size);
                case "radius";
                    assert(it.offset_in_bytes == 20, "b3ExplosionDef.radius has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ExplosionDef.radius has unexpected size % instead of 4", it.type.runtime_size);
                case "falloff";
                    assert(it.offset_in_bytes == 24, "b3ExplosionDef.falloff has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ExplosionDef.falloff has unexpected size % instead of 4", it.type.runtime_size);
                case "impulsePerArea";
                    assert(it.offset_in_bytes == 28, "b3ExplosionDef.impulsePerArea has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ExplosionDef.impulsePerArea has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3ExplosionDef) == 32, "b3ExplosionDef has size % instead of 32", size_of(b3ExplosionDef));
    }

    {
        info := type_info(b3SensorBeginTouchEvent);
        for info.members {
            if it.name == {
                case "sensorShapeId";
                    assert(it.offset_in_bytes == 0, "b3SensorBeginTouchEvent.sensorShapeId has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3SensorBeginTouchEvent.sensorShapeId has unexpected size % instead of 8", it.type.runtime_size);
                case "visitorShapeId";
                    assert(it.offset_in_bytes == 8, "b3SensorBeginTouchEvent.visitorShapeId has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3SensorBeginTouchEvent.visitorShapeId has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(b3SensorBeginTouchEvent) == 16, "b3SensorBeginTouchEvent has size % instead of 16", size_of(b3SensorBeginTouchEvent));
    }

    {
        info := type_info(b3SensorEndTouchEvent);
        for info.members {
            if it.name == {
                case "sensorShapeId";
                    assert(it.offset_in_bytes == 0, "b3SensorEndTouchEvent.sensorShapeId has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3SensorEndTouchEvent.sensorShapeId has unexpected size % instead of 8", it.type.runtime_size);
                case "visitorShapeId";
                    assert(it.offset_in_bytes == 8, "b3SensorEndTouchEvent.visitorShapeId has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3SensorEndTouchEvent.visitorShapeId has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(b3SensorEndTouchEvent) == 16, "b3SensorEndTouchEvent has size % instead of 16", size_of(b3SensorEndTouchEvent));
    }

    {
        info := type_info(b3SensorEvents);
        for info.members {
            if it.name == {
                case "beginEvents";
                    assert(it.offset_in_bytes == 0, "b3SensorEvents.beginEvents has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3SensorEvents.beginEvents has unexpected size % instead of 8", it.type.runtime_size);
                case "endEvents";
                    assert(it.offset_in_bytes == 8, "b3SensorEvents.endEvents has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3SensorEvents.endEvents has unexpected size % instead of 8", it.type.runtime_size);
                case "beginCount";
                    assert(it.offset_in_bytes == 16, "b3SensorEvents.beginCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SensorEvents.beginCount has unexpected size % instead of 4", it.type.runtime_size);
                case "endCount";
                    assert(it.offset_in_bytes == 20, "b3SensorEvents.endCount has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SensorEvents.endCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3SensorEvents) == 24, "b3SensorEvents has size % instead of 24", size_of(b3SensorEvents));
    }

    {
        info := type_info(b3ContactBeginTouchEvent);
        for info.members {
            if it.name == {
                case "shapeIdA";
                    assert(it.offset_in_bytes == 0, "b3ContactBeginTouchEvent.shapeIdA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactBeginTouchEvent.shapeIdA has unexpected size % instead of 8", it.type.runtime_size);
                case "shapeIdB";
                    assert(it.offset_in_bytes == 8, "b3ContactBeginTouchEvent.shapeIdB has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactBeginTouchEvent.shapeIdB has unexpected size % instead of 8", it.type.runtime_size);
                case "contactId";
                    assert(it.offset_in_bytes == 16, "b3ContactBeginTouchEvent.contactId has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ContactBeginTouchEvent.contactId has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(b3ContactBeginTouchEvent) == 28, "b3ContactBeginTouchEvent has size % instead of 28", size_of(b3ContactBeginTouchEvent));
    }

    {
        info := type_info(b3ContactEndTouchEvent);
        for info.members {
            if it.name == {
                case "shapeIdA";
                    assert(it.offset_in_bytes == 0, "b3ContactEndTouchEvent.shapeIdA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactEndTouchEvent.shapeIdA has unexpected size % instead of 8", it.type.runtime_size);
                case "shapeIdB";
                    assert(it.offset_in_bytes == 8, "b3ContactEndTouchEvent.shapeIdB has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactEndTouchEvent.shapeIdB has unexpected size % instead of 8", it.type.runtime_size);
                case "contactId";
                    assert(it.offset_in_bytes == 16, "b3ContactEndTouchEvent.contactId has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ContactEndTouchEvent.contactId has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(b3ContactEndTouchEvent) == 28, "b3ContactEndTouchEvent has size % instead of 28", size_of(b3ContactEndTouchEvent));
    }

    {
        info := type_info(b3ContactHitEvent);
        for info.members {
            if it.name == {
                case "shapeIdA";
                    assert(it.offset_in_bytes == 0, "b3ContactHitEvent.shapeIdA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactHitEvent.shapeIdA has unexpected size % instead of 8", it.type.runtime_size);
                case "shapeIdB";
                    assert(it.offset_in_bytes == 8, "b3ContactHitEvent.shapeIdB has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactHitEvent.shapeIdB has unexpected size % instead of 8", it.type.runtime_size);
                case "contactId";
                    assert(it.offset_in_bytes == 16, "b3ContactHitEvent.contactId has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ContactHitEvent.contactId has unexpected size % instead of 12", it.type.runtime_size);
                case "point";
                    assert(it.offset_in_bytes == 28, "b3ContactHitEvent.point has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ContactHitEvent.point has unexpected size % instead of 12", it.type.runtime_size);
                case "normal";
                    assert(it.offset_in_bytes == 40, "b3ContactHitEvent.normal has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ContactHitEvent.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "approachSpeed";
                    assert(it.offset_in_bytes == 52, "b3ContactHitEvent.approachSpeed has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ContactHitEvent.approachSpeed has unexpected size % instead of 4", it.type.runtime_size);
                case "userMaterialIdA";
                    assert(it.offset_in_bytes == 56, "b3ContactHitEvent.userMaterialIdA has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactHitEvent.userMaterialIdA has unexpected size % instead of 8", it.type.runtime_size);
                case "userMaterialIdB";
                    assert(it.offset_in_bytes == 64, "b3ContactHitEvent.userMaterialIdB has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactHitEvent.userMaterialIdB has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(b3ContactHitEvent) == 72, "b3ContactHitEvent has size % instead of 72", size_of(b3ContactHitEvent));
    }

    {
        info := type_info(b3ContactEvents);
        for info.members {
            if it.name == {
                case "beginEvents";
                    assert(it.offset_in_bytes == 0, "b3ContactEvents.beginEvents has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactEvents.beginEvents has unexpected size % instead of 8", it.type.runtime_size);
                case "endEvents";
                    assert(it.offset_in_bytes == 8, "b3ContactEvents.endEvents has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactEvents.endEvents has unexpected size % instead of 8", it.type.runtime_size);
                case "hitEvents";
                    assert(it.offset_in_bytes == 16, "b3ContactEvents.hitEvents has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactEvents.hitEvents has unexpected size % instead of 8", it.type.runtime_size);
                case "beginCount";
                    assert(it.offset_in_bytes == 24, "b3ContactEvents.beginCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ContactEvents.beginCount has unexpected size % instead of 4", it.type.runtime_size);
                case "endCount";
                    assert(it.offset_in_bytes == 28, "b3ContactEvents.endCount has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ContactEvents.endCount has unexpected size % instead of 4", it.type.runtime_size);
                case "hitCount";
                    assert(it.offset_in_bytes == 32, "b3ContactEvents.hitCount has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ContactEvents.hitCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3ContactEvents) == 40, "b3ContactEvents has size % instead of 40", size_of(b3ContactEvents));
    }

    {
        info := type_info(b3BodyMoveEvent);
        for info.members {
            if it.name == {
                case "userData";
                    assert(it.offset_in_bytes == 0, "b3BodyMoveEvent.userData has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BodyMoveEvent.userData has unexpected size % instead of 8", it.type.runtime_size);
                case "transform";
                    assert(it.offset_in_bytes == 8, "b3BodyMoveEvent.transform has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3BodyMoveEvent.transform has unexpected size % instead of 28", it.type.runtime_size);
                case "bodyId";
                    assert(it.offset_in_bytes == 36, "b3BodyMoveEvent.bodyId has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BodyMoveEvent.bodyId has unexpected size % instead of 8", it.type.runtime_size);
                case "fellAsleep";
                    assert(it.offset_in_bytes == 44, "b3BodyMoveEvent.fellAsleep has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3BodyMoveEvent.fellAsleep has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3BodyMoveEvent) == 48, "b3BodyMoveEvent has size % instead of 48", size_of(b3BodyMoveEvent));
    }

    {
        info := type_info(b3BodyEvents);
        for info.members {
            if it.name == {
                case "moveEvents";
                    assert(it.offset_in_bytes == 0, "b3BodyEvents.moveEvents has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BodyEvents.moveEvents has unexpected size % instead of 8", it.type.runtime_size);
                case "moveCount";
                    assert(it.offset_in_bytes == 8, "b3BodyEvents.moveCount has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyEvents.moveCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3BodyEvents) == 16, "b3BodyEvents has size % instead of 16", size_of(b3BodyEvents));
    }

    {
        info := type_info(b3JointEvent);
        for info.members {
            if it.name == {
                case "jointId";
                    assert(it.offset_in_bytes == 0, "b3JointEvent.jointId has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3JointEvent.jointId has unexpected size % instead of 8", it.type.runtime_size);
                case "userData";
                    assert(it.offset_in_bytes == 8, "b3JointEvent.userData has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3JointEvent.userData has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(b3JointEvent) == 16, "b3JointEvent has size % instead of 16", size_of(b3JointEvent));
    }

    {
        info := type_info(b3JointEvents);
        for info.members {
            if it.name == {
                case "jointEvents";
                    assert(it.offset_in_bytes == 0, "b3JointEvents.jointEvents has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3JointEvents.jointEvents has unexpected size % instead of 8", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 8, "b3JointEvents.count has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3JointEvents.count has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3JointEvents) == 16, "b3JointEvents has size % instead of 16", size_of(b3JointEvents));
    }

    {
        info := type_info(b3ContactData);
        for info.members {
            if it.name == {
                case "contactId";
                    assert(it.offset_in_bytes == 0, "b3ContactData.contactId has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ContactData.contactId has unexpected size % instead of 12", it.type.runtime_size);
                case "shapeIdA";
                    assert(it.offset_in_bytes == 12, "b3ContactData.shapeIdA has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactData.shapeIdA has unexpected size % instead of 8", it.type.runtime_size);
                case "shapeIdB";
                    assert(it.offset_in_bytes == 20, "b3ContactData.shapeIdB has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactData.shapeIdB has unexpected size % instead of 8", it.type.runtime_size);
                case "manifolds";
                    assert(it.offset_in_bytes == 32, "b3ContactData.manifolds has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ContactData.manifolds has unexpected size % instead of 8", it.type.runtime_size);
                case "manifoldCount";
                    assert(it.offset_in_bytes == 40, "b3ContactData.manifoldCount has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ContactData.manifoldCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3ContactData) == 48, "b3ContactData has size % instead of 48", size_of(b3ContactData));
    }

    {
        info := type_info(b3QueryFilter);
        for info.members {
            if it.name == {
                case "categoryBits";
                    assert(it.offset_in_bytes == 0, "b3QueryFilter.categoryBits has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3QueryFilter.categoryBits has unexpected size % instead of 8", it.type.runtime_size);
                case "maskBits";
                    assert(it.offset_in_bytes == 8, "b3QueryFilter.maskBits has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3QueryFilter.maskBits has unexpected size % instead of 8", it.type.runtime_size);
                case "id";
                    assert(it.offset_in_bytes == 16, "b3QueryFilter.id has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3QueryFilter.id has unexpected size % instead of 8", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 24, "b3QueryFilter.name has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3QueryFilter.name has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(b3QueryFilter) == 32, "b3QueryFilter has size % instead of 32", size_of(b3QueryFilter));
    }

    {
        info := type_info(b3RayCastInput);
        for info.members {
            if it.name == {
                case "origin";
                    assert(it.offset_in_bytes == 0, "b3RayCastInput.origin has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3RayCastInput.origin has unexpected size % instead of 12", it.type.runtime_size);
                case "translation";
                    assert(it.offset_in_bytes == 12, "b3RayCastInput.translation has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3RayCastInput.translation has unexpected size % instead of 12", it.type.runtime_size);
                case "maxFraction";
                    assert(it.offset_in_bytes == 24, "b3RayCastInput.maxFraction has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RayCastInput.maxFraction has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3RayCastInput) == 28, "b3RayCastInput has size % instead of 28", size_of(b3RayCastInput));
    }

    {
        info := type_info(b3RayResult);
        for info.members {
            if it.name == {
                case "shapeId";
                    assert(it.offset_in_bytes == 0, "b3RayResult.shapeId has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3RayResult.shapeId has unexpected size % instead of 8", it.type.runtime_size);
                case "point";
                    assert(it.offset_in_bytes == 8, "b3RayResult.point has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3RayResult.point has unexpected size % instead of 12", it.type.runtime_size);
                case "normal";
                    assert(it.offset_in_bytes == 20, "b3RayResult.normal has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3RayResult.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "userMaterialId";
                    assert(it.offset_in_bytes == 32, "b3RayResult.userMaterialId has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3RayResult.userMaterialId has unexpected size % instead of 8", it.type.runtime_size);
                case "fraction";
                    assert(it.offset_in_bytes == 40, "b3RayResult.fraction has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RayResult.fraction has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleIndex";
                    assert(it.offset_in_bytes == 44, "b3RayResult.triangleIndex has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RayResult.triangleIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "childIndex";
                    assert(it.offset_in_bytes == 48, "b3RayResult.childIndex has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RayResult.childIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "nodeVisits";
                    assert(it.offset_in_bytes == 52, "b3RayResult.nodeVisits has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RayResult.nodeVisits has unexpected size % instead of 4", it.type.runtime_size);
                case "leafVisits";
                    assert(it.offset_in_bytes == 56, "b3RayResult.leafVisits has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RayResult.leafVisits has unexpected size % instead of 4", it.type.runtime_size);
                case "hit";
                    assert(it.offset_in_bytes == 60, "b3RayResult.hit has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3RayResult.hit has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3RayResult) == 64, "b3RayResult has size % instead of 64", size_of(b3RayResult));
    }

    {
        info := type_info(b3ShapeProxy);
        for info.members {
            if it.name == {
                case "points";
                    assert(it.offset_in_bytes == 0, "b3ShapeProxy.points has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3ShapeProxy.points has unexpected size % instead of 8", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 8, "b3ShapeProxy.count has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeProxy.count has unexpected size % instead of 4", it.type.runtime_size);
                case "radius";
                    assert(it.offset_in_bytes == 12, "b3ShapeProxy.radius has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeProxy.radius has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3ShapeProxy) == 16, "b3ShapeProxy has size % instead of 16", size_of(b3ShapeProxy));
    }

    {
        info := type_info(b3ShapeCastInput);
        for info.members {
            if it.name == {
                case "proxy";
                    assert(it.offset_in_bytes == 0, "b3ShapeCastInput.proxy has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3ShapeCastInput.proxy has unexpected size % instead of 16", it.type.runtime_size);
                case "translation";
                    assert(it.offset_in_bytes == 16, "b3ShapeCastInput.translation has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ShapeCastInput.translation has unexpected size % instead of 12", it.type.runtime_size);
                case "maxFraction";
                    assert(it.offset_in_bytes == 28, "b3ShapeCastInput.maxFraction has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeCastInput.maxFraction has unexpected size % instead of 4", it.type.runtime_size);
                case "canEncroach";
                    assert(it.offset_in_bytes == 32, "b3ShapeCastInput.canEncroach has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeCastInput.canEncroach has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3ShapeCastInput) == 40, "b3ShapeCastInput has size % instead of 40", size_of(b3ShapeCastInput));
    }

    {
        info := type_info(b3BoxCastInput);
        for info.members {
            if it.name == {
                case "box";
                    assert(it.offset_in_bytes == 0, "b3BoxCastInput.box has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3BoxCastInput.box has unexpected size % instead of 24", it.type.runtime_size);
                case "translation";
                    assert(it.offset_in_bytes == 24, "b3BoxCastInput.translation has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3BoxCastInput.translation has unexpected size % instead of 12", it.type.runtime_size);
                case "maxFraction";
                    assert(it.offset_in_bytes == 36, "b3BoxCastInput.maxFraction has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BoxCastInput.maxFraction has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3BoxCastInput) == 40, "b3BoxCastInput has size % instead of 40", size_of(b3BoxCastInput));
    }

    {
        info := type_info(b3CastOutput);
        for info.members {
            if it.name == {
                case "normal";
                    assert(it.offset_in_bytes == 0, "b3CastOutput.normal has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3CastOutput.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "point";
                    assert(it.offset_in_bytes == 12, "b3CastOutput.point has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3CastOutput.point has unexpected size % instead of 12", it.type.runtime_size);
                case "fraction";
                    assert(it.offset_in_bytes == 24, "b3CastOutput.fraction has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CastOutput.fraction has unexpected size % instead of 4", it.type.runtime_size);
                case "iterations";
                    assert(it.offset_in_bytes == 28, "b3CastOutput.iterations has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CastOutput.iterations has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleIndex";
                    assert(it.offset_in_bytes == 32, "b3CastOutput.triangleIndex has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CastOutput.triangleIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "childIndex";
                    assert(it.offset_in_bytes == 36, "b3CastOutput.childIndex has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CastOutput.childIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "materialIndex";
                    assert(it.offset_in_bytes == 40, "b3CastOutput.materialIndex has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CastOutput.materialIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "hit";
                    assert(it.offset_in_bytes == 44, "b3CastOutput.hit has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3CastOutput.hit has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3CastOutput) == 48, "b3CastOutput has size % instead of 48", size_of(b3CastOutput));
    }

    {
        info := type_info(b3BodyCastResult);
        for info.members {
            if it.name == {
                case "shapeId";
                    assert(it.offset_in_bytes == 0, "b3BodyCastResult.shapeId has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BodyCastResult.shapeId has unexpected size % instead of 8", it.type.runtime_size);
                case "point";
                    assert(it.offset_in_bytes == 8, "b3BodyCastResult.point has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3BodyCastResult.point has unexpected size % instead of 12", it.type.runtime_size);
                case "normal";
                    assert(it.offset_in_bytes == 20, "b3BodyCastResult.normal has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3BodyCastResult.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "fraction";
                    assert(it.offset_in_bytes == 32, "b3BodyCastResult.fraction has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyCastResult.fraction has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleIndex";
                    assert(it.offset_in_bytes == 36, "b3BodyCastResult.triangleIndex has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyCastResult.triangleIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "userMaterialId";
                    assert(it.offset_in_bytes == 40, "b3BodyCastResult.userMaterialId has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BodyCastResult.userMaterialId has unexpected size % instead of 8", it.type.runtime_size);
                case "iterations";
                    assert(it.offset_in_bytes == 48, "b3BodyCastResult.iterations has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3BodyCastResult.iterations has unexpected size % instead of 4", it.type.runtime_size);
                case "hit";
                    assert(it.offset_in_bytes == 52, "b3BodyCastResult.hit has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3BodyCastResult.hit has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3BodyCastResult) == 56, "b3BodyCastResult has size % instead of 56", size_of(b3BodyCastResult));
    }

    {
        info := type_info(b3SimplexCache);
        for info.members {
            if it.name == {
                case "metric";
                    assert(it.offset_in_bytes == 0, "b3SimplexCache.metric has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SimplexCache.metric has unexpected size % instead of 4", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 4, "b3SimplexCache.count has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3SimplexCache.count has unexpected size % instead of 2", it.type.runtime_size);
                case "indexA";
                    assert(it.offset_in_bytes == 6, "b3SimplexCache.indexA has unexpected offset % instead of 6", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SimplexCache.indexA has unexpected size % instead of 4", it.type.runtime_size);
                case "indexB";
                    assert(it.offset_in_bytes == 10, "b3SimplexCache.indexB has unexpected offset % instead of 10", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SimplexCache.indexB has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3SimplexCache) == 16, "b3SimplexCache has size % instead of 16", size_of(b3SimplexCache));
    }

    {
        info := type_info(b3ShapeCastPairInput);
        for info.members {
            if it.name == {
                case "proxyA";
                    assert(it.offset_in_bytes == 0, "b3ShapeCastPairInput.proxyA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3ShapeCastPairInput.proxyA has unexpected size % instead of 16", it.type.runtime_size);
                case "proxyB";
                    assert(it.offset_in_bytes == 16, "b3ShapeCastPairInput.proxyB has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3ShapeCastPairInput.proxyB has unexpected size % instead of 16", it.type.runtime_size);
                case "transform";
                    assert(it.offset_in_bytes == 32, "b3ShapeCastPairInput.transform has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3ShapeCastPairInput.transform has unexpected size % instead of 28", it.type.runtime_size);
                case "translationB";
                    assert(it.offset_in_bytes == 60, "b3ShapeCastPairInput.translationB has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ShapeCastPairInput.translationB has unexpected size % instead of 12", it.type.runtime_size);
                case "maxFraction";
                    assert(it.offset_in_bytes == 72, "b3ShapeCastPairInput.maxFraction has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ShapeCastPairInput.maxFraction has unexpected size % instead of 4", it.type.runtime_size);
                case "canEncroach";
                    assert(it.offset_in_bytes == 76, "b3ShapeCastPairInput.canEncroach has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ShapeCastPairInput.canEncroach has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3ShapeCastPairInput) == 80, "b3ShapeCastPairInput has size % instead of 80", size_of(b3ShapeCastPairInput));
    }

    {
        info := type_info(b3DistanceInput);
        for info.members {
            if it.name == {
                case "proxyA";
                    assert(it.offset_in_bytes == 0, "b3DistanceInput.proxyA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3DistanceInput.proxyA has unexpected size % instead of 16", it.type.runtime_size);
                case "proxyB";
                    assert(it.offset_in_bytes == 16, "b3DistanceInput.proxyB has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3DistanceInput.proxyB has unexpected size % instead of 16", it.type.runtime_size);
                case "transform";
                    assert(it.offset_in_bytes == 32, "b3DistanceInput.transform has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3DistanceInput.transform has unexpected size % instead of 28", it.type.runtime_size);
                case "useRadii";
                    assert(it.offset_in_bytes == 60, "b3DistanceInput.useRadii has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DistanceInput.useRadii has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3DistanceInput) == 64, "b3DistanceInput has size % instead of 64", size_of(b3DistanceInput));
    }

    {
        info := type_info(b3DistanceOutput);
        for info.members {
            if it.name == {
                case "pointA";
                    assert(it.offset_in_bytes == 0, "b3DistanceOutput.pointA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3DistanceOutput.pointA has unexpected size % instead of 12", it.type.runtime_size);
                case "pointB";
                    assert(it.offset_in_bytes == 12, "b3DistanceOutput.pointB has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3DistanceOutput.pointB has unexpected size % instead of 12", it.type.runtime_size);
                case "normal";
                    assert(it.offset_in_bytes == 24, "b3DistanceOutput.normal has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3DistanceOutput.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "distance";
                    assert(it.offset_in_bytes == 36, "b3DistanceOutput.distance has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceOutput.distance has unexpected size % instead of 4", it.type.runtime_size);
                case "iterations";
                    assert(it.offset_in_bytes == 40, "b3DistanceOutput.iterations has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceOutput.iterations has unexpected size % instead of 4", it.type.runtime_size);
                case "simplexCount";
                    assert(it.offset_in_bytes == 44, "b3DistanceOutput.simplexCount has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DistanceOutput.simplexCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3DistanceOutput) == 48, "b3DistanceOutput has size % instead of 48", size_of(b3DistanceOutput));
    }

    {
        info := type_info(b3SimplexVertex);
        for info.members {
            if it.name == {
                case "wA";
                    assert(it.offset_in_bytes == 0, "b3SimplexVertex.wA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3SimplexVertex.wA has unexpected size % instead of 12", it.type.runtime_size);
                case "wB";
                    assert(it.offset_in_bytes == 12, "b3SimplexVertex.wB has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3SimplexVertex.wB has unexpected size % instead of 12", it.type.runtime_size);
                case "w";
                    assert(it.offset_in_bytes == 24, "b3SimplexVertex.w has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3SimplexVertex.w has unexpected size % instead of 12", it.type.runtime_size);
                case "a";
                    assert(it.offset_in_bytes == 36, "b3SimplexVertex.a has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SimplexVertex.a has unexpected size % instead of 4", it.type.runtime_size);
                case "indexA";
                    assert(it.offset_in_bytes == 40, "b3SimplexVertex.indexA has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SimplexVertex.indexA has unexpected size % instead of 4", it.type.runtime_size);
                case "indexB";
                    assert(it.offset_in_bytes == 44, "b3SimplexVertex.indexB has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SimplexVertex.indexB has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3SimplexVertex) == 48, "b3SimplexVertex has size % instead of 48", size_of(b3SimplexVertex));
    }

    {
        info := type_info(b3Simplex);
        for info.members {
            if it.name == {
                case "vertices";
                    assert(it.offset_in_bytes == 0, "b3Simplex.vertices has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 192, "b3Simplex.vertices has unexpected size % instead of 192", it.type.runtime_size);
                case "count";
                    assert(it.offset_in_bytes == 192, "b3Simplex.count has unexpected offset % instead of 192", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Simplex.count has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Simplex) == 196, "b3Simplex has size % instead of 196", size_of(b3Simplex));
    }

    {
        info := type_info(b3Sweep);
        for info.members {
            if it.name == {
                case "localCenter";
                    assert(it.offset_in_bytes == 0, "b3Sweep.localCenter has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Sweep.localCenter has unexpected size % instead of 12", it.type.runtime_size);
                case "c1";
                    assert(it.offset_in_bytes == 12, "b3Sweep.c1 has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Sweep.c1 has unexpected size % instead of 12", it.type.runtime_size);
                case "c2";
                    assert(it.offset_in_bytes == 24, "b3Sweep.c2 has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Sweep.c2 has unexpected size % instead of 12", it.type.runtime_size);
                case "q1";
                    assert(it.offset_in_bytes == 36, "b3Sweep.q1 has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3Sweep.q1 has unexpected size % instead of 16", it.type.runtime_size);
                case "q2";
                    assert(it.offset_in_bytes == 52, "b3Sweep.q2 has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3Sweep.q2 has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(b3Sweep) == 68, "b3Sweep has size % instead of 68", size_of(b3Sweep));
    }

    {
        info := type_info(b3TOIInput);
        for info.members {
            if it.name == {
                case "proxyA";
                    assert(it.offset_in_bytes == 0, "b3TOIInput.proxyA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3TOIInput.proxyA has unexpected size % instead of 16", it.type.runtime_size);
                case "proxyB";
                    assert(it.offset_in_bytes == 16, "b3TOIInput.proxyB has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3TOIInput.proxyB has unexpected size % instead of 16", it.type.runtime_size);
                case "sweepA";
                    assert(it.offset_in_bytes == 32, "b3TOIInput.sweepA has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 68, "b3TOIInput.sweepA has unexpected size % instead of 68", it.type.runtime_size);
                case "sweepB";
                    assert(it.offset_in_bytes == 100, "b3TOIInput.sweepB has unexpected offset % instead of 100", it.offset_in_bytes);
                    assert(it.type.runtime_size == 68, "b3TOIInput.sweepB has unexpected size % instead of 68", it.type.runtime_size);
                case "maxFraction";
                    assert(it.offset_in_bytes == 168, "b3TOIInput.maxFraction has unexpected offset % instead of 168", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TOIInput.maxFraction has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3TOIInput) == 176, "b3TOIInput has size % instead of 176", size_of(b3TOIInput));
    }

    {
        info := type_info(b3TOIOutput);
        for info.members {
            if it.name == {
                case "state";
                    assert(it.offset_in_bytes == 0, "b3TOIOutput.state has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TOIOutput.state has unexpected size % instead of 4", it.type.runtime_size);
                case "point";
                    assert(it.offset_in_bytes == 4, "b3TOIOutput.point has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3TOIOutput.point has unexpected size % instead of 12", it.type.runtime_size);
                case "normal";
                    assert(it.offset_in_bytes == 16, "b3TOIOutput.normal has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3TOIOutput.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "fraction";
                    assert(it.offset_in_bytes == 28, "b3TOIOutput.fraction has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TOIOutput.fraction has unexpected size % instead of 4", it.type.runtime_size);
                case "distance";
                    assert(it.offset_in_bytes == 32, "b3TOIOutput.distance has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TOIOutput.distance has unexpected size % instead of 4", it.type.runtime_size);
                case "distanceIterations";
                    assert(it.offset_in_bytes == 36, "b3TOIOutput.distanceIterations has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TOIOutput.distanceIterations has unexpected size % instead of 4", it.type.runtime_size);
                case "pushBackIterations";
                    assert(it.offset_in_bytes == 40, "b3TOIOutput.pushBackIterations has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TOIOutput.pushBackIterations has unexpected size % instead of 4", it.type.runtime_size);
                case "rootIterations";
                    assert(it.offset_in_bytes == 44, "b3TOIOutput.rootIterations has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TOIOutput.rootIterations has unexpected size % instead of 4", it.type.runtime_size);
                case "usedFallback";
                    assert(it.offset_in_bytes == 48, "b3TOIOutput.usedFallback has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3TOIOutput.usedFallback has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3TOIOutput) == 52, "b3TOIOutput has size % instead of 52", size_of(b3TOIOutput));
    }

    {
        info := type_info(b3TreeNodeChildren);
        for info.members {
            if it.name == {
                case "child1";
                    assert(it.offset_in_bytes == 0, "b3TreeNodeChildren.child1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TreeNodeChildren.child1 has unexpected size % instead of 4", it.type.runtime_size);
                case "child2";
                    assert(it.offset_in_bytes == 4, "b3TreeNodeChildren.child2 has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TreeNodeChildren.child2 has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3TreeNodeChildren) == 8, "b3TreeNodeChildren has size % instead of 8", size_of(b3TreeNodeChildren));
    }

    {
        info := type_info(b3TreeNode);
        for info.members {
            if it.name == {
                case "aabb";
                    assert(it.offset_in_bytes == 0, "b3TreeNode.aabb has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3TreeNode.aabb has unexpected size % instead of 24", it.type.runtime_size);
                case "categoryBits";
                    assert(it.offset_in_bytes == 24, "b3TreeNode.categoryBits has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3TreeNode.categoryBits has unexpected size % instead of 8", it.type.runtime_size);
                case "height";
                    assert(it.offset_in_bytes == 44, "b3TreeNode.height has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3TreeNode.height has unexpected size % instead of 2", it.type.runtime_size);
                case "flags";
                    assert(it.offset_in_bytes == 46, "b3TreeNode.flags has unexpected offset % instead of 46", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3TreeNode.flags has unexpected size % instead of 2", it.type.runtime_size);
            }
        }
        assert(size_of(b3TreeNode) == 48, "b3TreeNode has size % instead of 48", size_of(b3TreeNode));
    }

    {
        info := type_info(b3DynamicTree);
        for info.members {
            if it.name == {
                case "version";
                    assert(it.offset_in_bytes == 0, "b3DynamicTree.version has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DynamicTree.version has unexpected size % instead of 8", it.type.runtime_size);
                case "nodes";
                    assert(it.offset_in_bytes == 8, "b3DynamicTree.nodes has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DynamicTree.nodes has unexpected size % instead of 8", it.type.runtime_size);
                case "root";
                    assert(it.offset_in_bytes == 16, "b3DynamicTree.root has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DynamicTree.root has unexpected size % instead of 4", it.type.runtime_size);
                case "nodeCount";
                    assert(it.offset_in_bytes == 20, "b3DynamicTree.nodeCount has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DynamicTree.nodeCount has unexpected size % instead of 4", it.type.runtime_size);
                case "nodeCapacity";
                    assert(it.offset_in_bytes == 24, "b3DynamicTree.nodeCapacity has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DynamicTree.nodeCapacity has unexpected size % instead of 4", it.type.runtime_size);
                case "proxyCount";
                    assert(it.offset_in_bytes == 28, "b3DynamicTree.proxyCount has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DynamicTree.proxyCount has unexpected size % instead of 4", it.type.runtime_size);
                case "freeList";
                    assert(it.offset_in_bytes == 32, "b3DynamicTree.freeList has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DynamicTree.freeList has unexpected size % instead of 4", it.type.runtime_size);
                case "leafIndices";
                    assert(it.offset_in_bytes == 40, "b3DynamicTree.leafIndices has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DynamicTree.leafIndices has unexpected size % instead of 8", it.type.runtime_size);
                case "leafBoxes";
                    assert(it.offset_in_bytes == 48, "b3DynamicTree.leafBoxes has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DynamicTree.leafBoxes has unexpected size % instead of 8", it.type.runtime_size);
                case "leafCenters";
                    assert(it.offset_in_bytes == 56, "b3DynamicTree.leafCenters has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DynamicTree.leafCenters has unexpected size % instead of 8", it.type.runtime_size);
                case "binIndices";
                    assert(it.offset_in_bytes == 64, "b3DynamicTree.binIndices has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DynamicTree.binIndices has unexpected size % instead of 8", it.type.runtime_size);
                case "rebuildCapacity";
                    assert(it.offset_in_bytes == 72, "b3DynamicTree.rebuildCapacity has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DynamicTree.rebuildCapacity has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3DynamicTree) == 80, "b3DynamicTree has size % instead of 80", size_of(b3DynamicTree));
    }

    {
        info := type_info(b3TreeStats);
        for info.members {
            if it.name == {
                case "nodeVisits";
                    assert(it.offset_in_bytes == 0, "b3TreeStats.nodeVisits has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TreeStats.nodeVisits has unexpected size % instead of 4", it.type.runtime_size);
                case "leafVisits";
                    assert(it.offset_in_bytes == 4, "b3TreeStats.leafVisits has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3TreeStats.leafVisits has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3TreeStats) == 8, "b3TreeStats has size % instead of 8", size_of(b3TreeStats));
    }

    {
        info := type_info(b3PlaneResult);
        for info.members {
            if it.name == {
                case "plane";
                    assert(it.offset_in_bytes == 0, "b3PlaneResult.plane has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3PlaneResult.plane has unexpected size % instead of 16", it.type.runtime_size);
                case "point";
                    assert(it.offset_in_bytes == 16, "b3PlaneResult.point has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3PlaneResult.point has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(b3PlaneResult) == 28, "b3PlaneResult has size % instead of 28", size_of(b3PlaneResult));
    }

    {
        info := type_info(b3CollisionPlane);
        for info.members {
            if it.name == {
                case "plane";
                    assert(it.offset_in_bytes == 0, "b3CollisionPlane.plane has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3CollisionPlane.plane has unexpected size % instead of 16", it.type.runtime_size);
                case "pushLimit";
                    assert(it.offset_in_bytes == 16, "b3CollisionPlane.pushLimit has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CollisionPlane.pushLimit has unexpected size % instead of 4", it.type.runtime_size);
                case "push";
                    assert(it.offset_in_bytes == 20, "b3CollisionPlane.push has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CollisionPlane.push has unexpected size % instead of 4", it.type.runtime_size);
                case "clipVelocity";
                    assert(it.offset_in_bytes == 24, "b3CollisionPlane.clipVelocity has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3CollisionPlane.clipVelocity has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3CollisionPlane) == 28, "b3CollisionPlane has size % instead of 28", size_of(b3CollisionPlane));
    }

    {
        info := type_info(b3PlaneSolverResult);
        for info.members {
            if it.name == {
                case "delta";
                    assert(it.offset_in_bytes == 0, "b3PlaneSolverResult.delta has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3PlaneSolverResult.delta has unexpected size % instead of 12", it.type.runtime_size);
                case "iterationCount";
                    assert(it.offset_in_bytes == 12, "b3PlaneSolverResult.iterationCount has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3PlaneSolverResult.iterationCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3PlaneSolverResult) == 16, "b3PlaneSolverResult has size % instead of 16", size_of(b3PlaneSolverResult));
    }

    {
        info := type_info(b3BodyPlaneResult);
        for info.members {
            if it.name == {
                case "shapeId";
                    assert(it.offset_in_bytes == 0, "b3BodyPlaneResult.shapeId has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BodyPlaneResult.shapeId has unexpected size % instead of 8", it.type.runtime_size);
                case "result";
                    assert(it.offset_in_bytes == 8, "b3BodyPlaneResult.result has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3BodyPlaneResult.result has unexpected size % instead of 28", it.type.runtime_size);
            }
        }
        assert(size_of(b3BodyPlaneResult) == 36, "b3BodyPlaneResult has size % instead of 36", size_of(b3BodyPlaneResult));
    }

    {
        info := type_info(b3MassData);
        for info.members {
            if it.name == {
                case "mass";
                    assert(it.offset_in_bytes == 0, "b3MassData.mass has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MassData.mass has unexpected size % instead of 4", it.type.runtime_size);
                case "center";
                    assert(it.offset_in_bytes == 4, "b3MassData.center has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3MassData.center has unexpected size % instead of 12", it.type.runtime_size);
                case "inertia";
                    assert(it.offset_in_bytes == 16, "b3MassData.inertia has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 36, "b3MassData.inertia has unexpected size % instead of 36", it.type.runtime_size);
            }
        }
        assert(size_of(b3MassData) == 52, "b3MassData has size % instead of 52", size_of(b3MassData));
    }

    {
        info := type_info(b3Sphere);
        for info.members {
            if it.name == {
                case "center";
                    assert(it.offset_in_bytes == 0, "b3Sphere.center has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Sphere.center has unexpected size % instead of 12", it.type.runtime_size);
                case "radius";
                    assert(it.offset_in_bytes == 12, "b3Sphere.radius has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Sphere.radius has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Sphere) == 16, "b3Sphere has size % instead of 16", size_of(b3Sphere));
    }

    {
        info := type_info(b3Capsule);
        for info.members {
            if it.name == {
                case "center1";
                    assert(it.offset_in_bytes == 0, "b3Capsule.center1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Capsule.center1 has unexpected size % instead of 12", it.type.runtime_size);
                case "center2";
                    assert(it.offset_in_bytes == 12, "b3Capsule.center2 has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Capsule.center2 has unexpected size % instead of 12", it.type.runtime_size);
                case "radius";
                    assert(it.offset_in_bytes == 24, "b3Capsule.radius has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Capsule.radius has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Capsule) == 28, "b3Capsule has size % instead of 28", size_of(b3Capsule));
    }

    {
        info := type_info(b3HullVertex);
        for info.members {
            if it.name == {
                case "edge";
                    assert(it.offset_in_bytes == 0, "b3HullVertex.edge has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3HullVertex.edge has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3HullVertex) == 1, "b3HullVertex has size % instead of 1", size_of(b3HullVertex));
    }

    {
        info := type_info(b3HullHalfEdge);
        for info.members {
            if it.name == {
                case "next";
                    assert(it.offset_in_bytes == 0, "b3HullHalfEdge.next has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3HullHalfEdge.next has unexpected size % instead of 1", it.type.runtime_size);
                case "twin";
                    assert(it.offset_in_bytes == 1, "b3HullHalfEdge.twin has unexpected offset % instead of 1", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3HullHalfEdge.twin has unexpected size % instead of 1", it.type.runtime_size);
                case "origin";
                    assert(it.offset_in_bytes == 2, "b3HullHalfEdge.origin has unexpected offset % instead of 2", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3HullHalfEdge.origin has unexpected size % instead of 1", it.type.runtime_size);
                case "face";
                    assert(it.offset_in_bytes == 3, "b3HullHalfEdge.face has unexpected offset % instead of 3", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3HullHalfEdge.face has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3HullHalfEdge) == 4, "b3HullHalfEdge has size % instead of 4", size_of(b3HullHalfEdge));
    }

    {
        info := type_info(b3HullFace);
        for info.members {
            if it.name == {
                case "edge";
                    assert(it.offset_in_bytes == 0, "b3HullFace.edge has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3HullFace.edge has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3HullFace) == 1, "b3HullFace has size % instead of 1", size_of(b3HullFace));
    }

    {
        info := type_info(b3HullData);
        for info.members {
            if it.name == {
                case "version";
                    assert(it.offset_in_bytes == 0, "b3HullData.version has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3HullData.version has unexpected size % instead of 8", it.type.runtime_size);
                case "hash";
                    assert(it.offset_in_bytes == 8, "b3HullData.hash has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3HullData.hash has unexpected size % instead of 8", it.type.runtime_size);
                case "aabb";
                    assert(it.offset_in_bytes == 16, "b3HullData.aabb has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3HullData.aabb has unexpected size % instead of 24", it.type.runtime_size);
                case "surfaceArea";
                    assert(it.offset_in_bytes == 40, "b3HullData.surfaceArea has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.surfaceArea has unexpected size % instead of 4", it.type.runtime_size);
                case "volume";
                    assert(it.offset_in_bytes == 44, "b3HullData.volume has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.volume has unexpected size % instead of 4", it.type.runtime_size);
                case "innerRadius";
                    assert(it.offset_in_bytes == 48, "b3HullData.innerRadius has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.innerRadius has unexpected size % instead of 4", it.type.runtime_size);
                case "center";
                    assert(it.offset_in_bytes == 52, "b3HullData.center has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3HullData.center has unexpected size % instead of 12", it.type.runtime_size);
                case "centralInertia";
                    assert(it.offset_in_bytes == 64, "b3HullData.centralInertia has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 36, "b3HullData.centralInertia has unexpected size % instead of 36", it.type.runtime_size);
                case "vertexCount";
                    assert(it.offset_in_bytes == 100, "b3HullData.vertexCount has unexpected offset % instead of 100", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.vertexCount has unexpected size % instead of 4", it.type.runtime_size);
                case "vertexOffset";
                    assert(it.offset_in_bytes == 104, "b3HullData.vertexOffset has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.vertexOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "pointOffset";
                    assert(it.offset_in_bytes == 108, "b3HullData.pointOffset has unexpected offset % instead of 108", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.pointOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "edgeCount";
                    assert(it.offset_in_bytes == 112, "b3HullData.edgeCount has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.edgeCount has unexpected size % instead of 4", it.type.runtime_size);
                case "edgeOffset";
                    assert(it.offset_in_bytes == 116, "b3HullData.edgeOffset has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.edgeOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "faceCount";
                    assert(it.offset_in_bytes == 120, "b3HullData.faceCount has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.faceCount has unexpected size % instead of 4", it.type.runtime_size);
                case "planeOffset";
                    assert(it.offset_in_bytes == 124, "b3HullData.planeOffset has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.planeOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "faceOffset";
                    assert(it.offset_in_bytes == 128, "b3HullData.faceOffset has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.faceOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "soaVertexOffset";
                    assert(it.offset_in_bytes == 132, "b3HullData.soaVertexOffset has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.soaVertexOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "soaNormalOffset";
                    assert(it.offset_in_bytes == 136, "b3HullData.soaNormalOffset has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.soaNormalOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "byteCount";
                    assert(it.offset_in_bytes == 140, "b3HullData.byteCount has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HullData.byteCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3HullData) == 144, "b3HullData has size % instead of 144", size_of(b3HullData));
    }

    {
        info := type_info(b3BoxHull);
        for info.members {
            if it.name == {
                case "base";
                    assert(it.offset_in_bytes == 0, "b3BoxHull.base has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 144, "b3BoxHull.base has unexpected size % instead of 144", it.type.runtime_size);
                case "boxVertices";
                    assert(it.offset_in_bytes == 144, "b3BoxHull.boxVertices has unexpected offset % instead of 144", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3BoxHull.boxVertices has unexpected size % instead of 8", it.type.runtime_size);
                case "boxPoints";
                    assert(it.offset_in_bytes == 152, "b3BoxHull.boxPoints has unexpected offset % instead of 152", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "b3BoxHull.boxPoints has unexpected size % instead of 96", it.type.runtime_size);
                case "boxEdges";
                    assert(it.offset_in_bytes == 248, "b3BoxHull.boxEdges has unexpected offset % instead of 248", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "b3BoxHull.boxEdges has unexpected size % instead of 96", it.type.runtime_size);
                case "boxPlanes";
                    assert(it.offset_in_bytes == 344, "b3BoxHull.boxPlanes has unexpected offset % instead of 344", it.offset_in_bytes);
                    assert(it.type.runtime_size == 96, "b3BoxHull.boxPlanes has unexpected size % instead of 96", it.type.runtime_size);
                case "boxFaces";
                    assert(it.offset_in_bytes == 440, "b3BoxHull.boxFaces has unexpected offset % instead of 440", it.offset_in_bytes);
                    assert(it.type.runtime_size == 6, "b3BoxHull.boxFaces has unexpected size % instead of 6", it.type.runtime_size);
                case "padding";
                    assert(it.offset_in_bytes == 446, "b3BoxHull.padding has unexpected offset % instead of 446", it.offset_in_bytes);
                    assert(it.type.runtime_size == 2, "b3BoxHull.padding has unexpected size % instead of 2", it.type.runtime_size);
                case "vx";
                    assert(it.offset_in_bytes == 448, "b3BoxHull.vx has unexpected offset % instead of 448", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "b3BoxHull.vx has unexpected size % instead of 32", it.type.runtime_size);
                case "vy";
                    assert(it.offset_in_bytes == 480, "b3BoxHull.vy has unexpected offset % instead of 480", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "b3BoxHull.vy has unexpected size % instead of 32", it.type.runtime_size);
                case "vz";
                    assert(it.offset_in_bytes == 512, "b3BoxHull.vz has unexpected offset % instead of 512", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "b3BoxHull.vz has unexpected size % instead of 32", it.type.runtime_size);
                case "nx";
                    assert(it.offset_in_bytes == 544, "b3BoxHull.nx has unexpected offset % instead of 544", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "b3BoxHull.nx has unexpected size % instead of 32", it.type.runtime_size);
                case "ny";
                    assert(it.offset_in_bytes == 576, "b3BoxHull.ny has unexpected offset % instead of 576", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "b3BoxHull.ny has unexpected size % instead of 32", it.type.runtime_size);
                case "nz";
                    assert(it.offset_in_bytes == 608, "b3BoxHull.nz has unexpected offset % instead of 608", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "b3BoxHull.nz has unexpected size % instead of 32", it.type.runtime_size);
            }
        }
        assert(size_of(b3BoxHull) == 640, "b3BoxHull has size % instead of 640", size_of(b3BoxHull));
    }

    {
        info := type_info(b3MeshDef);
        for info.members {
            if it.name == {
                case "vertices";
                    assert(it.offset_in_bytes == 0, "b3MeshDef.vertices has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3MeshDef.vertices has unexpected size % instead of 8", it.type.runtime_size);
                case "indices";
                    assert(it.offset_in_bytes == 8, "b3MeshDef.indices has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3MeshDef.indices has unexpected size % instead of 8", it.type.runtime_size);
                case "materialIndices";
                    assert(it.offset_in_bytes == 16, "b3MeshDef.materialIndices has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3MeshDef.materialIndices has unexpected size % instead of 8", it.type.runtime_size);
                case "weldTolerance";
                    assert(it.offset_in_bytes == 24, "b3MeshDef.weldTolerance has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshDef.weldTolerance has unexpected size % instead of 4", it.type.runtime_size);
                case "vertexCount";
                    assert(it.offset_in_bytes == 28, "b3MeshDef.vertexCount has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshDef.vertexCount has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleCount";
                    assert(it.offset_in_bytes == 32, "b3MeshDef.triangleCount has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshDef.triangleCount has unexpected size % instead of 4", it.type.runtime_size);
                case "weldVertices";
                    assert(it.offset_in_bytes == 36, "b3MeshDef.weldVertices has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MeshDef.weldVertices has unexpected size % instead of 1", it.type.runtime_size);
                case "useMedianSplit";
                    assert(it.offset_in_bytes == 37, "b3MeshDef.useMedianSplit has unexpected offset % instead of 37", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MeshDef.useMedianSplit has unexpected size % instead of 1", it.type.runtime_size);
                case "identifyEdges";
                    assert(it.offset_in_bytes == 38, "b3MeshDef.identifyEdges has unexpected offset % instead of 38", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3MeshDef.identifyEdges has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3MeshDef) == 40, "b3MeshDef has size % instead of 40", size_of(b3MeshDef));
    }

    {
        info := type_info(b3MeshTriangle);
        for info.members {
            if it.name == {
                case "index1";
                    assert(it.offset_in_bytes == 0, "b3MeshTriangle.index1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshTriangle.index1 has unexpected size % instead of 4", it.type.runtime_size);
                case "index2";
                    assert(it.offset_in_bytes == 4, "b3MeshTriangle.index2 has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshTriangle.index2 has unexpected size % instead of 4", it.type.runtime_size);
                case "index3";
                    assert(it.offset_in_bytes == 8, "b3MeshTriangle.index3 has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshTriangle.index3 has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3MeshTriangle) == 12, "b3MeshTriangle has size % instead of 12", size_of(b3MeshTriangle));
    }

    {
        info := type_info(b3MeshNode);
        for info.members {
            if it.name == {
                case "lowerBound";
                    assert(it.offset_in_bytes == 0, "b3MeshNode.lowerBound has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3MeshNode.lowerBound has unexpected size % instead of 12", it.type.runtime_size);
                case "data";
                    assert(it.offset_in_bytes == 12, "b3MeshNode.data has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshNode.data has unexpected size % instead of 4", it.type.runtime_size);
                case "upperBound";
                    assert(it.offset_in_bytes == 16, "b3MeshNode.upperBound has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3MeshNode.upperBound has unexpected size % instead of 12", it.type.runtime_size);
                case "triangleOffset";
                    assert(it.offset_in_bytes == 28, "b3MeshNode.triangleOffset has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshNode.triangleOffset has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3MeshNode) == 32, "b3MeshNode has size % instead of 32", size_of(b3MeshNode));
    }

    {
        info := type_info(b3MeshData);
        for info.members {
            if it.name == {
                case "version";
                    assert(it.offset_in_bytes == 0, "b3MeshData.version has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3MeshData.version has unexpected size % instead of 8", it.type.runtime_size);
                case "hash";
                    assert(it.offset_in_bytes == 8, "b3MeshData.hash has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3MeshData.hash has unexpected size % instead of 8", it.type.runtime_size);
                case "byteCount";
                    assert(it.offset_in_bytes == 16, "b3MeshData.byteCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.byteCount has unexpected size % instead of 4", it.type.runtime_size);
                case "bounds";
                    assert(it.offset_in_bytes == 20, "b3MeshData.bounds has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3MeshData.bounds has unexpected size % instead of 24", it.type.runtime_size);
                case "surfaceArea";
                    assert(it.offset_in_bytes == 44, "b3MeshData.surfaceArea has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.surfaceArea has unexpected size % instead of 4", it.type.runtime_size);
                case "treeHeight";
                    assert(it.offset_in_bytes == 48, "b3MeshData.treeHeight has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.treeHeight has unexpected size % instead of 4", it.type.runtime_size);
                case "degenerateCount";
                    assert(it.offset_in_bytes == 52, "b3MeshData.degenerateCount has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.degenerateCount has unexpected size % instead of 4", it.type.runtime_size);
                case "nodeOffset";
                    assert(it.offset_in_bytes == 56, "b3MeshData.nodeOffset has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.nodeOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "nodeCount";
                    assert(it.offset_in_bytes == 60, "b3MeshData.nodeCount has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.nodeCount has unexpected size % instead of 4", it.type.runtime_size);
                case "vertexOffset";
                    assert(it.offset_in_bytes == 64, "b3MeshData.vertexOffset has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.vertexOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "vertexCount";
                    assert(it.offset_in_bytes == 68, "b3MeshData.vertexCount has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.vertexCount has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleOffset";
                    assert(it.offset_in_bytes == 72, "b3MeshData.triangleOffset has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.triangleOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleCount";
                    assert(it.offset_in_bytes == 76, "b3MeshData.triangleCount has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.triangleCount has unexpected size % instead of 4", it.type.runtime_size);
                case "materialOffset";
                    assert(it.offset_in_bytes == 80, "b3MeshData.materialOffset has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.materialOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "materialCount";
                    assert(it.offset_in_bytes == 84, "b3MeshData.materialCount has unexpected offset % instead of 84", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.materialCount has unexpected size % instead of 4", it.type.runtime_size);
                case "flagsOffset";
                    assert(it.offset_in_bytes == 88, "b3MeshData.flagsOffset has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.flagsOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "padding";
                    assert(it.offset_in_bytes == 92, "b3MeshData.padding has unexpected offset % instead of 92", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3MeshData.padding has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3MeshData) == 96, "b3MeshData has size % instead of 96", size_of(b3MeshData));
    }

    {
        info := type_info(b3Mesh);
        for info.members {
            if it.name == {
                case "data";
                    assert(it.offset_in_bytes == 0, "b3Mesh.data has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3Mesh.data has unexpected size % instead of 8", it.type.runtime_size);
                case "scale";
                    assert(it.offset_in_bytes == 8, "b3Mesh.scale has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Mesh.scale has unexpected size % instead of 12", it.type.runtime_size);
            }
        }
        assert(size_of(b3Mesh) == 24, "b3Mesh has size % instead of 24", size_of(b3Mesh));
    }

    {
        info := type_info(b3HeightFieldDef);
        for info.members {
            if it.name == {
                case "heights";
                    assert(it.offset_in_bytes == 0, "b3HeightFieldDef.heights has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3HeightFieldDef.heights has unexpected size % instead of 8", it.type.runtime_size);
                case "materialIndices";
                    assert(it.offset_in_bytes == 8, "b3HeightFieldDef.materialIndices has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3HeightFieldDef.materialIndices has unexpected size % instead of 8", it.type.runtime_size);
                case "scale";
                    assert(it.offset_in_bytes == 16, "b3HeightFieldDef.scale has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3HeightFieldDef.scale has unexpected size % instead of 12", it.type.runtime_size);
                case "countX";
                    assert(it.offset_in_bytes == 28, "b3HeightFieldDef.countX has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldDef.countX has unexpected size % instead of 4", it.type.runtime_size);
                case "countZ";
                    assert(it.offset_in_bytes == 32, "b3HeightFieldDef.countZ has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldDef.countZ has unexpected size % instead of 4", it.type.runtime_size);
                case "globalMinimumHeight";
                    assert(it.offset_in_bytes == 36, "b3HeightFieldDef.globalMinimumHeight has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldDef.globalMinimumHeight has unexpected size % instead of 4", it.type.runtime_size);
                case "globalMaximumHeight";
                    assert(it.offset_in_bytes == 40, "b3HeightFieldDef.globalMaximumHeight has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldDef.globalMaximumHeight has unexpected size % instead of 4", it.type.runtime_size);
                case "clockwiseWinding";
                    assert(it.offset_in_bytes == 44, "b3HeightFieldDef.clockwiseWinding has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3HeightFieldDef.clockwiseWinding has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3HeightFieldDef) == 48, "b3HeightFieldDef has size % instead of 48", size_of(b3HeightFieldDef));
    }

    {
        info := type_info(b3HeightFieldData);
        for info.members {
            if it.name == {
                case "version";
                    assert(it.offset_in_bytes == 0, "b3HeightFieldData.version has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3HeightFieldData.version has unexpected size % instead of 8", it.type.runtime_size);
                case "hash";
                    assert(it.offset_in_bytes == 8, "b3HeightFieldData.hash has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3HeightFieldData.hash has unexpected size % instead of 8", it.type.runtime_size);
                case "byteCount";
                    assert(it.offset_in_bytes == 16, "b3HeightFieldData.byteCount has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.byteCount has unexpected size % instead of 4", it.type.runtime_size);
                case "aabb";
                    assert(it.offset_in_bytes == 20, "b3HeightFieldData.aabb has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3HeightFieldData.aabb has unexpected size % instead of 24", it.type.runtime_size);
                case "minHeight";
                    assert(it.offset_in_bytes == 44, "b3HeightFieldData.minHeight has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.minHeight has unexpected size % instead of 4", it.type.runtime_size);
                case "maxHeight";
                    assert(it.offset_in_bytes == 48, "b3HeightFieldData.maxHeight has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.maxHeight has unexpected size % instead of 4", it.type.runtime_size);
                case "heightScale";
                    assert(it.offset_in_bytes == 52, "b3HeightFieldData.heightScale has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.heightScale has unexpected size % instead of 4", it.type.runtime_size);
                case "scale";
                    assert(it.offset_in_bytes == 56, "b3HeightFieldData.scale has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3HeightFieldData.scale has unexpected size % instead of 12", it.type.runtime_size);
                case "columnCount";
                    assert(it.offset_in_bytes == 68, "b3HeightFieldData.columnCount has unexpected offset % instead of 68", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.columnCount has unexpected size % instead of 4", it.type.runtime_size);
                case "rowCount";
                    assert(it.offset_in_bytes == 72, "b3HeightFieldData.rowCount has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.rowCount has unexpected size % instead of 4", it.type.runtime_size);
                case "heightsOffset";
                    assert(it.offset_in_bytes == 76, "b3HeightFieldData.heightsOffset has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.heightsOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "materialOffset";
                    assert(it.offset_in_bytes == 80, "b3HeightFieldData.materialOffset has unexpected offset % instead of 80", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.materialOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "flagsOffset";
                    assert(it.offset_in_bytes == 84, "b3HeightFieldData.flagsOffset has unexpected offset % instead of 84", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3HeightFieldData.flagsOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "clockwise";
                    assert(it.offset_in_bytes == 88, "b3HeightFieldData.clockwise has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3HeightFieldData.clockwise has unexpected size % instead of 1", it.type.runtime_size);
                case "padding";
                    assert(it.offset_in_bytes == 89, "b3HeightFieldData.padding has unexpected offset % instead of 89", it.offset_in_bytes);
                    assert(it.type.runtime_size == 7, "b3HeightFieldData.padding has unexpected size % instead of 7", it.type.runtime_size);
            }
        }
        assert(size_of(b3HeightFieldData) == 96, "b3HeightFieldData has size % instead of 96", size_of(b3HeightFieldData));
    }

    {
        info := type_info(b3CompoundCapsuleDef);
        for info.members {
            if it.name == {
                case "capsule";
                    assert(it.offset_in_bytes == 0, "b3CompoundCapsuleDef.capsule has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3CompoundCapsuleDef.capsule has unexpected size % instead of 28", it.type.runtime_size);
                case "material";
                    assert(it.offset_in_bytes == 32, "b3CompoundCapsuleDef.material has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "b3CompoundCapsuleDef.material has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundCapsuleDef) == 72, "b3CompoundCapsuleDef has size % instead of 72", size_of(b3CompoundCapsuleDef));
    }

    {
        info := type_info(b3CompoundHullDef);
        for info.members {
            if it.name == {
                case "hull";
                    assert(it.offset_in_bytes == 0, "b3CompoundHullDef.hull has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundHullDef.hull has unexpected size % instead of 8", it.type.runtime_size);
                case "transform";
                    assert(it.offset_in_bytes == 8, "b3CompoundHullDef.transform has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3CompoundHullDef.transform has unexpected size % instead of 28", it.type.runtime_size);
                case "material";
                    assert(it.offset_in_bytes == 40, "b3CompoundHullDef.material has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "b3CompoundHullDef.material has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundHullDef) == 80, "b3CompoundHullDef has size % instead of 80", size_of(b3CompoundHullDef));
    }

    {
        info := type_info(b3CompoundMeshDef);
        for info.members {
            if it.name == {
                case "meshData";
                    assert(it.offset_in_bytes == 0, "b3CompoundMeshDef.meshData has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundMeshDef.meshData has unexpected size % instead of 8", it.type.runtime_size);
                case "transform";
                    assert(it.offset_in_bytes == 8, "b3CompoundMeshDef.transform has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3CompoundMeshDef.transform has unexpected size % instead of 28", it.type.runtime_size);
                case "scale";
                    assert(it.offset_in_bytes == 36, "b3CompoundMeshDef.scale has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3CompoundMeshDef.scale has unexpected size % instead of 12", it.type.runtime_size);
                case "materials";
                    assert(it.offset_in_bytes == 48, "b3CompoundMeshDef.materials has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundMeshDef.materials has unexpected size % instead of 8", it.type.runtime_size);
                case "materialCount";
                    assert(it.offset_in_bytes == 56, "b3CompoundMeshDef.materialCount has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundMeshDef.materialCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundMeshDef) == 64, "b3CompoundMeshDef has size % instead of 64", size_of(b3CompoundMeshDef));
    }

    {
        info := type_info(b3CompoundSphereDef);
        for info.members {
            if it.name == {
                case "sphere";
                    assert(it.offset_in_bytes == 0, "b3CompoundSphereDef.sphere has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3CompoundSphereDef.sphere has unexpected size % instead of 16", it.type.runtime_size);
                case "material";
                    assert(it.offset_in_bytes == 16, "b3CompoundSphereDef.material has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 40, "b3CompoundSphereDef.material has unexpected size % instead of 40", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundSphereDef) == 56, "b3CompoundSphereDef has size % instead of 56", size_of(b3CompoundSphereDef));
    }

    {
        info := type_info(b3CompoundDef);
        for info.members {
            if it.name == {
                case "capsules";
                    assert(it.offset_in_bytes == 0, "b3CompoundDef.capsules has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundDef.capsules has unexpected size % instead of 8", it.type.runtime_size);
                case "capsuleCount";
                    assert(it.offset_in_bytes == 8, "b3CompoundDef.capsuleCount has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundDef.capsuleCount has unexpected size % instead of 4", it.type.runtime_size);
                case "hulls";
                    assert(it.offset_in_bytes == 16, "b3CompoundDef.hulls has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundDef.hulls has unexpected size % instead of 8", it.type.runtime_size);
                case "hullCount";
                    assert(it.offset_in_bytes == 24, "b3CompoundDef.hullCount has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundDef.hullCount has unexpected size % instead of 4", it.type.runtime_size);
                case "meshes";
                    assert(it.offset_in_bytes == 32, "b3CompoundDef.meshes has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundDef.meshes has unexpected size % instead of 8", it.type.runtime_size);
                case "meshCount";
                    assert(it.offset_in_bytes == 40, "b3CompoundDef.meshCount has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundDef.meshCount has unexpected size % instead of 4", it.type.runtime_size);
                case "spheres";
                    assert(it.offset_in_bytes == 48, "b3CompoundDef.spheres has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundDef.spheres has unexpected size % instead of 8", it.type.runtime_size);
                case "sphereCount";
                    assert(it.offset_in_bytes == 56, "b3CompoundDef.sphereCount has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundDef.sphereCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundDef) == 64, "b3CompoundDef has size % instead of 64", size_of(b3CompoundDef));
    }

    {
        info := type_info(b3CompoundData);
        for info.members {
            if it.name == {
                case "version";
                    assert(it.offset_in_bytes == 0, "b3CompoundData.version has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundData.version has unexpected size % instead of 8", it.type.runtime_size);
                case "byteCount";
                    assert(it.offset_in_bytes == 8, "b3CompoundData.byteCount has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.byteCount has unexpected size % instead of 4", it.type.runtime_size);
                case "nodeOffset";
                    assert(it.offset_in_bytes == 12, "b3CompoundData.nodeOffset has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.nodeOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "tree";
                    assert(it.offset_in_bytes == 16, "b3CompoundData.tree has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 80, "b3CompoundData.tree has unexpected size % instead of 80", it.type.runtime_size);
                case "materialOffset";
                    assert(it.offset_in_bytes == 96, "b3CompoundData.materialOffset has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.materialOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "materialCount";
                    assert(it.offset_in_bytes == 100, "b3CompoundData.materialCount has unexpected offset % instead of 100", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.materialCount has unexpected size % instead of 4", it.type.runtime_size);
                case "capsuleOffset";
                    assert(it.offset_in_bytes == 104, "b3CompoundData.capsuleOffset has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.capsuleOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "capsuleCount";
                    assert(it.offset_in_bytes == 108, "b3CompoundData.capsuleCount has unexpected offset % instead of 108", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.capsuleCount has unexpected size % instead of 4", it.type.runtime_size);
                case "hullOffset";
                    assert(it.offset_in_bytes == 112, "b3CompoundData.hullOffset has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.hullOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "hullCount";
                    assert(it.offset_in_bytes == 116, "b3CompoundData.hullCount has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.hullCount has unexpected size % instead of 4", it.type.runtime_size);
                case "sharedHullCount";
                    assert(it.offset_in_bytes == 120, "b3CompoundData.sharedHullCount has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.sharedHullCount has unexpected size % instead of 4", it.type.runtime_size);
                case "meshOffset";
                    assert(it.offset_in_bytes == 124, "b3CompoundData.meshOffset has unexpected offset % instead of 124", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.meshOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "meshCount";
                    assert(it.offset_in_bytes == 128, "b3CompoundData.meshCount has unexpected offset % instead of 128", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.meshCount has unexpected size % instead of 4", it.type.runtime_size);
                case "sharedMeshCount";
                    assert(it.offset_in_bytes == 132, "b3CompoundData.sharedMeshCount has unexpected offset % instead of 132", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.sharedMeshCount has unexpected size % instead of 4", it.type.runtime_size);
                case "sphereOffset";
                    assert(it.offset_in_bytes == 136, "b3CompoundData.sphereOffset has unexpected offset % instead of 136", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.sphereOffset has unexpected size % instead of 4", it.type.runtime_size);
                case "sphereCount";
                    assert(it.offset_in_bytes == 140, "b3CompoundData.sphereCount has unexpected offset % instead of 140", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundData.sphereCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundData) == 144, "b3CompoundData has size % instead of 144", size_of(b3CompoundData));
    }

    {
        info := type_info(b3CompoundCapsule);
        for info.members {
            if it.name == {
                case "capsule";
                    assert(it.offset_in_bytes == 0, "b3CompoundCapsule.capsule has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3CompoundCapsule.capsule has unexpected size % instead of 28", it.type.runtime_size);
                case "materialIndex";
                    assert(it.offset_in_bytes == 28, "b3CompoundCapsule.materialIndex has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundCapsule.materialIndex has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundCapsule) == 32, "b3CompoundCapsule has size % instead of 32", size_of(b3CompoundCapsule));
    }

    {
        info := type_info(b3CompoundHull);
        for info.members {
            if it.name == {
                case "hull";
                    assert(it.offset_in_bytes == 0, "b3CompoundHull.hull has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundHull.hull has unexpected size % instead of 8", it.type.runtime_size);
                case "transform";
                    assert(it.offset_in_bytes == 8, "b3CompoundHull.transform has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3CompoundHull.transform has unexpected size % instead of 28", it.type.runtime_size);
                case "materialIndex";
                    assert(it.offset_in_bytes == 36, "b3CompoundHull.materialIndex has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundHull.materialIndex has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundHull) == 40, "b3CompoundHull has size % instead of 40", size_of(b3CompoundHull));
    }

    {
        info := type_info(b3CompoundMesh);
        for info.members {
            if it.name == {
                case "meshData";
                    assert(it.offset_in_bytes == 0, "b3CompoundMesh.meshData has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3CompoundMesh.meshData has unexpected size % instead of 8", it.type.runtime_size);
                case "transform";
                    assert(it.offset_in_bytes == 8, "b3CompoundMesh.transform has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 28, "b3CompoundMesh.transform has unexpected size % instead of 28", it.type.runtime_size);
                case "scale";
                    assert(it.offset_in_bytes == 36, "b3CompoundMesh.scale has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3CompoundMesh.scale has unexpected size % instead of 12", it.type.runtime_size);
                case "materialIndices";
                    assert(it.offset_in_bytes == 48, "b3CompoundMesh.materialIndices has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3CompoundMesh.materialIndices has unexpected size % instead of 16", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundMesh) == 64, "b3CompoundMesh has size % instead of 64", size_of(b3CompoundMesh));
    }

    {
        info := type_info(b3CompoundSphere);
        for info.members {
            if it.name == {
                case "sphere";
                    assert(it.offset_in_bytes == 0, "b3CompoundSphere.sphere has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 16, "b3CompoundSphere.sphere has unexpected size % instead of 16", it.type.runtime_size);
                case "materialIndex";
                    assert(it.offset_in_bytes == 16, "b3CompoundSphere.materialIndex has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3CompoundSphere.materialIndex has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3CompoundSphere) == 20, "b3CompoundSphere has size % instead of 20", size_of(b3CompoundSphere));
    }

    {
        info := type_info(b3ManifoldPoint);
        for info.members {
            if it.name == {
                case "anchorA";
                    assert(it.offset_in_bytes == 0, "b3ManifoldPoint.anchorA has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ManifoldPoint.anchorA has unexpected size % instead of 12", it.type.runtime_size);
                case "anchorB";
                    assert(it.offset_in_bytes == 12, "b3ManifoldPoint.anchorB has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3ManifoldPoint.anchorB has unexpected size % instead of 12", it.type.runtime_size);
                case "separation";
                    assert(it.offset_in_bytes == 24, "b3ManifoldPoint.separation has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.separation has unexpected size % instead of 4", it.type.runtime_size);
                case "baseSeparation";
                    assert(it.offset_in_bytes == 28, "b3ManifoldPoint.baseSeparation has unexpected offset % instead of 28", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.baseSeparation has unexpected size % instead of 4", it.type.runtime_size);
                case "friction";
                    assert(it.offset_in_bytes == 32, "b3ManifoldPoint.friction has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.friction has unexpected size % instead of 4", it.type.runtime_size);
                case "restitution";
                    assert(it.offset_in_bytes == 36, "b3ManifoldPoint.restitution has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.restitution has unexpected size % instead of 4", it.type.runtime_size);
                case "maxNormalImpulse";
                    assert(it.offset_in_bytes == 40, "b3ManifoldPoint.maxNormalImpulse has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.maxNormalImpulse has unexpected size % instead of 4", it.type.runtime_size);
                case "normalImpulse";
                    assert(it.offset_in_bytes == 44, "b3ManifoldPoint.normalImpulse has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.normalImpulse has unexpected size % instead of 4", it.type.runtime_size);
                case "totalNormalImpulse";
                    assert(it.offset_in_bytes == 48, "b3ManifoldPoint.totalNormalImpulse has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.totalNormalImpulse has unexpected size % instead of 4", it.type.runtime_size);
                case "normalVelocity";
                    assert(it.offset_in_bytes == 52, "b3ManifoldPoint.normalVelocity has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.normalVelocity has unexpected size % instead of 4", it.type.runtime_size);
                case "featureId";
                    assert(it.offset_in_bytes == 56, "b3ManifoldPoint.featureId has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.featureId has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleIndex";
                    assert(it.offset_in_bytes == 60, "b3ManifoldPoint.triangleIndex has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3ManifoldPoint.triangleIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "persisted";
                    assert(it.offset_in_bytes == 64, "b3ManifoldPoint.persisted has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ManifoldPoint.persisted has unexpected size % instead of 1", it.type.runtime_size);
                case "enabled";
                    assert(it.offset_in_bytes == 65, "b3ManifoldPoint.enabled has unexpected offset % instead of 65", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3ManifoldPoint.enabled has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3ManifoldPoint) == 68, "b3ManifoldPoint has size % instead of 68", size_of(b3ManifoldPoint));
    }

    {
        info := type_info(b3Manifold);
        for info.members {
            if it.name == {
                case "points";
                    assert(it.offset_in_bytes == 0, "b3Manifold.points has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 272, "b3Manifold.points has unexpected size % instead of 272", it.type.runtime_size);
                case "normal";
                    assert(it.offset_in_bytes == 272, "b3Manifold.normal has unexpected offset % instead of 272", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Manifold.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "twistImpulse";
                    assert(it.offset_in_bytes == 284, "b3Manifold.twistImpulse has unexpected offset % instead of 284", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Manifold.twistImpulse has unexpected size % instead of 4", it.type.runtime_size);
                case "frictionImpulse";
                    assert(it.offset_in_bytes == 288, "b3Manifold.frictionImpulse has unexpected offset % instead of 288", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Manifold.frictionImpulse has unexpected size % instead of 12", it.type.runtime_size);
                case "rollingImpulse";
                    assert(it.offset_in_bytes == 300, "b3Manifold.rollingImpulse has unexpected offset % instead of 300", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3Manifold.rollingImpulse has unexpected size % instead of 12", it.type.runtime_size);
                case "pointCount";
                    assert(it.offset_in_bytes == 312, "b3Manifold.pointCount has unexpected offset % instead of 312", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3Manifold.pointCount has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3Manifold) == 316, "b3Manifold has size % instead of 316", size_of(b3Manifold));
    }

    {
        info := type_info(b3SATCache);
        for info.members {
            if it.name == {
                case "separation";
                    assert(it.offset_in_bytes == 0, "b3SATCache.separation has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3SATCache.separation has unexpected size % instead of 4", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 4, "b3SATCache.type has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3SATCache.type has unexpected size % instead of 1", it.type.runtime_size);
                case "indexA";
                    assert(it.offset_in_bytes == 5, "b3SATCache.indexA has unexpected offset % instead of 5", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3SATCache.indexA has unexpected size % instead of 1", it.type.runtime_size);
                case "indexB";
                    assert(it.offset_in_bytes == 6, "b3SATCache.indexB has unexpected offset % instead of 6", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3SATCache.indexB has unexpected size % instead of 1", it.type.runtime_size);
                case "hit";
                    assert(it.offset_in_bytes == 7, "b3SATCache.hit has unexpected offset % instead of 7", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3SATCache.hit has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3SATCache) == 8, "b3SATCache has size % instead of 8", size_of(b3SATCache));
    }

    {
        info := type_info(b3FeaturePair);
        for info.members {
            if it.name == {
                case "owner1";
                    assert(it.offset_in_bytes == 0, "b3FeaturePair.owner1 has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3FeaturePair.owner1 has unexpected size % instead of 1", it.type.runtime_size);
                case "index1";
                    assert(it.offset_in_bytes == 1, "b3FeaturePair.index1 has unexpected offset % instead of 1", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3FeaturePair.index1 has unexpected size % instead of 1", it.type.runtime_size);
                case "owner2";
                    assert(it.offset_in_bytes == 2, "b3FeaturePair.owner2 has unexpected offset % instead of 2", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3FeaturePair.owner2 has unexpected size % instead of 1", it.type.runtime_size);
                case "index2";
                    assert(it.offset_in_bytes == 3, "b3FeaturePair.index2 has unexpected offset % instead of 3", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3FeaturePair.index2 has unexpected size % instead of 1", it.type.runtime_size);
            }
        }
        assert(size_of(b3FeaturePair) == 4, "b3FeaturePair has size % instead of 4", size_of(b3FeaturePair));
    }

    {
        info := type_info(b3LocalManifoldPoint);
        for info.members {
            if it.name == {
                case "point";
                    assert(it.offset_in_bytes == 0, "b3LocalManifoldPoint.point has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3LocalManifoldPoint.point has unexpected size % instead of 12", it.type.runtime_size);
                case "separation";
                    assert(it.offset_in_bytes == 12, "b3LocalManifoldPoint.separation has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifoldPoint.separation has unexpected size % instead of 4", it.type.runtime_size);
                case "pair";
                    assert(it.offset_in_bytes == 16, "b3LocalManifoldPoint.pair has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifoldPoint.pair has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleIndex";
                    assert(it.offset_in_bytes == 20, "b3LocalManifoldPoint.triangleIndex has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifoldPoint.triangleIndex has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3LocalManifoldPoint) == 24, "b3LocalManifoldPoint has size % instead of 24", size_of(b3LocalManifoldPoint));
    }

    {
        info := type_info(b3LocalManifold);
        for info.members {
            if it.name == {
                case "normal";
                    assert(it.offset_in_bytes == 0, "b3LocalManifold.normal has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3LocalManifold.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "triangleNormal";
                    assert(it.offset_in_bytes == 12, "b3LocalManifold.triangleNormal has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3LocalManifold.triangleNormal has unexpected size % instead of 12", it.type.runtime_size);
                case "points";
                    assert(it.offset_in_bytes == 24, "b3LocalManifold.points has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3LocalManifold.points has unexpected size % instead of 8", it.type.runtime_size);
                case "pointCount";
                    assert(it.offset_in_bytes == 32, "b3LocalManifold.pointCount has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifold.pointCount has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleIndex";
                    assert(it.offset_in_bytes == 36, "b3LocalManifold.triangleIndex has unexpected offset % instead of 36", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifold.triangleIndex has unexpected size % instead of 4", it.type.runtime_size);
                case "i1";
                    assert(it.offset_in_bytes == 40, "b3LocalManifold.i1 has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifold.i1 has unexpected size % instead of 4", it.type.runtime_size);
                case "i2";
                    assert(it.offset_in_bytes == 44, "b3LocalManifold.i2 has unexpected offset % instead of 44", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifold.i2 has unexpected size % instead of 4", it.type.runtime_size);
                case "i3";
                    assert(it.offset_in_bytes == 48, "b3LocalManifold.i3 has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifold.i3 has unexpected size % instead of 4", it.type.runtime_size);
                case "squaredDistance";
                    assert(it.offset_in_bytes == 52, "b3LocalManifold.squaredDistance has unexpected offset % instead of 52", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifold.squaredDistance has unexpected size % instead of 4", it.type.runtime_size);
                case "feature";
                    assert(it.offset_in_bytes == 56, "b3LocalManifold.feature has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifold.feature has unexpected size % instead of 4", it.type.runtime_size);
                case "triangleFlags";
                    assert(it.offset_in_bytes == 60, "b3LocalManifold.triangleFlags has unexpected offset % instead of 60", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3LocalManifold.triangleFlags has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3LocalManifold) == 64, "b3LocalManifold has size % instead of 64", size_of(b3LocalManifold));
    }

    {
        info := type_info(b3DebugShape);
        for info.members {
            if it.name == {
                case "shapeId";
                    assert(it.offset_in_bytes == 0, "b3DebugShape.shapeId has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugShape.shapeId has unexpected size % instead of 8", it.type.runtime_size);
                case "type";
                    assert(it.offset_in_bytes == 8, "b3DebugShape.type has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DebugShape.type has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3DebugShape) == 24, "b3DebugShape has size % instead of 24", size_of(b3DebugShape));
    }

    {
        info := type_info(b3DebugDraw);
        for info.members {
            if it.name == {
                case "DrawShapeFcn";
                    assert(it.offset_in_bytes == 0, "b3DebugDraw.DrawShapeFcn has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawShapeFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "DrawSegmentFcn";
                    assert(it.offset_in_bytes == 8, "b3DebugDraw.DrawSegmentFcn has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawSegmentFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "DrawTransformFcn";
                    assert(it.offset_in_bytes == 16, "b3DebugDraw.DrawTransformFcn has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawTransformFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "DrawPointFcn";
                    assert(it.offset_in_bytes == 24, "b3DebugDraw.DrawPointFcn has unexpected offset % instead of 24", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawPointFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "DrawSphereFcn";
                    assert(it.offset_in_bytes == 32, "b3DebugDraw.DrawSphereFcn has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawSphereFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "DrawCapsuleFcn";
                    assert(it.offset_in_bytes == 40, "b3DebugDraw.DrawCapsuleFcn has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawCapsuleFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "DrawBoundsFcn";
                    assert(it.offset_in_bytes == 48, "b3DebugDraw.DrawBoundsFcn has unexpected offset % instead of 48", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawBoundsFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "DrawBoxFcn";
                    assert(it.offset_in_bytes == 56, "b3DebugDraw.DrawBoxFcn has unexpected offset % instead of 56", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawBoxFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "DrawStringFcn";
                    assert(it.offset_in_bytes == 64, "b3DebugDraw.DrawStringFcn has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw.DrawStringFcn has unexpected size % instead of 8", it.type.runtime_size);
                case "drawingBounds";
                    assert(it.offset_in_bytes == 72, "b3DebugDraw.drawingBounds has unexpected offset % instead of 72", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3DebugDraw.drawingBounds has unexpected size % instead of 24", it.type.runtime_size);
                case "forceScale";
                    assert(it.offset_in_bytes == 96, "b3DebugDraw.forceScale has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DebugDraw.forceScale has unexpected size % instead of 4", it.type.runtime_size);
                case "jointScale";
                    assert(it.offset_in_bytes == 100, "b3DebugDraw.jointScale has unexpected offset % instead of 100", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3DebugDraw.jointScale has unexpected size % instead of 4", it.type.runtime_size);
                case "drawShapes";
                    assert(it.offset_in_bytes == 104, "b3DebugDraw.drawShapes has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawShapes has unexpected size % instead of 1", it.type.runtime_size);
                case "drawJoints";
                    assert(it.offset_in_bytes == 105, "b3DebugDraw.drawJoints has unexpected offset % instead of 105", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawJoints has unexpected size % instead of 1", it.type.runtime_size);
                case "drawJointExtras";
                    assert(it.offset_in_bytes == 106, "b3DebugDraw.drawJointExtras has unexpected offset % instead of 106", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawJointExtras has unexpected size % instead of 1", it.type.runtime_size);
                case "drawBounds";
                    assert(it.offset_in_bytes == 107, "b3DebugDraw.drawBounds has unexpected offset % instead of 107", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawBounds has unexpected size % instead of 1", it.type.runtime_size);
                case "drawMass";
                    assert(it.offset_in_bytes == 108, "b3DebugDraw.drawMass has unexpected offset % instead of 108", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawMass has unexpected size % instead of 1", it.type.runtime_size);
                case "drawSleep";
                    assert(it.offset_in_bytes == 109, "b3DebugDraw.drawSleep has unexpected offset % instead of 109", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawSleep has unexpected size % instead of 1", it.type.runtime_size);
                case "drawBodyNames";
                    assert(it.offset_in_bytes == 110, "b3DebugDraw.drawBodyNames has unexpected offset % instead of 110", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawBodyNames has unexpected size % instead of 1", it.type.runtime_size);
                case "drawContacts";
                    assert(it.offset_in_bytes == 111, "b3DebugDraw.drawContacts has unexpected offset % instead of 111", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawContacts has unexpected size % instead of 1", it.type.runtime_size);
                case "drawAnchorA";
                    assert(it.offset_in_bytes == 112, "b3DebugDraw.drawAnchorA has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawAnchorA has unexpected size % instead of 1", it.type.runtime_size);
                case "drawGraphColors";
                    assert(it.offset_in_bytes == 113, "b3DebugDraw.drawGraphColors has unexpected offset % instead of 113", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawGraphColors has unexpected size % instead of 1", it.type.runtime_size);
                case "drawContactFeatures";
                    assert(it.offset_in_bytes == 114, "b3DebugDraw.drawContactFeatures has unexpected offset % instead of 114", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawContactFeatures has unexpected size % instead of 1", it.type.runtime_size);
                case "drawContactNormals";
                    assert(it.offset_in_bytes == 115, "b3DebugDraw.drawContactNormals has unexpected offset % instead of 115", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawContactNormals has unexpected size % instead of 1", it.type.runtime_size);
                case "drawContactForces";
                    assert(it.offset_in_bytes == 116, "b3DebugDraw.drawContactForces has unexpected offset % instead of 116", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawContactForces has unexpected size % instead of 1", it.type.runtime_size);
                case "drawIslands";
                    assert(it.offset_in_bytes == 117, "b3DebugDraw.drawIslands has unexpected offset % instead of 117", it.offset_in_bytes);
                    assert(it.type.runtime_size == 1, "b3DebugDraw.drawIslands has unexpected size % instead of 1", it.type.runtime_size);
                case "_context";
                    assert(it.offset_in_bytes == 120, "b3DebugDraw._context has unexpected offset % instead of 120", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3DebugDraw._context has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(b3DebugDraw) == 128, "b3DebugDraw has size % instead of 128", size_of(b3DebugDraw));
    }

    {
        info := type_info(b3RecPlayerInfo);
        for info.members {
            if it.name == {
                case "frameCount";
                    assert(it.offset_in_bytes == 0, "b3RecPlayerInfo.frameCount has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RecPlayerInfo.frameCount has unexpected size % instead of 4", it.type.runtime_size);
                case "workerCount";
                    assert(it.offset_in_bytes == 4, "b3RecPlayerInfo.workerCount has unexpected offset % instead of 4", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RecPlayerInfo.workerCount has unexpected size % instead of 4", it.type.runtime_size);
                case "timeStep";
                    assert(it.offset_in_bytes == 8, "b3RecPlayerInfo.timeStep has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RecPlayerInfo.timeStep has unexpected size % instead of 4", it.type.runtime_size);
                case "subStepCount";
                    assert(it.offset_in_bytes == 12, "b3RecPlayerInfo.subStepCount has unexpected offset % instead of 12", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RecPlayerInfo.subStepCount has unexpected size % instead of 4", it.type.runtime_size);
                case "lengthScale";
                    assert(it.offset_in_bytes == 16, "b3RecPlayerInfo.lengthScale has unexpected offset % instead of 16", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RecPlayerInfo.lengthScale has unexpected size % instead of 4", it.type.runtime_size);
                case "bounds";
                    assert(it.offset_in_bytes == 20, "b3RecPlayerInfo.bounds has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3RecPlayerInfo.bounds has unexpected size % instead of 24", it.type.runtime_size);
            }
        }
        assert(size_of(b3RecPlayerInfo) == 44, "b3RecPlayerInfo has size % instead of 44", size_of(b3RecPlayerInfo));
    }

    {
        info := type_info(b3RecQueryInfo);
        for info.members {
            if it.name == {
                case "type";
                    assert(it.offset_in_bytes == 0, "b3RecQueryInfo.type has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RecQueryInfo.type has unexpected size % instead of 4", it.type.runtime_size);
                case "filter";
                    assert(it.offset_in_bytes == 8, "b3RecQueryInfo.filter has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 32, "b3RecQueryInfo.filter has unexpected size % instead of 32", it.type.runtime_size);
                case "aabb";
                    assert(it.offset_in_bytes == 40, "b3RecQueryInfo.aabb has unexpected offset % instead of 40", it.offset_in_bytes);
                    assert(it.type.runtime_size == 24, "b3RecQueryInfo.aabb has unexpected size % instead of 24", it.type.runtime_size);
                case "origin";
                    assert(it.offset_in_bytes == 64, "b3RecQueryInfo.origin has unexpected offset % instead of 64", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3RecQueryInfo.origin has unexpected size % instead of 12", it.type.runtime_size);
                case "translation";
                    assert(it.offset_in_bytes == 76, "b3RecQueryInfo.translation has unexpected offset % instead of 76", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3RecQueryInfo.translation has unexpected size % instead of 12", it.type.runtime_size);
                case "hitCount";
                    assert(it.offset_in_bytes == 88, "b3RecQueryInfo.hitCount has unexpected offset % instead of 88", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RecQueryInfo.hitCount has unexpected size % instead of 4", it.type.runtime_size);
                case "key";
                    assert(it.offset_in_bytes == 96, "b3RecQueryInfo.key has unexpected offset % instead of 96", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3RecQueryInfo.key has unexpected size % instead of 8", it.type.runtime_size);
                case "id";
                    assert(it.offset_in_bytes == 104, "b3RecQueryInfo.id has unexpected offset % instead of 104", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3RecQueryInfo.id has unexpected size % instead of 8", it.type.runtime_size);
                case "name";
                    assert(it.offset_in_bytes == 112, "b3RecQueryInfo.name has unexpected offset % instead of 112", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3RecQueryInfo.name has unexpected size % instead of 8", it.type.runtime_size);
            }
        }
        assert(size_of(b3RecQueryInfo) == 120, "b3RecQueryInfo has size % instead of 120", size_of(b3RecQueryInfo));
    }

    {
        info := type_info(b3RecQueryHit);
        for info.members {
            if it.name == {
                case "shape";
                    assert(it.offset_in_bytes == 0, "b3RecQueryHit.shape has unexpected offset % instead of 0", it.offset_in_bytes);
                    assert(it.type.runtime_size == 8, "b3RecQueryHit.shape has unexpected size % instead of 8", it.type.runtime_size);
                case "point";
                    assert(it.offset_in_bytes == 8, "b3RecQueryHit.point has unexpected offset % instead of 8", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3RecQueryHit.point has unexpected size % instead of 12", it.type.runtime_size);
                case "normal";
                    assert(it.offset_in_bytes == 20, "b3RecQueryHit.normal has unexpected offset % instead of 20", it.offset_in_bytes);
                    assert(it.type.runtime_size == 12, "b3RecQueryHit.normal has unexpected size % instead of 12", it.type.runtime_size);
                case "fraction";
                    assert(it.offset_in_bytes == 32, "b3RecQueryHit.fraction has unexpected offset % instead of 32", it.offset_in_bytes);
                    assert(it.type.runtime_size == 4, "b3RecQueryHit.fraction has unexpected size % instead of 4", it.type.runtime_size);
            }
        }
        assert(size_of(b3RecQueryHit) == 36, "b3RecQueryHit has size % instead of 36", size_of(b3RecQueryHit));
    }
}


#if OS == .MACOS {
    box3d :: #library "bin/macos/libbox3d";
} else #if OS == .LINUX {
    box3d :: #library "bin/linux/libbox3d";
} else {
    #assert false "Unsupported JaiBox3D OS.\n";
}

// The C anonymous union is 32 bytes with 8-byte alignment because b3Mesh is
// 8-byte aligned while b3Capsule is the 28-byte largest member. Jai overlays
// need explicit storage to preserve both facts.
b3ChildShape :: struct {
    storage: [32] u8 #align 8;
    #overlay (storage) capsule: b3Capsule;
    #overlay (storage) hull: *b3HullData;
    #overlay (storage) mesh: b3Mesh;
    #overlay (storage) sphere: b3Sphere;

    transform: b3Transform;
    materialIndices: [4] s32;
    type: b3ShapeType;
}

#run {
    info := type_info(b3ChildShape);
    for info.members {
        if it.name == {
            case "transform";
                assert(it.offset_in_bytes == 32, "b3ChildShape.transform has unexpected offset % instead of 32", it.offset_in_bytes);
            case "materialIndices";
                assert(it.offset_in_bytes == 60, "b3ChildShape.materialIndices has unexpected offset % instead of 60", it.offset_in_bytes);
            case "type";
                assert(it.offset_in_bytes == 76, "b3ChildShape.type has unexpected offset % instead of 76", it.offset_in_bytes);
        }
    }
    assert(size_of(b3ChildShape) == 80, "b3ChildShape has size % instead of 80", size_of(b3ChildShape));
}
