function(windeployqt target)
    find_package(Qt5Core REQUIRED)

    find_program(WINDEPLOYQT_EXECUTABLE windeployqt HINT ${_qt_bin_dir})

    if (NOT WINDEPLOYQT_EXECUTABLE)
        message(FATAL_ERROR "windeployqt not found")
    endif()

    add_custom_command(TARGET ${target} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E
            env PATH="${_qt_bin_dir}" "${WINDEPLOYQT_EXECUTABLE}"
                --verbose 0
                --compiler-runtime
                --no-translations
                --no-angle
                --no-opengl-sw
                \"$<TARGET_FILE:${target}>\"
        COMMENT "Deploying Qt . . ."
    )
endfunction()
