cmake_minimum_required(VERSION 3.24 FATAL_ERROR)
project(dune-core CXX)

# allow dune to see imported targets across modules
set(CMAKE_FIND_PACKAGE_TARGETS_GLOBAL ON)

enable_testing()

# include DUNE core modules in configuration order
include(FetchContent)
Set(FETCHCONTENT_QUIET FALSE)

# List of modules with syntax https://<prefix>/<module>@<branch>
set(modules
    https://gitlab.dune-project.org/core/dune-common
    https://gitlab.dune-project.org/core/dune-istl
    https://gitlab.dune-project.org/core/dune-geometry
    https://gitlab.dune-project.org/staging/dune-uggrid
    https://gitlab.dune-project.org/core/dune-grid
    https://gitlab.dune-project.org/core/dune-localfunctions
    https://gitlab.dune-project.org/staging/dune-typetree
    # https://gitlab.dune-project.org/staging/dune-functions
    # https://gitlab.dune-project.org/pdelab/dune-pdelab
)

foreach(module ${modules})
    # https://www.debuggex.com/r/H4kRw1G0YPyBFjfm
    string(REGEX MATCH "((git|ssh|http[s]?):(\/\/)?(([\./A-Za-z0-9_-]+)/(([A-Za-z0-9_-]+)(\.git)?)))[@]?([/A-Za-z0-9_-]+$)?" module_name "${module}")
    set(module_url ${CMAKE_MATCH_1})
    set(module_name ${CMAKE_MATCH_7})
    if(NOT ("${CMAKE_MATCH_9}" STREQUAL ""))
        set(module_branch ${CMAKE_MATCH_9})
    elseif(NOT ("${DEFAULT_BRANCH}" STREQUAL ""))
        set(module_branch ${DEFAULT_BRANCH})
    else()
        set(module_branch master)
    endif()
    FetchContent_Declare(
        ${module_name}
        GIT_REPOSITORY      ${module_url}
        UPDATE_COMMAND      ${CMAKE_COMMAND} -DBRANCH=${module_branch} -P ${CMAKE_CURRENT_SOURCE_DIR}/GitCheckout.cmake
        GIT_PROGRESS        TRUE
    )
    FetchContent_MakeAvailable(${module_name})
    # let 'find_package' know where configured projects can be found
    list(APPEND CMAKE_PREFIX_PATH ${${module_name}_BINARY_DIR})
endforeach()
