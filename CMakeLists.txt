cmake_minimum_required(VERSION 3.29)
project(HelloWorld LANGUAGES CXX)

add_library(hello)
target_sources(hello 
    PRIVATE
        hello/hello.cpp
    PUBLIC
        FILE_SET HEADERS FILES hello/hello.hpp
  )
  
target_compile_features(hello PRIVATE cxx_std_20)

add_executable(main)
target_sources(main PRIVATE main.cpp)
target_compile_features(main PRIVATE cxx_std_20)
target_link_libraries(main PRIVATE hello)

install(
    TARGETS hello main
    FILE_SET HEADERS
)

add_executable(tests)
target_sources(tests PRIVATE test.cpp)
target_compile_features(tests PRIVATE cxx_std_20)
target_link_libraries(tests PRIVATE hello)

include(CTest)
add_test(NAME "Simple Test" COMMAND tests)


if (BUILD_TESTING)
    # add_executable(tests)
    # target_sources(tests PRIVATE tests.cpp)
    # target_compile_features(tests PRIVATE cxx_std_20)
    # target_link_libraries(tests PRIVATE hello)
    # add_test(NAME tests COMMAND tests)
endif()