cmake_minimum_required(VERSION 3.24 FATAL_ERROR)
project(dune-core CXX)

# allow dune to see imported targets across modules
set(CMAKE_FIND_PACKAGE_TARGETS_GLOBAL ON)

# include DUNE core modules in configuration order
include(FetchContent)
Set(FETCHCONTENT_QUIET FALSE)

set(modules common istl geometry grid localfunctions)
foreach(module ${modules})
    if((${module} STREQUAL geometry) OR (${module} STREQUAL localfunctions))
        set(branch master)
    else()
        set(branch feature/support-msvc)
    endif()

    FetchContent_Declare(
        ${module}
        GIT_REPOSITORY      https://gitlab.dune-project.org/core/dune-${module}.git
        GIT_TAG             ${branch}
        GIT_PROGRESS        TRUE
        FIND_PACKAGE_ARGS   NAMES dune-${module}
    )
    FetchContent_MakeAvailable(${module})
    # let 'find_package' know where configured projects can be found
    list(APPEND CMAKE_PREFIX_PATH ${${module}_BINARY_DIR})
endforeach()
