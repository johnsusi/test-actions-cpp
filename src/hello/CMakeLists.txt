add_library(hello)
target_sources(hello 
    PRIVATE
        hello.cpp
    PUBLIC
        FILE_SET HEADERS 
        BASE_DIRS  "${CMAKE_CURRENT_SOURCE_DIR}/.."
        FILES hello.hpp
)
  
target_compile_features(hello PRIVATE cxx_std_20)

install(TARGETS hello 
    EXPORT helloConfig
    FILE_SET HEADERS
)

install(EXPORT helloConfig NAMESPACE hello:: DESTINATION lib/cmake/hello)