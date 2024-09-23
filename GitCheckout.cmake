# Checkout git tracked branch (if exists)

if (BRANCH)
  find_package(Git REQUIRED)

  execute_process(
    COMMAND ${GIT_EXECUTABLE} -C ${CMAKE_CURRENT_BINARY_DIR} checkout ${BRANCH}
    COMMAND_ECHO STDOUT
    ERROR_VARIABLE err)
endif()
