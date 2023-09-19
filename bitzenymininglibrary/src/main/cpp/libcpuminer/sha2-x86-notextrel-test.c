#include<stdio.h>
#include<stdint.h>
#include<stdlib.h>

#define STATE_NUM 32 

int sha256_use_4way();
void sha256_init_4way(uint32_t *state);
void sha256_transform_4way(uint32_t *state, const uint32_t *block, int swap);
void sha256d_ms_4way(uint32_t *hash,  uint32_t *data, const uint32_t *midstate, const uint32_t *prehash);

void test_sha256_use_4way() {
    printf("%d\n", sha256_use_4way());
}

void test_sha256_init_4way() {
    uint32_t state[STATE_NUM];
    sha256_init_4way(state);

    for(int i = 0; i < STATE_NUM; i++) {
        printf("%08x", state[i]);
    }

    printf("\n");
}

void test_sha256_transform_4way() {
    uint32_t state[STATE_NUM] __attribute__((aligned(128))) = { 0 };
    uint32_t block[STATE_NUM] __attribute__((aligned(128))) = { 0 };

    for (int i = 0; i < STATE_NUM; i++) {
        state[i] = rand();
        block[i] = rand();
    }

    sha256_transform_4way(state, block, 0);

    for(int i = 0; i < STATE_NUM; i++) {
        printf("%08x ", state[i]);
    }
    printf("\n");
}

void test_sha256d_ms_4way() {
	uint32_t hash[STATE_NUM] __attribute__((aligned(32))) = { 0 };
	uint32_t data[8 * STATE_NUM] __attribute__((aligned(128))) = { 0 };
	uint32_t midstate[STATE_NUM] __attribute__((aligned(32))) = { 0 };
	uint32_t prehash[STATE_NUM] __attribute__((aligned(32))) = { 0 };

    for (int i = 0; i < STATE_NUM; i++) {
        hash[i] = rand();
        midstate[i] = rand();
        prehash[i] = rand();
    }

    for (int i = 0; i < 8 * STATE_NUM; i++) {
        data[i] = rand();
    }

    sha256d_ms_4way(hash, data, midstate, prehash);

    for(int i = 0; i < STATE_NUM; i++) {
        printf("%08x ", hash[i]);
    }
    printf("\n");

    for(int i = 0; i < 8 * STATE_NUM; i++) {
        printf("%08x ", data[i]);
    }
    printf("\n");
}

int main() {
    test_sha256_use_4way();
    test_sha256_init_4way();
    for (int i = 0; i < 100; i++) {
        test_sha256_transform_4way();
        test_sha256d_ms_4way();
    }
    return 0;
}
