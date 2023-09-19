/*
 * Copyright 2012 pooler@litecoinpool.org
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your option)
 * any later version.  See COPYING for more details.
 */

#include "cpuminer-config.h"

#if defined(__linux__) && defined(__ELF__)
	.section .note.GNU-stack,"",%progbits
#endif

#if defined(USE_ASM) && defined(__i386__)


.macro sha256_4h
	pushl $0x5be0cd19; pushl $0x5be0cd19; pushl $0x5be0cd19; pushl $0x5be0cd19
	pushl $0x1f83d9ab; pushl $0x1f83d9ab; pushl $0x1f83d9ab; pushl $0x1f83d9ab
	pushl $0x9b05688c; pushl $0x9b05688c; pushl $0x9b05688c; pushl $0x9b05688c
	pushl $0x510e527f; pushl $0x510e527f; pushl $0x510e527f; pushl $0x510e527f
	pushl $0xa54ff53a; pushl $0xa54ff53a; pushl $0xa54ff53a; pushl $0xa54ff53a
	pushl $0x3c6ef372; pushl $0x3c6ef372; pushl $0x3c6ef372; pushl $0x3c6ef372
	pushl $0xbb67ae85; pushl $0xbb67ae85; pushl $0xbb67ae85; pushl $0xbb67ae85
	pushl $0x6a09e667; pushl $0x6a09e667; pushl $0x6a09e667; pushl $0x6a09e667
.endm

.macro sha256_4k
    pushl $0xc67178f2; pushl $0xc67178f2; pushl $0xc67178f2; pushl $0xc67178f2
    pushl $0xbef9a3f7; pushl $0xbef9a3f7; pushl $0xbef9a3f7; pushl $0xbef9a3f7
    pushl $0xa4506ceb; pushl $0xa4506ceb; pushl $0xa4506ceb; pushl $0xa4506ceb
    pushl $0x90befffa; pushl $0x90befffa; pushl $0x90befffa; pushl $0x90befffa
    pushl $0x8cc70208; pushl $0x8cc70208; pushl $0x8cc70208; pushl $0x8cc70208
    pushl $0x84c87814; pushl $0x84c87814; pushl $0x84c87814; pushl $0x84c87814
    pushl $0x78a5636f; pushl $0x78a5636f; pushl $0x78a5636f; pushl $0x78a5636f
    pushl $0x748f82ee; pushl $0x748f82ee; pushl $0x748f82ee; pushl $0x748f82ee
    pushl $0x682e6ff3; pushl $0x682e6ff3; pushl $0x682e6ff3; pushl $0x682e6ff3
    pushl $0x5b9cca4f; pushl $0x5b9cca4f; pushl $0x5b9cca4f; pushl $0x5b9cca4f
    pushl $0x4ed8aa4a; pushl $0x4ed8aa4a; pushl $0x4ed8aa4a; pushl $0x4ed8aa4a
    pushl $0x391c0cb3; pushl $0x391c0cb3; pushl $0x391c0cb3; pushl $0x391c0cb3
    pushl $0x34b0bcb5; pushl $0x34b0bcb5; pushl $0x34b0bcb5; pushl $0x34b0bcb5
    pushl $0x2748774c; pushl $0x2748774c; pushl $0x2748774c; pushl $0x2748774c
    pushl $0x1e376c08; pushl $0x1e376c08; pushl $0x1e376c08; pushl $0x1e376c08
    pushl $0x19a4c116; pushl $0x19a4c116; pushl $0x19a4c116; pushl $0x19a4c116
    pushl $0x106aa070; pushl $0x106aa070; pushl $0x106aa070; pushl $0x106aa070
    pushl $0xf40e3585; pushl $0xf40e3585; pushl $0xf40e3585; pushl $0xf40e3585
    pushl $0xd6990624; pushl $0xd6990624; pushl $0xd6990624; pushl $0xd6990624
    pushl $0xd192e819; pushl $0xd192e819; pushl $0xd192e819; pushl $0xd192e819
    pushl $0xc76c51a3; pushl $0xc76c51a3; pushl $0xc76c51a3; pushl $0xc76c51a3
    pushl $0xc24b8b70; pushl $0xc24b8b70; pushl $0xc24b8b70; pushl $0xc24b8b70
    pushl $0xa81a664b; pushl $0xa81a664b; pushl $0xa81a664b; pushl $0xa81a664b
    pushl $0xa2bfe8a1; pushl $0xa2bfe8a1; pushl $0xa2bfe8a1; pushl $0xa2bfe8a1
    pushl $0x92722c85; pushl $0x92722c85; pushl $0x92722c85; pushl $0x92722c85
    pushl $0x81c2c92e; pushl $0x81c2c92e; pushl $0x81c2c92e; pushl $0x81c2c92e
    pushl $0x766a0abb; pushl $0x766a0abb; pushl $0x766a0abb; pushl $0x766a0abb
    pushl $0x650a7354; pushl $0x650a7354; pushl $0x650a7354; pushl $0x650a7354
    pushl $0x53380d13; pushl $0x53380d13; pushl $0x53380d13; pushl $0x53380d13
    pushl $0x4d2c6dfc; pushl $0x4d2c6dfc; pushl $0x4d2c6dfc; pushl $0x4d2c6dfc
    pushl $0x2e1b2138; pushl $0x2e1b2138; pushl $0x2e1b2138; pushl $0x2e1b2138
    pushl $0x27b70a85; pushl $0x27b70a85; pushl $0x27b70a85; pushl $0x27b70a85
    pushl $0x14292967; pushl $0x14292967; pushl $0x14292967; pushl $0x14292967
    pushl $0x06ca6351; pushl $0x06ca6351; pushl $0x06ca6351; pushl $0x06ca6351
    pushl $0xd5a79147; pushl $0xd5a79147; pushl $0xd5a79147; pushl $0xd5a79147
    pushl $0xc6e00bf3; pushl $0xc6e00bf3; pushl $0xc6e00bf3; pushl $0xc6e00bf3
    pushl $0xbf597fc7; pushl $0xbf597fc7; pushl $0xbf597fc7; pushl $0xbf597fc7
    pushl $0xb00327c8; pushl $0xb00327c8; pushl $0xb00327c8; pushl $0xb00327c8
    pushl $0xa831c66d; pushl $0xa831c66d; pushl $0xa831c66d; pushl $0xa831c66d
    pushl $0x983e5152; pushl $0x983e5152; pushl $0x983e5152; pushl $0x983e5152
    pushl $0x76f988da; pushl $0x76f988da; pushl $0x76f988da; pushl $0x76f988da
    pushl $0x5cb0a9dc; pushl $0x5cb0a9dc; pushl $0x5cb0a9dc; pushl $0x5cb0a9dc
    pushl $0x4a7484aa; pushl $0x4a7484aa; pushl $0x4a7484aa; pushl $0x4a7484aa
    pushl $0x2de92c6f; pushl $0x2de92c6f; pushl $0x2de92c6f; pushl $0x2de92c6f
    pushl $0x240ca1cc; pushl $0x240ca1cc; pushl $0x240ca1cc; pushl $0x240ca1cc
    pushl $0x0fc19dc6; pushl $0x0fc19dc6; pushl $0x0fc19dc6; pushl $0x0fc19dc6
    pushl $0xefbe4786; pushl $0xefbe4786; pushl $0xefbe4786; pushl $0xefbe4786
    pushl $0xe49b69c1; pushl $0xe49b69c1; pushl $0xe49b69c1; pushl $0xe49b69c1
    pushl $0xc19bf174; pushl $0xc19bf174; pushl $0xc19bf174; pushl $0xc19bf174
    pushl $0x9bdc06a7; pushl $0x9bdc06a7; pushl $0x9bdc06a7; pushl $0x9bdc06a7
    pushl $0x80deb1fe; pushl $0x80deb1fe; pushl $0x80deb1fe; pushl $0x80deb1fe
    pushl $0x72be5d74; pushl $0x72be5d74; pushl $0x72be5d74; pushl $0x72be5d74
    pushl $0x550c7dc3; pushl $0x550c7dc3; pushl $0x550c7dc3; pushl $0x550c7dc3
    pushl $0x243185be; pushl $0x243185be; pushl $0x243185be; pushl $0x243185be
    pushl $0x12835b01; pushl $0x12835b01; pushl $0x12835b01; pushl $0x12835b01
    pushl $0xd807aa98; pushl $0xd807aa98; pushl $0xd807aa98; pushl $0xd807aa98
    pushl $0xab1c5ed5; pushl $0xab1c5ed5; pushl $0xab1c5ed5; pushl $0xab1c5ed5
    pushl $0x923f82a4; pushl $0x923f82a4; pushl $0x923f82a4; pushl $0x923f82a4
    pushl $0x59f111f1; pushl $0x59f111f1; pushl $0x59f111f1; pushl $0x59f111f1
    pushl $0x3956c25b; pushl $0x3956c25b; pushl $0x3956c25b; pushl $0x3956c25b
    pushl $0xe9b5dba5; pushl $0xe9b5dba5; pushl $0xe9b5dba5; pushl $0xe9b5dba5
    pushl $0xb5c0fbcf; pushl $0xb5c0fbcf; pushl $0xb5c0fbcf; pushl $0xb5c0fbcf
    pushl $0x71374491; pushl $0x71374491; pushl $0x71374491; pushl $0x71374491
    pushl $0x428a2f98; pushl $0x428a2f98; pushl $0x428a2f98; pushl $0x428a2f98
.endm

.macro sha256d_4preext2_15
	pushl $0x00000100; pushl $0x00000100; pushl $0x00000100; pushl $0x00000100
.endm
.macro sha256d_4preext2_17
	pushl $0x00a00000; pushl $0x00a00000; pushl $0x00a00000; pushl $0x00a00000
.endm
.macro sha256d_4preext2_23
	pushl $0x11002000; pushl $0x11002000; pushl $0x11002000; pushl $0x11002000
.endm
.macro sha256d_4preext2_24
	pushl $0x80000000; pushl $0x80000000; pushl $0x80000000; pushl $0x80000000
.endm
.macro sha256d_4preext2_30
	pushl $0x00400022; pushl $0x00400022; pushl $0x00400022; pushl $0x00400022
.endm


	.text
	.p2align 5
	.globl sha256_init_4way
	.globl _sha256_init_4way
sha256_init_4way:
_sha256_init_4way:
	movl	4(%esp), %edx
    pushl   %ebp
    movl    %esp, %ebp
    and     $0xfffffff0, %esp
    subl    $128, %esp
    pushl   %ebp
    subl    $124, %esp
    sha256_4h
    movl    %esp, %ebp
	movdqa	(%ebp), %xmm0    #sha256_4h
	movdqa	16(%ebp), %xmm1  #sha256_4h
	movdqa	32(%ebp), %xmm2  #sha256_4h
	movdqa	48(%ebp), %xmm3  #sha256_4h
	movdqu	%xmm0, 0(%edx)
	movdqu	%xmm1, 16(%edx)
	movdqu	%xmm2, 32(%edx)
	movdqu	%xmm3, 48(%edx)
	movdqa	64(%ebp), %xmm0  #sha256_4h
	movdqa	80(%ebp), %xmm1  #sha256_4h
	movdqa	96(%ebp), %xmm2  #sha256_4h
	movdqa	112(%ebp), %xmm3 #sha256_4h
	movdqu	%xmm0, 64(%edx)
	movdqu	%xmm1, 80(%edx)
	movdqu	%xmm2, 96(%edx)
	movdqu	%xmm3, 112(%edx)
    movl    %ebp, %esp
    addl    $128, %esp
    addl    $124, %esp
    popl    %ebp
	movl	%ebp, %esp
    popl    %ebp
	ret


.macro sha256_sse2_extend_round i
	movdqa	(\i-15)*16(%eax), %xmm0
	movdqa	%xmm0, %xmm2
	psrld	$3, %xmm0
	movdqa	%xmm0, %xmm1
	pslld	$14, %xmm2
	psrld	$4, %xmm1
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	psrld	$11, %xmm1
	pslld	$11, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	paddd	(\i-16)*16(%eax), %xmm0
	paddd	(\i-7)*16(%eax), %xmm0

	movdqa	%xmm3, %xmm2
	psrld	$10, %xmm3
	pslld	$13, %xmm2
	movdqa	%xmm3, %xmm1
	psrld	$7, %xmm1
	pxor	%xmm1, %xmm3
	pxor	%xmm2, %xmm3
	psrld	$2, %xmm1
	pslld	$2, %xmm2
	pxor	%xmm1, %xmm3
	pxor	%xmm2, %xmm3
	paddd	%xmm0, %xmm3
	movdqa	%xmm3, \i*16(%eax)
.endm

.macro sha256_sse2_extend_doubleround i
	movdqa	(\i-15)*16(%eax), %xmm0
	movdqa	(\i-14)*16(%eax), %xmm4
	movdqa	%xmm0, %xmm2
	movdqa	%xmm4, %xmm6
	psrld	$3, %xmm0
	psrld	$3, %xmm4
	movdqa	%xmm0, %xmm1
	movdqa	%xmm4, %xmm5
	pslld	$14, %xmm2
	pslld	$14, %xmm6
	psrld	$4, %xmm1
	psrld	$4, %xmm5
	pxor	%xmm1, %xmm0
	pxor	%xmm5, %xmm4
	psrld	$11, %xmm1
	psrld	$11, %xmm5
	pxor	%xmm2, %xmm0
	pxor	%xmm6, %xmm4
	pslld	$11, %xmm2
	pslld	$11, %xmm6
	pxor	%xmm1, %xmm0
	pxor	%xmm5, %xmm4
	pxor	%xmm2, %xmm0
	pxor	%xmm6, %xmm4

	paddd	(\i-16)*16(%eax), %xmm0
	paddd	(\i-15)*16(%eax), %xmm4

	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5

	paddd	(\i-7)*16(%eax), %xmm0
	paddd	(\i-6)*16(%eax), %xmm4

	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7

	paddd	%xmm0, %xmm3
	paddd	%xmm4, %xmm7
	movdqa	%xmm3, \i*16(%eax)
	movdqa	%xmm7, (\i+1)*16(%eax)
.endm

.macro sha256_sse2_main_round i
	movdqa	16*(\i)(%eax), %xmm6

	movdqa	%xmm0, %xmm1
	movdqa	16(%esp), %xmm2
	pandn	%xmm2, %xmm1
	paddd	32(%esp), %xmm6

	movdqa	%xmm2, 32(%esp)
	movdqa	0(%esp), %xmm2
	movdqa	%xmm2, 16(%esp)

	pand	%xmm0, %xmm2
	pxor	%xmm2, %xmm1
	movdqa	%xmm0, 0(%esp)

	paddd	%xmm1, %xmm6

	movdqa	%xmm0, %xmm1
	psrld	$6, %xmm0
	paddd	(128+16*(\i))(%ebp), %xmm6 #sha256_4k
	movdqa	%xmm0, %xmm2
	pslld	$7, %xmm1
	psrld	$5, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	pslld	$14, %xmm1
	psrld	$14, %xmm2
	pxor	%xmm1, %xmm0
	pslld	$5, %xmm1
	pxor	%xmm2, %xmm0
	pxor	%xmm1, %xmm0
	movdqa	%xmm5, %xmm1
	paddd	%xmm0, %xmm6

	movdqa	%xmm3, %xmm0
	movdqa	%xmm4, %xmm3
	movdqa	%xmm4, %xmm2
	paddd	%xmm6, %xmm0
	pand	%xmm5, %xmm2
	pand	%xmm7, %xmm1
	pand	%xmm7, %xmm4
	pxor	%xmm4, %xmm1
	movdqa	%xmm5, %xmm4
	movdqa	%xmm7, %xmm5
	pxor	%xmm2, %xmm1
	paddd	%xmm1, %xmm6

	movdqa	%xmm7, %xmm2
	psrld	$2, %xmm7
	movdqa	%xmm7, %xmm1
	pslld	$10, %xmm2
	psrld	$11, %xmm1
	pxor	%xmm2, %xmm7
	pslld	$9, %xmm2
	pxor	%xmm1, %xmm7
	psrld	$9, %xmm1
	pxor	%xmm2, %xmm7
	pslld	$11, %xmm2
	pxor	%xmm1, %xmm7
	pxor	%xmm2, %xmm7
	paddd	%xmm6, %xmm7
.endm

.macro sha256_sse2_main_quadround i
	sha256_sse2_main_round \i+0
	sha256_sse2_main_round \i+1
	sha256_sse2_main_round \i+2
	sha256_sse2_main_round \i+3
.endm


.macro p2bswap_esi_esp i
	movdqu	\i*16(%esi), %xmm0
	movdqu	(\i+1)*16(%esi), %xmm2
	pshuflw	$0xb1, %xmm0, %xmm0
	pshuflw	$0xb1, %xmm2, %xmm2
	pshufhw	$0xb1, %xmm0, %xmm0
	pshufhw	$0xb1, %xmm2, %xmm2
	movdqa	%xmm0, %xmm1
	movdqa	%xmm2, %xmm3
	psrlw	$8, %xmm1
	psrlw	$8, %xmm3
	psllw	$8, %xmm0
	psllw	$8, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm3, %xmm2
	movdqa	%xmm0, (\i+3)*16(%esp)
	movdqa	%xmm2, (\i+4)*16(%esp)
.endm

	.text
	.p2align 5
	.globl sha256_transform_4way
	.globl _sha256_transform_4way
sha256_transform_4way:
_sha256_transform_4way:
	pushl	%edi
	pushl	%esi
	movl	12(%esp), %edi
	movl	16(%esp), %esi
	movl	20(%esp), %ecx
	movl	%esp, %edx

    pushl   %ebp
    movl    %esp, %ebp
    and     $0xfffffff0, %esp
    subl    $128, %esp
    pushl   %ebp
    subl    $124, %esp
    sha256_4k
    movl    %esp, %ebp

	subl	$67*16, %esp
	andl	$-128, %esp
	
	testl	%ecx, %ecx
	jnz sha256_transform_4way_swap
	
	movdqu	0*16(%esi), %xmm0
	movdqu	1*16(%esi), %xmm1
	movdqu	2*16(%esi), %xmm2
	movdqu	3*16(%esi), %xmm3
	movdqu	4*16(%esi), %xmm4
	movdqu	5*16(%esi), %xmm5
	movdqu	6*16(%esi), %xmm6
	movdqu	7*16(%esi), %xmm7
	movdqa	%xmm0, 3*16(%esp)
	movdqa	%xmm1, 4*16(%esp)
	movdqa	%xmm2, 5*16(%esp)
	movdqa	%xmm3, 6*16(%esp)
	movdqa	%xmm4, 7*16(%esp)
	movdqa	%xmm5, 8*16(%esp)
	movdqa	%xmm6, 9*16(%esp)
	movdqa	%xmm7, 10*16(%esp)
	movdqu	8*16(%esi), %xmm0
	movdqu	9*16(%esi), %xmm1
	movdqu	10*16(%esi), %xmm2
	movdqu	11*16(%esi), %xmm3
	movdqu	12*16(%esi), %xmm4
	movdqu	13*16(%esi), %xmm5
	movdqu	14*16(%esi), %xmm6
	movdqu	15*16(%esi), %xmm7
	movdqa	%xmm0, 11*16(%esp)
	movdqa	%xmm1, 12*16(%esp)
	movdqa	%xmm2, 13*16(%esp)
	movdqa	%xmm3, 14*16(%esp)
	movdqa	%xmm4, 15*16(%esp)
	movdqa	%xmm5, 16*16(%esp)
	movdqa	%xmm6, 17*16(%esp)
	movdqa	%xmm7, 18*16(%esp)
	jmp sha256_transform_4way_extend
	
	.p2align 5
sha256_transform_4way_swap:
	p2bswap_esi_esp 0
	p2bswap_esi_esp 2
	p2bswap_esi_esp 4
	p2bswap_esi_esp 6
	p2bswap_esi_esp 8
	p2bswap_esi_esp 10
	p2bswap_esi_esp 12
	p2bswap_esi_esp 14
	
sha256_transform_4way_extend:
	leal	19*16(%esp), %ecx
	leal	48*16(%ecx), %eax
	movdqa	-2*16(%ecx), %xmm3
	movdqa	-1*16(%ecx), %xmm7
sha256_transform_4way_extend_loop:
	movdqa	-15*16(%ecx), %xmm0
	movdqa	-14*16(%ecx), %xmm4
	movdqa	%xmm0, %xmm2
	movdqa	%xmm4, %xmm6
	psrld	$3, %xmm0
	psrld	$3, %xmm4
	movdqa	%xmm0, %xmm1
	movdqa	%xmm4, %xmm5
	pslld	$14, %xmm2
	pslld	$14, %xmm6
	psrld	$4, %xmm1
	psrld	$4, %xmm5
	pxor	%xmm1, %xmm0
	pxor	%xmm5, %xmm4
	psrld	$11, %xmm1
	psrld	$11, %xmm5
	pxor	%xmm2, %xmm0
	pxor	%xmm6, %xmm4
	pslld	$11, %xmm2
	pslld	$11, %xmm6
	pxor	%xmm1, %xmm0
	pxor	%xmm5, %xmm4
	pxor	%xmm2, %xmm0
	pxor	%xmm6, %xmm4

	paddd	-16*16(%ecx), %xmm0
	paddd	-15*16(%ecx), %xmm4

	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5

	paddd	-7*16(%ecx), %xmm0
	paddd	-6*16(%ecx), %xmm4

	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7

	paddd	%xmm0, %xmm3
	paddd	%xmm4, %xmm7
	movdqa	%xmm3, (%ecx)
	movdqa	%xmm7, 16(%ecx)
	addl	$2*16, %ecx
	cmpl	%ecx, %eax
	jne sha256_transform_4way_extend_loop
	
	movdqu	0(%edi), %xmm7
	movdqu	16(%edi), %xmm5
	movdqu	32(%edi), %xmm4
	movdqu	48(%edi), %xmm3
	movdqu	64(%edi), %xmm0
	movdqu	80(%edi), %xmm1
	movdqu	96(%edi), %xmm2
	movdqu	112(%edi), %xmm6
	movdqa	%xmm1, 0(%esp)
	movdqa	%xmm2, 16(%esp)
	movdqa	%xmm6, 32(%esp)
	
	xorl	%eax, %eax
sha256_transform_4way_main_loop:
	movdqa	3*16(%esp, %eax), %xmm6
	paddd	(%ebp, %eax), %xmm6 #sha256_4k
	paddd	32(%esp), %xmm6

	movdqa	%xmm0, %xmm1
	movdqa	16(%esp), %xmm2
	pandn	%xmm2, %xmm1

	movdqa	%xmm2, 32(%esp)
	movdqa	0(%esp), %xmm2
	movdqa	%xmm2, 16(%esp)

	pand	%xmm0, %xmm2
	pxor	%xmm2, %xmm1
	movdqa	%xmm0, 0(%esp)

	paddd	%xmm1, %xmm6

	movdqa	%xmm0, %xmm1
	psrld	$6, %xmm0
	movdqa	%xmm0, %xmm2
	pslld	$7, %xmm1
	psrld	$5, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	pslld	$14, %xmm1
	psrld	$14, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	pslld	$5, %xmm1
	pxor	%xmm1, %xmm0
	paddd	%xmm0, %xmm6

	movdqa	%xmm3, %xmm0
	paddd	%xmm6, %xmm0

	movdqa	%xmm5, %xmm1
	movdqa	%xmm4, %xmm3
	movdqa	%xmm4, %xmm2
	pand	%xmm5, %xmm2
	pand	%xmm7, %xmm4
	pand	%xmm7, %xmm1
	pxor	%xmm4, %xmm1
	movdqa	%xmm5, %xmm4
	movdqa	%xmm7, %xmm5
	pxor	%xmm2, %xmm1
	paddd	%xmm1, %xmm6

	movdqa	%xmm7, %xmm2
	psrld	$2, %xmm7
	movdqa	%xmm7, %xmm1
	pslld	$10, %xmm2
	psrld	$11, %xmm1
	pxor	%xmm2, %xmm7
	pxor	%xmm1, %xmm7
	pslld	$9, %xmm2
	psrld	$9, %xmm1
	pxor	%xmm2, %xmm7
	pxor	%xmm1, %xmm7
	pslld	$11, %xmm2
	pxor	%xmm2, %xmm7
	paddd	%xmm6, %xmm7
	
	addl	$16, %eax
	cmpl	$16*64, %eax
	jne sha256_transform_4way_main_loop
	
	movdqu	0(%edi), %xmm1
	movdqu	16(%edi), %xmm2
	paddd	%xmm1, %xmm7
	paddd	%xmm2, %xmm5
	movdqu	32(%edi), %xmm1
	movdqu	48(%edi), %xmm2
	paddd	%xmm1, %xmm4
	paddd	%xmm2, %xmm3
	
	movdqu	%xmm7, 0(%edi)
	movdqu	%xmm5, 16(%edi)
	movdqu	%xmm4, 32(%edi)
	movdqu	%xmm3, 48(%edi)
	
	movdqu	64(%edi), %xmm1
	movdqu	80(%edi), %xmm2
	movdqu	96(%edi), %xmm6
	movdqu	112(%edi), %xmm7
	paddd	%xmm1, %xmm0
	paddd	0(%esp), %xmm2
	paddd	16(%esp), %xmm6
	paddd	32(%esp), %xmm7
	
	movdqu	%xmm0, 64(%edi)
	movdqu	%xmm2, 80(%edi)
	movdqu	%xmm6, 96(%edi)
	movdqu	%xmm7, 112(%edi)

    movl    %ebp, %esp
    addl    $1148, %esp
    popl    %ebp
    movl    %ebp, %esp
    popl    %ebp
	
	movl	%edx, %esp
	popl	%esi
	popl	%edi
	ret


	.text
	.p2align 5
	.globl sha256d_ms_4way
	.globl _sha256d_ms_4way
sha256d_ms_4way:
_sha256d_ms_4way:
	pushl	%edi
	pushl	%esi
	pushl	%ebp
	movl	16(%esp), %edi
	movl	20(%esp), %esi
	movl	24(%esp), %edx
	movl	28(%esp), %ecx
    movl    %esp, %ebp
    and     $0xfffffff0, %esp
    subl    $128, %esp
    pushl   %ebp
    subl    $124, %esp
    sha256d_4preext2_30
    sha256d_4preext2_24
    sha256d_4preext2_23
    sha256d_4preext2_17
    sha256d_4preext2_15
    sha256_4k
    sha256_4h
    movl    %esp, %ebp
	subl	$67*16, %esp
	andl	$-128, %esp
	
	leal	256(%esi), %eax
	
sha256d_ms_4way_extend_loop1:
	movdqa	3*16(%esi), %xmm0
	movdqa	2*16(%eax), %xmm3
	movdqa	3*16(%eax), %xmm7
	movdqa	%xmm3, 5*16(%esp)
	movdqa	%xmm7, 6*16(%esp)
	movdqa	%xmm0, %xmm2
	paddd	%xmm0, %xmm7
	psrld	$3, %xmm0
	movdqa	%xmm0, %xmm1
	pslld	$14, %xmm2
	psrld	$4, %xmm1
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	psrld	$11, %xmm1
	pslld	$11, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	paddd	%xmm0, %xmm3
	movdqa	%xmm3, 2*16(%eax)
	movdqa	%xmm7, 3*16(%eax)
	
	movdqa	4*16(%eax), %xmm0
	movdqa	%xmm0, 7*16(%esp)
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	%xmm0, %xmm3
	movdqa	%xmm3, 4*16(%eax)
	movdqa	%xmm7, 5*16(%eax)
	
	movdqa	6*16(%eax), %xmm0
	movdqa	7*16(%eax), %xmm4
	movdqa	%xmm0, 9*16(%esp)
	movdqa	%xmm4, 10*16(%esp)
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	%xmm0, %xmm3
	paddd	%xmm4, %xmm7
	movdqa	%xmm3, 6*16(%eax)
	movdqa	%xmm7, 7*16(%eax)
	
	movdqa	8*16(%eax), %xmm0
	movdqa	2*16(%eax), %xmm4
	movdqa	%xmm0, 11*16(%esp)
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	%xmm0, %xmm3
	paddd	%xmm4, %xmm7
	movdqa	%xmm3, 8*16(%eax)
	movdqa	%xmm7, 9*16(%eax)
	
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	3*16(%eax), %xmm3
	paddd	4*16(%eax), %xmm7
	movdqa	%xmm3, 10*16(%eax)
	movdqa	%xmm7, 11*16(%eax)
	
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	5*16(%eax), %xmm3
	paddd	6*16(%eax), %xmm7
	movdqa	%xmm3, 12*16(%eax)
	movdqa	%xmm7, 13*16(%eax)
	
	movdqa	14*16(%eax), %xmm0
	movdqa	15*16(%eax), %xmm4
	movdqa	%xmm0, 17*16(%esp)
	movdqa	%xmm4, 18*16(%esp)
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	paddd	7*16(%eax), %xmm0
	paddd	8*16(%eax), %xmm4
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	%xmm0, %xmm3
	paddd	%xmm4, %xmm7
	movdqa	%xmm3, 14*16(%eax)
	movdqa	%xmm7, 15*16(%eax)
	
sha256d_ms_4way_extend_loop2:
	sha256_sse2_extend_doubleround 16
	sha256_sse2_extend_doubleround 18
	sha256_sse2_extend_doubleround 20
	sha256_sse2_extend_doubleround 22
	sha256_sse2_extend_doubleround 24
	sha256_sse2_extend_doubleround 26
	sha256_sse2_extend_doubleround 28
	sha256_sse2_extend_doubleround 30
	sha256_sse2_extend_doubleround 32
	sha256_sse2_extend_doubleround 34
	sha256_sse2_extend_doubleround 36
	sha256_sse2_extend_doubleround 38
	sha256_sse2_extend_doubleround 40
	sha256_sse2_extend_doubleround 42
	jz sha256d_ms_4way_extend_coda2
	sha256_sse2_extend_doubleround 44
	sha256_sse2_extend_doubleround 46
	
	movdqa	0(%ecx), %xmm3
	movdqa	16(%ecx), %xmm0
	movdqa	32(%ecx), %xmm1
	movdqa	48(%ecx), %xmm2
	movdqa	64(%ecx), %xmm6
	movdqa	80(%ecx), %xmm7
	movdqa	96(%ecx), %xmm5
	movdqa	112(%ecx), %xmm4
	movdqa	%xmm1, 0(%esp)
	movdqa	%xmm2, 16(%esp)
	movdqa	%xmm6, 32(%esp)
	
	movl	%esi, %eax
	jmp sha256d_ms_4way_main_loop1
	
sha256d_ms_4way_main_loop2:
	sha256_sse2_main_round 0
	sha256_sse2_main_round 1
	sha256_sse2_main_round 2
sha256d_ms_4way_main_loop1:
	sha256_sse2_main_round 3
	sha256_sse2_main_quadround 4
	sha256_sse2_main_quadround 8
	sha256_sse2_main_quadround 12
	sha256_sse2_main_quadround 16
	sha256_sse2_main_quadround 20
	sha256_sse2_main_quadround 24
	sha256_sse2_main_quadround 28
	sha256_sse2_main_quadround 32
	sha256_sse2_main_quadround 36
	sha256_sse2_main_quadround 40
	sha256_sse2_main_quadround 44
	sha256_sse2_main_quadround 48
	sha256_sse2_main_quadround 52
	sha256_sse2_main_round 56
	jz sha256d_ms_4way_finish
	sha256_sse2_main_round 57
	sha256_sse2_main_round 58
	sha256_sse2_main_round 59
	sha256_sse2_main_quadround 60
	
	movdqa	5*16(%esp), %xmm1
	movdqa	6*16(%esp), %xmm2
	movdqa	7*16(%esp), %xmm6
	movdqa	%xmm1, 18*16(%esi)
	movdqa	%xmm2, 19*16(%esi)
	movdqa	%xmm6, 20*16(%esi)
	movdqa	9*16(%esp), %xmm1
	movdqa	10*16(%esp), %xmm2
	movdqa	11*16(%esp), %xmm6
	movdqa	%xmm1, 22*16(%esi)
	movdqa	%xmm2, 23*16(%esi)
	movdqa	%xmm6, 24*16(%esi)
	movdqa	17*16(%esp), %xmm1
	movdqa	18*16(%esp), %xmm2
	movdqa	%xmm1, 30*16(%esi)
	movdqa	%xmm2, 31*16(%esi)
	
	movdqa	0(%esp), %xmm1
	movdqa	16(%esp), %xmm2
	movdqa	32(%esp), %xmm6
	paddd	0(%edx), %xmm7
	paddd	16(%edx), %xmm5
	paddd	32(%edx), %xmm4
	paddd	48(%edx), %xmm3
	paddd	64(%edx), %xmm0
	paddd	80(%edx), %xmm1
	paddd	96(%edx), %xmm2
	paddd	112(%edx), %xmm6
	
	movdqa	%xmm7, 48+0(%esp)
	movdqa	%xmm5, 48+16(%esp)
	movdqa	%xmm4, 48+32(%esp)
	movdqa	%xmm3, 48+48(%esp)
	movdqa	%xmm0, 48+64(%esp)
	movdqa	%xmm1, 48+80(%esp)
	movdqa	%xmm2, 48+96(%esp)
	movdqa	%xmm6, 48+112(%esp)
	
	movdqa	1152(%ebp), %xmm1 #sha256d_4preext2_15
	movdqa	1200(%ebp), %xmm2 #sha256d_4preext2_24
	pxor	%xmm0, %xmm0
	movdqa	%xmm2, 48+128(%esp)
	movdqa	%xmm0, 48+144(%esp)
	movdqa	%xmm0, 48+160(%esp)
	movdqa	%xmm0, 48+176(%esp)
	movdqa	%xmm0, 48+192(%esp)
	movdqa	%xmm0, 48+208(%esp)
	movdqa	%xmm0, 48+224(%esp)
	movdqa	%xmm1, 48+240(%esp)
	
	leal	19*16(%esp), %eax
	cmpl	%eax, %eax
	
	movdqa	-15*16(%eax), %xmm0
	movdqa	-14*16(%eax), %xmm4
	movdqa	%xmm0, %xmm2
	movdqa	%xmm4, %xmm6
	psrld	$3, %xmm0
	psrld	$3, %xmm4
	movdqa	%xmm0, %xmm1
	movdqa	%xmm4, %xmm5
	pslld	$14, %xmm2
	pslld	$14, %xmm6
	psrld	$4, %xmm1
	psrld	$4, %xmm5
	pxor	%xmm1, %xmm0
	pxor	%xmm5, %xmm4
	psrld	$11, %xmm1
	psrld	$11, %xmm5
	pxor	%xmm2, %xmm0
	pxor	%xmm6, %xmm4
	pslld	$11, %xmm2
	pslld	$11, %xmm6
	pxor	%xmm1, %xmm0
	pxor	%xmm5, %xmm4
	pxor	%xmm2, %xmm0
	pxor	%xmm6, %xmm4
	paddd	-16*16(%eax), %xmm0
	paddd	-15*16(%eax), %xmm4
	paddd	1168(%ebp), %xmm4 #sha256d_4preext2_17
	movdqa	%xmm0, %xmm3
	movdqa	%xmm4, %xmm7
	movdqa	%xmm3, 0*16(%eax)
	movdqa	%xmm7, 1*16(%eax)
	
	sha256_sse2_extend_doubleround 2
	sha256_sse2_extend_doubleround 4
	
	movdqa	-9*16(%eax), %xmm0
	movdqa	1184(%ebp), %xmm4 #sha256d_4preext2_23
	movdqa	%xmm0, %xmm2
	psrld	$3, %xmm0
	movdqa	%xmm0, %xmm1
	pslld	$14, %xmm2
	psrld	$4, %xmm1
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	psrld	$11, %xmm1
	pslld	$11, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	paddd	-10*16(%eax), %xmm0
	paddd	-9*16(%eax), %xmm4
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	paddd	-1*16(%eax), %xmm0
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	paddd	0*16(%eax), %xmm4
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	%xmm0, %xmm3
	paddd	%xmm4, %xmm7
	movdqa	%xmm3, 6*16(%eax)
	movdqa	%xmm7, 7*16(%eax)
	
	movdqa	1200(%ebp), %xmm0 #sha256d_4preext2_24
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	paddd	1*16(%eax), %xmm0
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	%xmm0, %xmm3
	paddd	2*16(%eax), %xmm7
	movdqa	%xmm3, 8*16(%eax)
	movdqa	%xmm7, 9*16(%eax)
	
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	3*16(%eax), %xmm3
	paddd	4*16(%eax), %xmm7
	movdqa	%xmm3, 10*16(%eax)
	movdqa	%xmm7, 11*16(%eax)
	
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	5*16(%eax), %xmm3
	paddd	6*16(%eax), %xmm7
	movdqa	%xmm3, 12*16(%eax)
	movdqa	%xmm7, 13*16(%eax)
	
	movdqa	1216(%ebp), %xmm0 #sha256d_4preext2_30
	movdqa	0*16(%eax), %xmm4
	movdqa	%xmm4, %xmm6
	psrld	$3, %xmm4
	movdqa	%xmm4, %xmm5
	pslld	$14, %xmm6
	psrld	$4, %xmm5
	pxor	%xmm5, %xmm4
	pxor	%xmm6, %xmm4
	psrld	$11, %xmm5
	pslld	$11, %xmm6
	pxor	%xmm5, %xmm4
	pxor	%xmm6, %xmm4
	paddd	-1*16(%eax), %xmm4
	movdqa	%xmm3, %xmm2
	movdqa	%xmm7, %xmm6
	psrld	$10, %xmm3
	psrld	$10, %xmm7
	movdqa	%xmm3, %xmm1
	movdqa	%xmm7, %xmm5
	paddd	7*16(%eax), %xmm0
	pslld	$13, %xmm2
	pslld	$13, %xmm6
	psrld	$7, %xmm1
	psrld	$7, %xmm5
	paddd	8*16(%eax), %xmm4
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	psrld	$2, %xmm1
	psrld	$2, %xmm5
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	pslld	$2, %xmm2
	pslld	$2, %xmm6
	pxor	%xmm1, %xmm3
	pxor	%xmm5, %xmm7
	pxor	%xmm2, %xmm3
	pxor	%xmm6, %xmm7
	paddd	%xmm0, %xmm3
	paddd	%xmm4, %xmm7
	movdqa	%xmm3, 14*16(%eax)
	movdqa	%xmm7, 15*16(%eax)
	
	jmp sha256d_ms_4way_extend_loop2
	
sha256d_ms_4way_extend_coda2:
	sha256_sse2_extend_round 44
	
	movdqa	0(%ebp), %xmm7   #sha256_4h
	movdqa	16(%ebp), %xmm5  #sha256_4h
	movdqa	32(%ebp), %xmm4  #sha256_4h
	movdqa	48(%ebp), %xmm3  #sha256_4h
	movdqa	64(%ebp), %xmm0  #sha256_4h
	movdqa	80(%ebp), %xmm1  #sha256_4h
	movdqa	96(%ebp), %xmm2  #sha256_4h
	movdqa	112(%ebp), %xmm6 #sha256_4h
	movdqa	%xmm1, 0(%esp)
	movdqa	%xmm2, 16(%esp)
	movdqa	%xmm6, 32(%esp)
	
	leal	48(%esp), %eax
	jmp sha256d_ms_4way_main_loop2

.macro sha256_sse2_main_round_red i, r7
	movdqa	16*(\i)(%eax), %xmm6
	paddd	(128+16*(\i))(%ebp), %xmm6 #sha256_4k
	paddd	32(%esp), %xmm6
	movdqa	%xmm0, %xmm1
	movdqa	16(%esp), %xmm2
	paddd	\r7, %xmm6
	pandn	%xmm2, %xmm1
	movdqa	%xmm2, 32(%esp)
	movdqa	0(%esp), %xmm2
	movdqa	%xmm2, 16(%esp)
	pand	%xmm0, %xmm2
	pxor	%xmm2, %xmm1
	movdqa	%xmm0, 0(%esp)
	paddd	%xmm1, %xmm6
	movdqa	%xmm0, %xmm1
	psrld	$6, %xmm0
	movdqa	%xmm0, %xmm2
	pslld	$7, %xmm1
	psrld	$5, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	pslld	$14, %xmm1
	psrld	$14, %xmm2
	pxor	%xmm1, %xmm0
	pxor	%xmm2, %xmm0
	pslld	$5, %xmm1
	pxor	%xmm1, %xmm0
	paddd	%xmm6, %xmm0
.endm

sha256d_ms_4way_finish:
	sha256_sse2_main_round_red 57, %xmm3
	sha256_sse2_main_round_red 58, %xmm4
	sha256_sse2_main_round_red 59, %xmm5
	sha256_sse2_main_round_red 60, %xmm7
	
	paddd	112(%ebp), %xmm0  #sha256_4h
	movdqa	%xmm0, 112(%edi)
	
    movl    %ebp, %esp
    addl    $1356, %esp
    popl    %ebp
	movl	%ebp, %esp
	popl	%ebp
	popl	%esi
	popl	%edi
	ret


	.text
	.p2align 5
	.globl sha256_use_4way
	.globl _sha256_use_4way
sha256_use_4way:
_sha256_use_4way:
	pushl	%ebx
	
	/* Check for SSE2 availability */
	movl	$1, %eax
	cpuid
	andl	$0x04000000, %edx
	jnz sha256_use_4way_sse2
	xorl	%eax, %eax
	popl	%ebx
	ret
	
sha256_use_4way_sse2:
	movl	$1, %eax
	popl	%ebx
	ret

#endif
