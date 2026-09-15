#import "Bindings_Generator";
#import "Basic";
#import "Compiler";
#import "File";
#import "String";
#import "BuildCpp";
#import "File_Utilities";

#if OS != .MACOS && OS != .LINUX {
    #assert false "JaiBox3D binding generation currently supports macOS and Linux.\n";
}

#run {
    set_build_options_dc(.{do_output = false});
    set_working_directory(#filepath);

    using opts: Generate_Bindings_Options;

    #if OS == .MACOS {
        array_add(*library_search_paths, "bin/macos");
    } else #if OS == .LINUX {
        array_add(*library_search_paths, "bin/linux");
    }
    array_add(*libraries, Library.{"libbox3d", "box3d"});
    generate_library_declarations = false;

    array_add(*include_paths, "../box3d/include");
    array_add(*source_files, "../box3d/include/box3d/box3d.h");

    array_add(*extra_clang_arguments, "-std=gnu17");
    array_add(*extra_clang_arguments, "-DNDEBUG");
    array_add(*extra_clang_arguments, "-x", "c");

    generate_compile_time_struct_checks = true;

    opts.visitor = (decl: *Declaration, parent_decl: *Declaration) -> Declaration_Visit_Result {
        if decl.kind == .STRUCT && decl.name == "b3ChildShape" {
            decl.decl_flags |= .OMIT_FROM_OUTPUT;
            return .STOP;
        }

        return .RECURSE;
    };

    footer = #string JAI

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
    JAI

    generate_bindings(opts, "module.jai");
}
