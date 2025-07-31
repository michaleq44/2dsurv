cmake_minimum_required(VERSION 3.25)
project(2dsurv)

set(CMAKE_CXX_STANDARD 17)

# k

add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/shaders/vert.spv
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/shaders/frag.spv
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shader.vert
        DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shader.frag
        COMMAND rm -rf ${CMAKE_CURRENT_BINARY_DIR}/shaders/*
        COMMAND glslc ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shader.vert -o ${CMAKE_CURRENT_BINARY_DIR}/shaders/vert.spv
        COMMAND glslc ${CMAKE_CURRENT_SOURCE_DIR}/shaders/shader.vert -o ${CMAKE_CURRENT_BINARY_DIR}/shaders/frag.spv
)

add_custom_target(shaders ALL
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/shaders/vert.spv
    DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/shaders/frag.spv)

include_directories(inc)

if(${CMAKE_BUILD_TYPE} EQUAL Release)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2")
    if (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mwindows")
    endif()
elseif(${CMAKE_BUILD_TYPE} EQUAL Debug)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g")
endif()

if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    link_libraries(vulkan-1 glfw3)
else()
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(GLFW3 REQUIRED glfw3)
    pkg_check_modules(VULKAN REQUIRED vulkan)
    pkg_check_modules(X11 REQUIRED x11)
    pkg_check_modules(XXF86VM REQUIRED xxf86vm)
    pkg_check_modules(XRANDR REQUIRED xrandr)
    pkg_check_modules(XI REQUIRED xi)
    link_libraries(${GLFW3_LIBRARIES} ${VULKAN_LIBRARIES} ${X11_LIBRARIES} ${XXF86VM_LIBRARIES} ${XRANDR_LIBRARIES} ${XI_LIBRARIES} dl pthread)
endif()


add_executable(2dsurv src/main.cpp
        inc/main.hpp
        src/app.cpp
        inc/app.hpp
        src/vlk.cpp
        inc/vlk.hpp
        src/appprivate.cpp
        inc/appprivate.hpp)
