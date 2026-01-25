#include <cuda_runtime.h>
#include "kernels.h"

__global__ void add(int *a, int *b, int *c) {
    *c = *a + *b;
}

int cuda_add(int a, int b) {
    int *d_a, *d_b, *d_c;
    int result = 0;

    cudaMalloc(&d_a, sizeof(int));
    cudaMalloc(&d_b, sizeof(int));
    cudaMalloc(&d_c, sizeof(int));

    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);

    add<<<1, 1>>>(d_a, d_b, d_c);

    cudaError_t err = cudaDeviceSynchronize();
    if (err != cudaSuccess) {
        cudaFree(d_a);
        cudaFree(d_b);
        cudaFree(d_c);
        return -1;
    }

    cudaMemcpy(&result, d_c, sizeof(int), cudaMemcpyDeviceToHost);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return result;
}
