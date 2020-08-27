function(windeployqt target)
    find_package(Qt5Core REQUIRED)

    find_program(WINDEPLOYQT_EXECUTABLE windeployqt HINT ${_qt_bin_dir})

    if (NOT WINDEPLOYQT_EXECUTABLE)
        message(FATAL_ERROR "windeployqt not found")
    endif()

    add_custom_command(TARGET ${targer} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E
            env PATH="${_qt_bin_dir}" "${WINDEPLOYQT_EXECUTABLE}"
                --verbose 0
                --no-compiler-runtime
                --no-translations
                --no-angle
                --no-opengl-sw
                --dir "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/windeployqt"
                "$<TARGET_FILE:${target}>"
        COMMENT "Deploying Qt . . ."
    )

    if (MINGW)
        get_filename_component(mingw_path ${CMAKE_CXX_COMPILER} PATH)
        set(CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS ${mingw_path}/libgcc_s_seh-1.dll ${mingw_path}/libstdc++-6.dll)
    endif()

    include(InstallRequiredSystemLibraries)
endfunction()
