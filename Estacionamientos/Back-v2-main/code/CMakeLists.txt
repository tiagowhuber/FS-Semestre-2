cmake_minimum_required(VERSION 3.10)

project(backend)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)

find_package(OpenCV REQUIRED)

include_directories(server)
include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(backend server/App.cxx server/Camera.cxx server/Detector.cxx server/Manager.cxx server/Scanner.cxx)
target_link_libraries(backend ${OpenCV_LIBS})