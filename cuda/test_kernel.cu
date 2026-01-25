#include <gtest/gtest.h>
#include <cuda_runtime.h>

__global__ void add(int *a, int *b, int *c) {
    *c = *a + *b;
}

TEST(CudaKernelTest, AdditionWorks) {
    int a = 10, b = 20, c = 0;
    int *d_a, *d_b, *d_c;

    cudaMalloc(&d_a, sizeof(int));
    cudaMalloc(&d_b, sizeof(int));
    cudaMalloc(&d_c, sizeof(int));

    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

    add<<<1, 1>>>(d_a, d_b, d_c);
    cudaError_t err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        std::cerr << "CUDA Error: " << cudaGetErrorString(err) << std::endl;
        exit(1);
    }
    cudaMemcpy(&c, d_c, sizeof(int), cudaMemcpyDeviceToHost);
    
    EXPECT_EQ(c, 30);

    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
}
