#include <gtest/gtest.h>
#include "kernels.h"

TEST(CudaKernelTest, AdditionWorks) {
    int result = cuda_add(10, 20);
    EXPECT_EQ(result, 30);
}

TEST(CudaKernelTest, ZeroAddition) {
    int result = cuda_add(0, 0);
    EXPECT_EQ(result, 0);
}

TEST(CudaKernelTest, NegativeAddition) {
    int result = cuda_add(-5, 15);
    EXPECT_EQ(result, 10);
}
