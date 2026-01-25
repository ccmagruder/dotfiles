cmake_minimum_required(VERSION 3.25)
project(CudaTests LANGUAGES CXX CUDA)

# 1. Standard Binary
add_executable(cuda_app hello.cpp)
set_target_properties(cuda_app PROPERTIES CUDA_ARCHITECTURES 89) # For Ada Lovelace (RTX 40-series)

# 2. Testing Setup
enable_testing()
find_package(GTest REQUIRED)

add_executable(unit_tests test_kernels.cpp kernels.cu)
target_link_libraries(unit_tests GTest::gtest_main GTest::gtest)
set_target_properties(unit_tests PROPERTIES CUDA_ARCHITECTURES 89)

# Register with CTest
add_test(NAME MyCudaTest COMMAND unit_tests)

install(TARGETS cuda_app unit_tests DESTINATION bin)
