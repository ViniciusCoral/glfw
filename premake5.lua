project "GLFW"
    kind "StaticLib"
    language "C"
    staticruntime "off"
    warnings "off"

    --targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    --objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    targetdir ("Binaries/" .. OutputDir .. "/%{prj.name}")
    objdir ("Binaries/Intermediates/" .. OutputDir .. "/%{prj.name}")

    files {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/glfw_config.h",
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        
        "src/null_init.c",
        "src/null_joystick.c",
        "src/null_monitor.c",
        "src/null_window.c",

        --"src/internal.h",
        "src/platform.c",
        "src/vulkan.c",
        "src/window.c"
    }

    filter "system:windows"
        --buildoptions { "-std-c11", "-lgdi32" }
        systemversion "latest"

        files {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_module.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wgl_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c"
        }

        defines {
            --"GLFW_USE_CONFIG_H",
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS",
        }

        -- links {
            -- "Dwmapi.lib"
        -- }

    --filter { "system:windows", "configurations:Release" }
    --    buildoptions "/MT"

    filter { "system:windows", "configurations:Debug-AS" }	
		runtime "Debug"
		symbols "on"
		sanitize { "Address" }
		flags { "NoRuntimeChecks", "NoIncrementalLink" }
    
    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "speed"
        -- symbols "off"
    
    filter "configurations:Dist"
        runtime "Release"
        optimize "speed"
        symbols "off"
        