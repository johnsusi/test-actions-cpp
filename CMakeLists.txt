cmake_minimum_required(VERSION 3.28.3)
project(HelloWorld LANGUAGES CXX)

add_subdirectory(src/hello)

add_executable(main)
target_sources(main PRIVATE main.cpp)
target_compile_features(main PRIVATE cxx_std_20)
target_link_libraries(main PRIVATE hello)

install(TARGETS main)

add_executable(tests)
target_sources(tests PRIVATE test.cpp)
target_compile_features(tests PRIVATE cxx_std_20)
target_link_libraries(tests PRIVATE hello)

include(CTest)
add_test(NAME "Executable runs" COMMAND main)


if (BUILD_TESTING)
    # add_executable(tests)
    # target_sources(tests PRIVATE tests.cpp)
    # target_compile_features(tests PRIVATE cxx_std_20)
    # target_link_libraries(tests PRIVATE hello)
    # add_test(NAME tests COMMAND tests)
endif()