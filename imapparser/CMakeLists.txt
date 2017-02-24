cmake_minimum_required(VERSION 2.8)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_C_COMPILER gcc)


project(imapparser)
add_executable(${PROJECT_NAME} "main.cpp" "imapparser.cpp")


set(CMAKE_CXX_STANDARD 11) # C++11...
set(CMAKE_CXX_STANDARD_REQUIRED ON) #...is required...
#set(CMAKE_CXX_EXTENSIONS OFF) #...without compiler extensions like gnu++11
#target_compile_features(${PROJECT_NAME} PRIVATE cxx_range_for)

add_definitions(-Wall)
add_definitions(-W)
