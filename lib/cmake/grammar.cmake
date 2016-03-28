cmake_minimum_required(VERSION 2.8)
project(grammar)


function(show_buildin_var)
    message(STATUS "PROJECT_NAME=${PROJECT_NAME}")
endfunction()

function(show_os_type)
    message(STATUS "CMAKE_SYSTEM=${CMAKE_SYSTEM}")
    if (APPLE)
        message(STATUS "CURRENT OS IS: APPLE")
    elseif (UNIX)
        message(STATUS "CURRENT OS IS: UNIX")
    elseif (WIN32)
        message(STATUS "CURRENT OS IS: Windows")
    endif()
endfunction()


show_buildin_var()
show_os_type()
