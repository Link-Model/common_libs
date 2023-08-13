add_library(MCP2515 INTERFACE ${CMAKE_CURRENT_LIST_DIR}/lib/pico-mcp2515/include/mcp2515/mcp2515.cpp)

include_directories(${CMAKE_CURRENT_LIST_DIR}/lib/pico-mcp2515/include)

set(COMMON_LIBS MCP2515 hardware_spi)

set(ELF_FILE ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.elf)

message(STATUS ${ELF_FILE})

string(TOUPPER ${CMAKE_BUILD_TYPE} COMMON_BUILD_TYPE)
if(COMMON_BUILD_TYPE STREQUAL "DEBUG")
  add_custom_target(debug COMMAND ./debug "${ELF_FILE}" WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
endif()

add_custom_target(upload_swd COMMAND openocd -f interface/cmsis-dap.cfg -f target/rp2040.cfg -c "adapter speed 5000" -c "program '${ELF_FILE}' verify reset exit" DEPENDS ${PROJECT_NAME})
