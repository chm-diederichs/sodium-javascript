// #include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef int32_t fe25519[10];

/* sqrt(-486664) */
static const fe25519 ed25519_sqrtam2 = {
    -12222970, -8312128, -11511410, 9067497, -15300785, -241793, 25456130, 14121551, -12187136, 3972024
};

void print_hex(const char *s)
{
  while(*s)
    printf("%x", (unsigned int) *s++);
  printf("\n");
}

char *
bin2hex(char *const hex, const size_t hex_maxlen,
               const unsigned char *const bin, const size_t bin_len)
{
    size_t       i = (size_t) 0U;
    unsigned int x;
    int          b;
    int          c;


    while (i < bin_len) {
        c = bin[i] & 0xf;
        b = bin[i] >> 4;
        x = (unsigned char) (87U + c + (((c - 10U) >> 8) & ~38U)) << 8 |
            (unsigned char) (87U + b + (((b - 10U) >> 8) & ~38U));
        hex[i * 2U] = (char) x;
        x >>= 8;
        hex[i * 2U + 1U] = (char) x;
        i++;
    }
    hex[i * 2U] = 0U;

    return hex;
}

int
sodium_is_zero(const unsigned char *n, const size_t nlen)
{
    size_t                 i;
    volatile unsigned char d = 0U;

    for (i = 0U; i < nlen; i++) {
        d |= n[i];
    }
    return 1 & ((d - 1) >> 8);
}

static inline uint64_t load_3(const unsigned char *in)
{
    uint64_t result;

    result = (uint64_t) in[0];
    result |= ((uint64_t) in[1]) << 8;
    result |= ((uint64_t) in[2]) << 16;

    return result;
}

static inline uint64_t load_4(const unsigned char *in)
{
    uint64_t result;

    result = (uint64_t) in[0];
    result |= ((uint64_t) in[1]) << 8;
    result |= ((uint64_t) in[2]) << 16;
    result |= ((uint64_t) in[3]) << 24;

    // printf("%016llx\n", ((uint64_t) in[3]) << 24);
    // printf("%08llx\n", result);
    return result;
}


/*
 Ignores top bit of s.
 */

void
fe25519_frombytes(fe25519 h, const unsigned char *s)
{
    int64_t h0 = load_4(s);
    int64_t h1 = load_3(s + 4) << 6;
    int64_t h2 = load_3(s + 7) << 5;
    int64_t h3 = load_3(s + 10) << 3;
    int64_t h4 = load_3(s + 13) << 2;
    int64_t h5 = load_4(s + 16);
    int64_t h6 = load_3(s + 20) << 7;
    int64_t h7 = load_3(s + 23) << 5;
    int64_t h8 = load_3(s + 26) << 4;
    int64_t h9 = (load_3(s + 29) & 8388607) << 2;



    int64_t carry0;
    int64_t carry1;
    int64_t carry2;
    int64_t carry3;
    int64_t carry4;
    int64_t carry5;
    int64_t carry6;
    int64_t carry7;
    int64_t carry8;
    int64_t carry9;

    // printf("\nh0 _______________________________\n");
    // printf("%08llx\n", h0 & 0xffff);
    // printf("%08llx\n", h0 >> 16);
    // printf("%08llx\n", h0);
    carry9 = (h9 + (int64_t)(1L << 24)) >> 25;
    h0 += carry9 * 19;
    h9 -= carry9 * ((uint64_t) 1L << 25);
    // printf("%08llx\n", h0 & 0xffff);
    // printf("%08llx\n", h0 >> 16);
    // printf("%08llx\n", h0);

    // printf("\nh2 _______________________________\n");
    // printf("%08llx\n", h2 & 0xffff);
    // printf("%08llx\n", h2 >> 16);
    // printf("%08llx\n", h2);
    carry1 = (h1 + (int64_t)(1L << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 * ((uint64_t) 1L << 25);
    // printf("%08llx\n", h2 & 0xffff);
    // printf("%08llx\n", h2 >> 16);
    // printf("%08llx\n", h2);

    // printf("\nh4 _______________________________\n");
    // printf("%08llx\n", h4 & 0xffff);
    // printf("%08llx\n", h4 >> 16);
    // printf("%08llx\n", h4);
    carry3 = (h3 + (int64_t)(1L << 24)) >> 25;
    h4 += carry3;
    printf("%08llx\n", carry3);
    h3 -= carry3 * ((uint64_t) 1L << 25);
    // printf("%08llx\n", h4 & 0xffff);
    // printf("%08llx\n", h4 >> 16);
    // printf("%08llx\n", h4);
    
    // printf("\nh6 _______________________________\n");
    // printf("%08llx\n", h6 & 0xffff);
    // printf("%08llx\n", h6 >> 16);
    // printf("%08llx\n", h6);
    carry5 = (h5 + (int64_t)(1L << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 * ((uint64_t) 1L << 25);
    // printf("%08llx\n", h6 & 0xffff);
    // printf("%08llx\n", h6 >> 16);
    // printf("%08llx\n", h6);

    // printf("\nh8 _______________________________\n");
    // printf("%08llx\n", h8 & 0xffff);
    // printf("%08llx\n", h8 >> 16);
    // printf("%08llx\n", h8);
    carry7 = (h7 + (int64_t)(1L << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 * ((uint64_t) 1L << 25);
    // printf("%08llx\n", h8 & 0xffff);
    // printf("%08llx\n", h8 >> 16);
    // printf("%08llx\n", h8);


    // printf("carry5 %016llx\n", carry5);
    // printf("h6 %016llx\n", h6);
    // printf("h7 %016llx\n", h7);

    // printf("\nh1 _______________________________\n");
    // printf("%08llx\n", h1 & 0xffff);
    // printf("%08llx\n", h1 >> 16);
    // printf("%08llx\n", h1);
    carry0 = (h0 + (int64_t)(1L << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 * ((uint64_t) 1L << 26);
    // printf("%08llx\n", h1 & 0xffff);
    // printf("%08llx\n", h1 >> 16);
    // printf("%08llx\n", h1);

    // printf("\nh3 _______________________________\n");
    // printf("%08llx\n", h3 & 0xffff);
    // printf("%08llx\n", h3 >> 16);
    // printf("%08llx\n", h3);
    carry2 = (h2 + (int64_t)(1L << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 * ((uint64_t) 1L << 26);
    // printf("%08llx\n", h3 & 0xffff);
    // printf("%08llx\n", h3 >> 16);
    // printf("%08llx\n", h3);

    // printf("\nh5 _______________________________\n");
    // printf("%08llx\n", h5 & 0xffff);
    // printf("%08llx\n", h5 >> 16);
    // printf("%08llx\n", h5);
    carry4 = (h4 + (int64_t)(1L << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 * ((uint64_t) 1L << 26);
    // printf("%08llx\n", h5 & 0xffff);
    // printf("%08llx\n", h5 >> 16);
    // printf("%08llx\n", h5);

    // printf("\nh7 _______________________________\n");
    // printf("%08llx\n", h7 & 0xffff);
    // printf("%08llx\n", h7 >> 16);
    // printf("%08llx\n", h7);
    carry6 = (h6 + (int64_t)(1L << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 * ((uint64_t) 1L << 26);
    // printf("%08llx\n", h7 & 0xffff);
    // printf("%08llx\n", h7 >> 16);
    // printf("%08llx\n", h7);

    // printf("\nh9 _______________________________\n");
    // printf("%08llx\n", h9 & 0xffff);
    // printf("%08llx\n", h9 >> 16);
    // printf("%08llx\n", h9);
    carry8 = (h8 + (int64_t)(1L << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 * ((uint64_t) 1L << 26);
    // printf("%08llx\n", h9 & 0xffff);
    // printf("%08llx\n", h9 >> 16);
    // printf("%08llx\n", h9);

    printf("h0 %08llx\n", h0);
    printf("h1 %08llx\n", h1);
    printf("h2 %08llx\n", h2);
    printf("h3 %08llx\n", h3);
    printf("h4 %08llx\n", h4);
    printf("h5 %08llx\n", h5);
    printf("h6 %08llx\n", h6);
    printf("h7 %08llx\n", h7);
    printf("h8 %08llx\n", h8);
    printf("h9 %08llx\n", h9);

    h[0] = (int32_t) h0;
    h[1] = (int32_t) h1;
    h[2] = (int32_t) h2;
    h[3] = (int32_t) h3;
    h[4] = (int32_t) h4;
    h[5] = (int32_t) h5;
    h[6] = (int32_t) h6;
    h[7] = (int32_t) h7;
    h[8] = (int32_t) h8;
    h[9] = (int32_t) h9;
}

/*
 Preconditions:
 |h| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.

 Write p=2^255-19; q=floor(h/p).
 Basic claim: q = floor(2^(-255)(h + 19 2^(-25)h9 + 2^(-1))).

 Proof:
 Have |h|<=p so |q|<=1 so |19^2 2^(-255) q|<1/4.
 Also have |h-2^230 h9|<2^231 so |19 2^(-255)(h-2^230 h9)|<1/4.

 Write y=2^(-1)-19^2 2^(-255)q-19 2^(-255)(h-2^230 h9).
 Then 0<y<1.

 Write r=h-pq.
 Have 0<=r<=p-1=2^255-20.
 Thus 0<=r+19(2^-255)r<r+19(2^-255)2^255<=2^255-1.

 Write x=r+19(2^-255)r+y.
 Then 0<x<2^255 so floor(2^(-255)x) = 0 so floor(q+2^(-255)x) = q.

 Have q+2^(-255)x = 2^(-255)(h + 19 2^(-25) h9 + 2^(-1))
 so floor(2^(-255)(h + 19 2^(-25) h9 + 2^(-1))) = q.
*/

static void
fe25519_reduce(fe25519 h, const fe25519 f)
{
    int32_t h0 = f[0];
    int32_t h1 = f[1];
    int32_t h2 = f[2];
    int32_t h3 = f[3];
    int32_t h4 = f[4];
    int32_t h5 = f[5];
    int32_t h6 = f[6];
    int32_t h7 = f[7];
    int32_t h8 = f[8];
    int32_t h9 = f[9];

    int32_t q;
    int32_t carry0, carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8, carry9;

    q = (19 * h9 + ((uint32_t) 1L << 24)) >> 25;
    q = (h0 + q) >> 26;
    q = (h1 + q) >> 25;
    q = (h2 + q) >> 26;
    q = (h3 + q) >> 25;
    q = (h4 + q) >> 26;
    q = (h5 + q) >> 25;
    q = (h6 + q) >> 26;
    q = (h7 + q) >> 25;
    q = (h8 + q) >> 26;
    q = (h9 + q) >> 25;

    /* Goal: Output h-(2^255-19)q, which is between 0 and 2^255-20. */
    h0 += 19 * q;
    /* Goal: Output h-2^255 q, which is between 0 and 2^255-20. */

    carry0 = h0 >> 26;
    h1 += carry0;
    h0 -= carry0 * ((uint32_t) 1L << 26);
    carry1 = h1 >> 25;
    h2 += carry1;
    h1 -= carry1 * ((uint32_t) 1L << 25);
    carry2 = h2 >> 26;
    h3 += carry2;
    h2 -= carry2 * ((uint32_t) 1L << 26);
    carry3 = h3 >> 25;
    h4 += carry3;
    h3 -= carry3 * ((uint32_t) 1L << 25);
    carry4 = h4 >> 26;
    h5 += carry4;
    h4 -= carry4 * ((uint32_t) 1L << 26);
    carry5 = h5 >> 25;
    h6 += carry5;
    h5 -= carry5 * ((uint32_t) 1L << 25);
    carry6 = h6 >> 26;
    h7 += carry6;
    h6 -= carry6 * ((uint32_t) 1L << 26);
    carry7 = h7 >> 25;
    h8 += carry7;
    h7 -= carry7 * ((uint32_t) 1L << 25);
    carry8 = h8 >> 26;
    h9 += carry8;
    h8 -= carry8 * ((uint32_t) 1L << 26);
    carry9 = h9 >> 25;
    h9 -= carry9 * ((uint32_t) 1L << 25);

    h[0] = h0;
    h[1] = h1;
    h[2] = h2;
    h[3] = h3;
    h[4] = h4;
    h[5] = h5;
    h[6] = h6;
    h[7] = h7;
    h[8] = h8;
    h[9] = h9;
}

/*
 Goal: Output h0+...+2^255 h10-2^255 q, which is between 0 and 2^255-20.
 Have h0+...+2^230 h9 between 0 and 2^255-1;
 evidently 2^255 h10-2^255 q = 0.

 Goal: Output h0+...+2^230 h9.
 */

void
fe25519_tobytes(unsigned char *s, const fe25519 h)
{
    fe25519 t;

    fe25519_reduce(t, h);
    s[0]  = t[0] >> 0;
    s[1]  = t[0] >> 8;
    s[2]  = t[0] >> 16;
    s[3]  = (t[0] >> 24) | (t[1] * ((uint32_t) 1 << 2));
    s[4]  = t[1] >> 6;
    s[5]  = t[1] >> 14;
    s[6]  = (t[1] >> 22) | (t[2] * ((uint32_t) 1 << 3));
    s[7]  = t[2] >> 5;
    s[8]  = t[2] >> 13;
    s[9]  = (t[2] >> 21) | (t[3] * ((uint32_t) 1 << 5));
    s[10] = t[3] >> 3;
    s[11] = t[3] >> 11;
    s[12] = (t[3] >> 19) | (t[4] * ((uint32_t) 1 << 6));
    s[13] = t[4] >> 2;
    s[14] = t[4] >> 10;
    s[15] = t[4] >> 18;
    s[16] = t[5] >> 0;
    s[17] = t[5] >> 8;
    s[18] = t[5] >> 16;
    s[19] = (t[5] >> 24) | (t[6] * ((uint32_t) 1 << 1));
    s[20] = t[6] >> 7;
    s[21] = t[6] >> 15;
    s[22] = (t[6] >> 23) | (t[7] * ((uint32_t) 1 << 3));
    s[23] = t[7] >> 5;
    s[24] = t[7] >> 13;
    s[25] = (t[7] >> 21) | (t[8] * ((uint32_t) 1 << 4));
    s[26] = t[8] >> 4;
    s[27] = t[8] >> 12;
    s[28] = (t[8] >> 20) | (t[9] * ((uint32_t) 1 << 6));
    s[29] = t[9] >> 2;
    s[30] = t[9] >> 10;
    s[31] = t[9] >> 18;
}

/*
 h = 0
 */

static inline void
fe25519_0(fe25519 h)
{
    memset(&h[0], 0, 10 * sizeof h[0]);
}

/*
 h = 1
 */

static inline void
fe25519_1(fe25519 h)
{
    h[0] = 1;
    h[1] = 0;
    memset(&h[2], 0, 8 * sizeof h[0]);
}

/*
 h = f + g
 Can overlap h with f or g.
 *
 Preconditions:
 |f| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
 |g| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
 *
 Postconditions:
 |h| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.
 */

static inline void
fe25519_add(fe25519 h, const fe25519 f, const fe25519 g)
{
    int32_t h0 = f[0] + g[0];
    int32_t h1 = f[1] + g[1];
    int32_t h2 = f[2] + g[2];
    int32_t h3 = f[3] + g[3];
    int32_t h4 = f[4] + g[4];
    int32_t h5 = f[5] + g[5];
    int32_t h6 = f[6] + g[6];
    int32_t h7 = f[7] + g[7];
    int32_t h8 = f[8] + g[8];
    int32_t h9 = f[9] + g[9];

    h[0] = h0;
    h[1] = h1;
    h[2] = h2;
    h[3] = h3;
    h[4] = h4;
    h[5] = h5;
    h[6] = h6;
    h[7] = h7;
    h[8] = h8;
    h[9] = h9;
}

/*
 h = f - g
 Can overlap h with f or g.
 *
 Preconditions:
 |f| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
 |g| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
 *
 Postconditions:
 |h| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.
 */

static void
fe25519_sub(fe25519 h, const fe25519 f, const fe25519 g)
{
    int32_t h0 = f[0] - g[0];
    int32_t h1 = f[1] - g[1];
    int32_t h2 = f[2] - g[2];
    int32_t h3 = f[3] - g[3];
    int32_t h4 = f[4] - g[4];
    int32_t h5 = f[5] - g[5];
    int32_t h6 = f[6] - g[6];
    int32_t h7 = f[7] - g[7];
    int32_t h8 = f[8] - g[8];
    int32_t h9 = f[9] - g[9];

    h[0] = h0;
    h[1] = h1;
    h[2] = h2;
    h[3] = h3;
    h[4] = h4;
    h[5] = h5;
    h[6] = h6;
    h[7] = h7;
    h[8] = h8;
    h[9] = h9;
}

/*
 h = -f
 *
 Preconditions:
 |f| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
 *
 Postconditions:
 |h| bounded by 1.1*2^25,1.1*2^24,1.1*2^25,1.1*2^24,etc.
 */

static inline void
fe25519_neg(fe25519 h, const fe25519 f)
{
    int32_t h0 = -f[0];
    int32_t h1 = -f[1];
    int32_t h2 = -f[2];
    int32_t h3 = -f[3];
    int32_t h4 = -f[4];
    int32_t h5 = -f[5];
    int32_t h6 = -f[6];
    int32_t h7 = -f[7];
    int32_t h8 = -f[8];
    int32_t h9 = -f[9];

    h[0] = h0;
    h[1] = h1;
    h[2] = h2;
    h[3] = h3;
    h[4] = h4;
    h[5] = h5;
    h[6] = h6;
    h[7] = h7;
    h[8] = h8;
    h[9] = h9;
}

/*
 Replace (f,g) with (g,g) if b == 1;
 replace (f,g) with (f,g) if b == 0.
 *
 Preconditions: b in {0,1}.
 */

static void
fe25519_cmov(fe25519 f, const fe25519 g, unsigned int b)
{
    uint32_t mask = (uint32_t) (-(int32_t) b);
    int32_t  f0, f1, f2, f3, f4, f5, f6, f7, f8, f9;
    int32_t  x0, x1, x2, x3, x4, x5, x6, x7, x8, x9;

    f0 = f[0];
    f1 = f[1];
    f2 = f[2];
    f3 = f[3];
    f4 = f[4];
    f5 = f[5];
    f6 = f[6];
    f7 = f[7];
    f8 = f[8];
    f9 = f[9];

    x0 = f0 ^ g[0];
    x1 = f1 ^ g[1];
    x2 = f2 ^ g[2];
    x3 = f3 ^ g[3];
    x4 = f4 ^ g[4];
    x5 = f5 ^ g[5];
    x6 = f6 ^ g[6];
    x7 = f7 ^ g[7];
    x8 = f8 ^ g[8];
    x9 = f9 ^ g[9];

#ifdef HAVE_INLINE_ASM
    __asm__ __volatile__("" : "+r"(mask));
#endif

    x0 &= mask;
    x1 &= mask;
    x2 &= mask;
    x3 &= mask;
    x4 &= mask;
    x5 &= mask;
    x6 &= mask;
    x7 &= mask;
    x8 &= mask;
    x9 &= mask;

    f[0] = f0 ^ x0;
    f[1] = f1 ^ x1;
    f[2] = f2 ^ x2;
    f[3] = f3 ^ x3;
    f[4] = f4 ^ x4;
    f[5] = f5 ^ x5;
    f[6] = f6 ^ x6;
    f[7] = f7 ^ x7;
    f[8] = f8 ^ x8;
    f[9] = f9 ^ x9;
}

static void
fe25519_cswap(fe25519 f, fe25519 g, unsigned int b)
{
    uint32_t mask = (uint32_t) (-(int64_t) b);
    int32_t  f0, f1, f2, f3, f4, f5, f6, f7, f8, f9;
    int32_t  g0, g1, g2, g3, g4, g5, g6, g7, g8, g9;
    int32_t  x0, x1, x2, x3, x4, x5, x6, x7, x8, x9;

    f0 = f[0];
    f1 = f[1];
    f2 = f[2];
    f3 = f[3];
    f4 = f[4];
    f5 = f[5];
    f6 = f[6];
    f7 = f[7];
    f8 = f[8];
    f9 = f[9];

    g0 = g[0];
    g1 = g[1];
    g2 = g[2];
    g3 = g[3];
    g4 = g[4];
    g5 = g[5];
    g6 = g[6];
    g7 = g[7];
    g8 = g[8];
    g9 = g[9];

    x0 = f0 ^ g0;
    x1 = f1 ^ g1;
    x2 = f2 ^ g2;
    x3 = f3 ^ g3;
    x4 = f4 ^ g4;
    x5 = f5 ^ g5;
    x6 = f6 ^ g6;
    x7 = f7 ^ g7;
    x8 = f8 ^ g8;
    x9 = f9 ^ g9;

#ifdef HAVE_INLINE_ASM
    __asm__ __volatile__("" : "+r"(mask));
#endif

    x0 &= mask;
    x1 &= mask;
    x2 &= mask;
    x3 &= mask;
    x4 &= mask;
    x5 &= mask;
    x6 &= mask;
    x7 &= mask;
    x8 &= mask;
    x9 &= mask;

    f[0] = f0 ^ x0;
    f[1] = f1 ^ x1;
    f[2] = f2 ^ x2;
    f[3] = f3 ^ x3;
    f[4] = f4 ^ x4;
    f[5] = f5 ^ x5;
    f[6] = f6 ^ x6;
    f[7] = f7 ^ x7;
    f[8] = f8 ^ x8;
    f[9] = f9 ^ x9;

    g[0] = g0 ^ x0;
    g[1] = g1 ^ x1;
    g[2] = g2 ^ x2;
    g[3] = g3 ^ x3;
    g[4] = g4 ^ x4;
    g[5] = g5 ^ x5;
    g[6] = g6 ^ x6;
    g[7] = g7 ^ x7;
    g[8] = g8 ^ x8;
    g[9] = g9 ^ x9;
}

/*
 h = f
 */

static inline void
fe25519_copy(fe25519 h, const fe25519 f)
{
    memcpy(h, f, 10 * 4);
}


static inline void
fe25519_cneg(fe25519 h, const fe25519 f, unsigned int b)
{
    fe25519 negf;
    unsigned char res[32];
    unsigned char hex[32];

    fe25519_neg(negf, f);
    fe25519_copy(h, f);
    fe25519_cmov(h, negf, b);

    printf("%s\n", hex);
    
}

/*
 return 1 if f is in {1,3,5,...,q-2}
 return 0 if f is in {0,2,4,...,q-1}

 Preconditions:
 |f| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.
 */

static inline int
fe25519_isnegative(const fe25519 f)
{
    unsigned char s[32];

    fe25519_tobytes(s, f);

    return s[0] & 1;
}

/*
 return 1 if f == 0
 return 0 if f != 0

 Preconditions:
 |f| bounded by 1.1*2^26,1.1*2^25,1.1*2^26,1.1*2^25,etc.
 */

static inline int
fe25519_iszero(const fe25519 f)
{
    unsigned char s[32];

    fe25519_tobytes(s, f);

    return sodium_is_zero(s, 32);
}

void
sc25519_mul(unsigned char s[32], const unsigned char a[32], const unsigned char b[32])
{
    int64_t a0  = 2097151 & load_3(a);
    int64_t a1  = 2097151 & (load_4(a + 2) >> 5);
    int64_t a2  = 2097151 & (load_3(a + 5) >> 2);
    int64_t a3  = 2097151 & (load_4(a + 7) >> 7);
    int64_t a4  = 2097151 & (load_4(a + 10) >> 4);
    int64_t a5  = 2097151 & (load_3(a + 13) >> 1);
    int64_t a6  = 2097151 & (load_4(a + 15) >> 6);
    int64_t a7  = 2097151 & (load_3(a + 18) >> 3);
    int64_t a8  = 2097151 & load_3(a + 21);
    int64_t a9  = 2097151 & (load_4(a + 23) >> 5);
    int64_t a10 = 2097151 & (load_3(a + 26) >> 2);
    int64_t a11 = (load_4(a + 28) >> 7);

    int64_t b0  = 2097151 & load_3(b);
    int64_t b1  = 2097151 & (load_4(b + 2) >> 5);
    int64_t b2  = 2097151 & (load_3(b + 5) >> 2);
    int64_t b3  = 2097151 & (load_4(b + 7) >> 7);
    int64_t b4  = 2097151 & (load_4(b + 10) >> 4);
    int64_t b5  = 2097151 & (load_3(b + 13) >> 1);
    int64_t b6  = 2097151 & (load_4(b + 15) >> 6);
    int64_t b7  = 2097151 & (load_3(b + 18) >> 3);
    int64_t b8  = 2097151 & load_3(b + 21);
    int64_t b9  = 2097151 & (load_4(b + 23) >> 5);
    int64_t b10 = 2097151 & (load_3(b + 26) >> 2);
    int64_t b11 = (load_4(b + 28) >> 7);

    int64_t s0;
    int64_t s1;
    int64_t s2;
    int64_t s3;
    int64_t s4;
    int64_t s5;
    int64_t s6;
    int64_t s7;
    int64_t s8;
    int64_t s9;
    int64_t s10;
    int64_t s11;
    int64_t s12;
    int64_t s13;
    int64_t s14;
    int64_t s15;
    int64_t s16;
    int64_t s17;
    int64_t s18;
    int64_t s19;
    int64_t s20;
    int64_t s21;
    int64_t s22;
    int64_t s23;

    int64_t carry0;
    int64_t carry1;
    int64_t carry2;
    int64_t carry3;
    int64_t carry4;
    int64_t carry5;
    int64_t carry6;
    int64_t carry7;
    int64_t carry8;
    int64_t carry9;
    int64_t carry10;
    int64_t carry11;
    int64_t carry12;
    int64_t carry13;
    int64_t carry14;
    int64_t carry15;
    int64_t carry16;
    int64_t carry17;
    int64_t carry18;
    int64_t carry19;
    int64_t carry20;
    int64_t carry21;
    int64_t carry22;

    s0 = a0 * b0;
    s1 = a0 * b1 + a1 * b0;
    s2 = a0 * b2 + a1 * b1 + a2 * b0;
    s3 = a0 * b3 + a1 * b2 + a2 * b1 + a3 * b0;
    s4 = a0 * b4 + a1 * b3 + a2 * b2 + a3 * b1 + a4 * b0;
    s5 = a0 * b5 + a1 * b4 + a2 * b3 + a3 * b2 + a4 * b1 + a5 * b0;
    s6 = a0 * b6 + a1 * b5 + a2 * b4 + a3 * b3 + a4 * b2 + a5 * b1 + a6 * b0;
    s7 = a0 * b7 + a1 * b6 + a2 * b5 + a3 * b4 + a4 * b3 + a5 * b2 +
         a6 * b1 + a7 * b0;
    s8 = a0 * b8 + a1 * b7 + a2 * b6 + a3 * b5 + a4 * b4 + a5 * b3 +
         a6 * b2 + a7 * b1 + a8 * b0;
    s9 = a0 * b9 + a1 * b8 + a2 * b7 + a3 * b6 + a4 * b5 + a5 * b4 +
         a6 * b3 + a7 * b2 + a8 * b1 + a9 * b0;
    s10 = a0 * b10 + a1 * b9 + a2 * b8 + a3 * b7 + a4 * b6 + a5 * b5 +
          a6 * b4 + a7 * b3 + a8 * b2 + a9 * b1 + a10 * b0;
    s11 = a0 * b11 + a1 * b10 + a2 * b9 + a3 * b8 + a4 * b7 + a5 * b6 +
          a6 * b5 + a7 * b4 + a8 * b3 + a9 * b2 + a10 * b1 + a11 * b0;
    s12 = a1 * b11 + a2 * b10 + a3 * b9 + a4 * b8 + a5 * b7 + a6 * b6 +
          a7 * b5 + a8 * b4 + a9 * b3 + a10 * b2 + a11 * b1;
    s13 = a2 * b11 + a3 * b10 + a4 * b9 + a5 * b8 + a6 * b7 + a7 * b6 +
          a8 * b5 + a9 * b4 + a10 * b3 + a11 * b2;
    s14 = a3 * b11 + a4 * b10 + a5 * b9 + a6 * b8 + a7 * b7 + a8 * b6 +
          a9 * b5 + a10 * b4 + a11 * b3;
    s15 = a4 * b11 + a5 * b10 + a6 * b9 + a7 * b8 + a8 * b7 + a9 * b6 +
          a10 * b5 + a11 * b4;
    s16 =
        a5 * b11 + a6 * b10 + a7 * b9 + a8 * b8 + a9 * b7 + a10 * b6 + a11 * b5;
    s17 = a6 * b11 + a7 * b10 + a8 * b9 + a9 * b8 + a10 * b7 + a11 * b6;
    s18 = a7 * b11 + a8 * b10 + a9 * b9 + a10 * b8 + a11 * b7;
    s19 = a8 * b11 + a9 * b10 + a10 * b9 + a11 * b8;
    s20 = a9 * b11 + a10 * b10 + a11 * b9;
    s21 = a10 * b11 + a11 * b10;
    s22 = a11 * b11;
    s23 = 0;

    carry0 = (s0 + (int64_t) (1L << 20)) >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry2 = (s2 + (int64_t) (1L << 20)) >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry4 = (s4 + (int64_t) (1L << 20)) >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);
    carry12 = (s12 + (int64_t) (1L << 20)) >> 21;
    s13 += carry12;
    s12 -= carry12 * ((uint64_t) 1L << 21);
    carry14 = (s14 + (int64_t) (1L << 20)) >> 21;
    s15 += carry14;
    s14 -= carry14 * ((uint64_t) 1L << 21);
    carry16 = (s16 + (int64_t) (1L << 20)) >> 21;
    s17 += carry16;
    s16 -= carry16 * ((uint64_t) 1L << 21);
    carry18 = (s18 + (int64_t) (1L << 20)) >> 21;
    s19 += carry18;
    s18 -= carry18 * ((uint64_t) 1L << 21);
    carry20 = (s20 + (int64_t) (1L << 20)) >> 21;
    s21 += carry20;
    s20 -= carry20 * ((uint64_t) 1L << 21);
    carry22 = (s22 + (int64_t) (1L << 20)) >> 21;
    s23 += carry22;
    s22 -= carry22 * ((uint64_t) 1L << 21);

    carry1 = (s1 + (int64_t) (1L << 20)) >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry3 = (s3 + (int64_t) (1L << 20)) >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry5 = (s5 + (int64_t) (1L << 20)) >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);
    carry13 = (s13 + (int64_t) (1L << 20)) >> 21;
    s14 += carry13;
    s13 -= carry13 * ((uint64_t) 1L << 21);
    carry15 = (s15 + (int64_t) (1L << 20)) >> 21;
    s16 += carry15;
    s15 -= carry15 * ((uint64_t) 1L << 21);
    carry17 = (s17 + (int64_t) (1L << 20)) >> 21;
    s18 += carry17;
    s17 -= carry17 * ((uint64_t) 1L << 21);
    carry19 = (s19 + (int64_t) (1L << 20)) >> 21;
    s20 += carry19;
    s19 -= carry19 * ((uint64_t) 1L << 21);
    carry21 = (s21 + (int64_t) (1L << 20)) >> 21;
    s22 += carry21;
    s21 -= carry21 * ((uint64_t) 1L << 21);

    s11 += s23 * 666643;
    s12 += s23 * 470296;
    s13 += s23 * 654183;
    s14 -= s23 * 997805;
    s15 += s23 * 136657;
    s16 -= s23 * 683901;

    s10 += s22 * 666643;
    s11 += s22 * 470296;
    s12 += s22 * 654183;
    s13 -= s22 * 997805;
    s14 += s22 * 136657;
    s15 -= s22 * 683901;

    s9 += s21 * 666643;
    s10 += s21 * 470296;
    s11 += s21 * 654183;
    s12 -= s21 * 997805;
    s13 += s21 * 136657;
    s14 -= s21 * 683901;

    s8 += s20 * 666643;
    s9 += s20 * 470296;
    s10 += s20 * 654183;
    s11 -= s20 * 997805;
    s12 += s20 * 136657;
    s13 -= s20 * 683901;

    s7 += s19 * 666643;
    s8 += s19 * 470296;
    s9 += s19 * 654183;
    s10 -= s19 * 997805;
    s11 += s19 * 136657;
    s12 -= s19 * 683901;

    s6 += s18 * 666643;
    s7 += s18 * 470296;
    s8 += s18 * 654183;
    s9 -= s18 * 997805;
    s10 += s18 * 136657;
    s11 -= s18 * 683901;

    carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);
    carry12 = (s12 + (int64_t) (1L << 20)) >> 21;
    s13 += carry12;
    s12 -= carry12 * ((uint64_t) 1L << 21);
    carry14 = (s14 + (int64_t) (1L << 20)) >> 21;
    s15 += carry14;
    s14 -= carry14 * ((uint64_t) 1L << 21);
    carry16 = (s16 + (int64_t) (1L << 20)) >> 21;
    s17 += carry16;
    s16 -= carry16 * ((uint64_t) 1L << 21);

    carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);
    carry13 = (s13 + (int64_t) (1L << 20)) >> 21;
    s14 += carry13;
    s13 -= carry13 * ((uint64_t) 1L << 21);
    carry15 = (s15 + (int64_t) (1L << 20)) >> 21;
    s16 += carry15;
    s15 -= carry15 * ((uint64_t) 1L << 21);

    s5 += s17 * 666643;
    s6 += s17 * 470296;
    s7 += s17 * 654183;
    s8 -= s17 * 997805;
    s9 += s17 * 136657;
    s10 -= s17 * 683901;

    s4 += s16 * 666643;
    s5 += s16 * 470296;
    s6 += s16 * 654183;
    s7 -= s16 * 997805;
    s8 += s16 * 136657;
    s9 -= s16 * 683901;

    s3 += s15 * 666643;
    s4 += s15 * 470296;
    s5 += s15 * 654183;
    s6 -= s15 * 997805;
    s7 += s15 * 136657;
    s8 -= s15 * 683901;

    s2 += s14 * 666643;
    s3 += s14 * 470296;
    s4 += s14 * 654183;
    s5 -= s14 * 997805;
    s6 += s14 * 136657;
    s7 -= s14 * 683901;

    s1 += s13 * 666643;
    s2 += s13 * 470296;
    s3 += s13 * 654183;
    s4 -= s13 * 997805;
    s5 += s13 * 136657;
    s6 -= s13 * 683901;

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;
    s12 = 0;

    carry0 = (s0 + (int64_t) (1L << 20)) >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry2 = (s2 + (int64_t) (1L << 20)) >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry4 = (s4 + (int64_t) (1L << 20)) >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);

    carry1 = (s1 + (int64_t) (1L << 20)) >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry3 = (s3 + (int64_t) (1L << 20)) >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry5 = (s5 + (int64_t) (1L << 20)) >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;
    s12 = 0;

    carry0 = s0 >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry1 = s1 >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry2 = s2 >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry3 = s3 >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry4 = s4 >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry5 = s5 >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry6 = s6 >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry7 = s7 >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry8 = s8 >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry9 = s9 >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry10 = s10 >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);
    carry11 = s11 >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;

    carry0 = s0 >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry1 = s1 >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry2 = s2 >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry3 = s3 >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry4 = s4 >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry5 = s5 >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry6 = s6 >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry7 = s7 >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry8 = s8 >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry9 = s9 >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry10 = s10 >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);

    s[0]  = s0 >> 0;
    s[1]  = s0 >> 8;
    s[2]  = (s0 >> 16) | (s1 * ((uint64_t) 1 << 5));
    s[3]  = s1 >> 3;
    s[4]  = s1 >> 11;
    s[5]  = (s1 >> 19) | (s2 * ((uint64_t) 1 << 2));
    s[6]  = s2 >> 6;
    s[7]  = (s2 >> 14) | (s3 * ((uint64_t) 1 << 7));
    s[8]  = s3 >> 1;
    s[9]  = s3 >> 9;
    s[10] = (s3 >> 17) | (s4 * ((uint64_t) 1 << 4));
    s[11] = s4 >> 4;
    s[12] = s4 >> 12;
    s[13] = (s4 >> 20) | (s5 * ((uint64_t) 1 << 1));
    s[14] = s5 >> 7;
    s[15] = (s5 >> 15) | (s6 * ((uint64_t) 1 << 6));
    s[16] = s6 >> 2;
    s[17] = s6 >> 10;
    s[18] = (s6 >> 18) | (s7 * ((uint64_t) 1 << 3));
    s[19] = s7 >> 5;
    s[20] = s7 >> 13;
    s[21] = s8 >> 0;
    s[22] = s8 >> 8;
    s[23] = (s8 >> 16) | (s9 * ((uint64_t) 1 << 5));
    s[24] = s9 >> 3;
    s[25] = s9 >> 11;
    s[26] = (s9 >> 19) | (s10 * ((uint64_t) 1 << 2));
    s[27] = s10 >> 6;
    s[28] = (s10 >> 14) | (s11 * ((uint64_t) 1 << 7));
    s[29] = s11 >> 1;
    s[30] = s11 >> 9;
    s[31] = s11 >> 17;
}

void
sc25519_sq(unsigned char *s, const unsigned char *a)
{
    sc25519_mul(s, a, a);
}

void
sc25519_sqmul(unsigned char s[32], const int n, const unsigned char a[32])
{   
    int i;

    for (i = 0; i < n; i++) {
        sc25519_sq(s, s);
    }
    sc25519_mul(s, s, a);
}

void
sc25519_muladd(unsigned char s[32], const unsigned char a[32],
               const unsigned char b[32], const unsigned char c[32])
{
    int64_t a0  = 2097151 & load_3(a);
    int64_t a1  = 2097151 & (load_4(a + 2) >> 5);
    int64_t a2  = 2097151 & (load_3(a + 5) >> 2);
    int64_t a3  = 2097151 & (load_4(a + 7) >> 7);
    int64_t a4  = 2097151 & (load_4(a + 10) >> 4);
    int64_t a5  = 2097151 & (load_3(a + 13) >> 1);
    int64_t a6  = 2097151 & (load_4(a + 15) >> 6);
    int64_t a7  = 2097151 & (load_3(a + 18) >> 3);
    int64_t a8  = 2097151 & load_3(a + 21);
    int64_t a9  = 2097151 & (load_4(a + 23) >> 5);
    int64_t a10 = 2097151 & (load_3(a + 26) >> 2);
    int64_t a11 = (load_4(a + 28) >> 7);

    int64_t b0  = 2097151 & load_3(b);
    int64_t b1  = 2097151 & (load_4(b + 2) >> 5);
    int64_t b2  = 2097151 & (load_3(b + 5) >> 2);
    int64_t b3  = 2097151 & (load_4(b + 7) >> 7);
    int64_t b4  = 2097151 & (load_4(b + 10) >> 4);
    int64_t b5  = 2097151 & (load_3(b + 13) >> 1);
    int64_t b6  = 2097151 & (load_4(b + 15) >> 6);
    int64_t b7  = 2097151 & (load_3(b + 18) >> 3);
    int64_t b8  = 2097151 & load_3(b + 21);
    int64_t b9  = 2097151 & (load_4(b + 23) >> 5);
    int64_t b10 = 2097151 & (load_3(b + 26) >> 2);
    int64_t b11 = (load_4(b + 28) >> 7);

    int64_t c0  = 2097151 & load_3(c);
    int64_t c1  = 2097151 & (load_4(c + 2) >> 5);
    int64_t c2  = 2097151 & (load_3(c + 5) >> 2);
    int64_t c3  = 2097151 & (load_4(c + 7) >> 7);
    int64_t c4  = 2097151 & (load_4(c + 10) >> 4);
    int64_t c5  = 2097151 & (load_3(c + 13) >> 1);
    int64_t c6  = 2097151 & (load_4(c + 15) >> 6);
    int64_t c7  = 2097151 & (load_3(c + 18) >> 3);
    int64_t c8  = 2097151 & load_3(c + 21);
    int64_t c9  = 2097151 & (load_4(c + 23) >> 5);
    int64_t c10 = 2097151 & (load_3(c + 26) >> 2);
    int64_t c11 = (load_4(c + 28) >> 7);

    int64_t s0;
    int64_t s1;
    int64_t s2;
    int64_t s3;
    int64_t s4;
    int64_t s5;
    int64_t s6;
    int64_t s7;
    int64_t s8;
    int64_t s9;
    int64_t s10;
    int64_t s11;
    int64_t s12;
    int64_t s13;
    int64_t s14;
    int64_t s15;
    int64_t s16;
    int64_t s17;
    int64_t s18;
    int64_t s19;
    int64_t s20;
    int64_t s21;
    int64_t s22;
    int64_t s23;

    int64_t carry0;
    int64_t carry1;
    int64_t carry2;
    int64_t carry3;
    int64_t carry4;
    int64_t carry5;
    int64_t carry6;
    int64_t carry7;
    int64_t carry8;
    int64_t carry9;
    int64_t carry10;
    int64_t carry11;
    int64_t carry12;
    int64_t carry13;
    int64_t carry14;
    int64_t carry15;
    int64_t carry16;
    int64_t carry17;
    int64_t carry18;
    int64_t carry19;
    int64_t carry20;
    int64_t carry21;
    int64_t carry22;

    s0 = c0 + a0 * b0;
    s1 = c1 + a0 * b1 + a1 * b0;
    s2 = c2 + a0 * b2 + a1 * b1 + a2 * b0;
    s3 = c3 + a0 * b3 + a1 * b2 + a2 * b1 + a3 * b0;
    s4 = c4 + a0 * b4 + a1 * b3 + a2 * b2 + a3 * b1 + a4 * b0;
    s5 = c5 + a0 * b5 + a1 * b4 + a2 * b3 + a3 * b2 + a4 * b1 + a5 * b0;
    s6 = c6 + a0 * b6 + a1 * b5 + a2 * b4 + a3 * b3 + a4 * b2 + a5 * b1 +
         a6 * b0;
    s7 = c7 + a0 * b7 + a1 * b6 + a2 * b5 + a3 * b4 + a4 * b3 + a5 * b2 +
         a6 * b1 + a7 * b0;
    s8 = c8 + a0 * b8 + a1 * b7 + a2 * b6 + a3 * b5 + a4 * b4 + a5 * b3 +
         a6 * b2 + a7 * b1 + a8 * b0;
    s9 = c9 + a0 * b9 + a1 * b8 + a2 * b7 + a3 * b6 + a4 * b5 + a5 * b4 +
         a6 * b3 + a7 * b2 + a8 * b1 + a9 * b0;
    s10 = c10 + a0 * b10 + a1 * b9 + a2 * b8 + a3 * b7 + a4 * b6 + a5 * b5 +
          a6 * b4 + a7 * b3 + a8 * b2 + a9 * b1 + a10 * b0;
    s11 = c11 + a0 * b11 + a1 * b10 + a2 * b9 + a3 * b8 + a4 * b7 + a5 * b6 +
          a6 * b5 + a7 * b4 + a8 * b3 + a9 * b2 + a10 * b1 + a11 * b0;
    s12 = a1 * b11 + a2 * b10 + a3 * b9 + a4 * b8 + a5 * b7 + a6 * b6 +
          a7 * b5 + a8 * b4 + a9 * b3 + a10 * b2 + a11 * b1;
    s13 = a2 * b11 + a3 * b10 + a4 * b9 + a5 * b8 + a6 * b7 + a7 * b6 +
          a8 * b5 + a9 * b4 + a10 * b3 + a11 * b2;
    s14 = a3 * b11 + a4 * b10 + a5 * b9 + a6 * b8 + a7 * b7 + a8 * b6 +
          a9 * b5 + a10 * b4 + a11 * b3;
    s15 = a4 * b11 + a5 * b10 + a6 * b9 + a7 * b8 + a8 * b7 + a9 * b6 +
          a10 * b5 + a11 * b4;
    s16 =
        a5 * b11 + a6 * b10 + a7 * b9 + a8 * b8 + a9 * b7 + a10 * b6 + a11 * b5;
    s17 = a6 * b11 + a7 * b10 + a8 * b9 + a9 * b8 + a10 * b7 + a11 * b6;
    s18 = a7 * b11 + a8 * b10 + a9 * b9 + a10 * b8 + a11 * b7;
    s19 = a8 * b11 + a9 * b10 + a10 * b9 + a11 * b8;
    s20 = a9 * b11 + a10 * b10 + a11 * b9;
    s21 = a10 * b11 + a11 * b10;
    s22 = a11 * b11;
    s23 = 0;

    carry0 = (s0 + (int64_t) (1L << 20)) >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry2 = (s2 + (int64_t) (1L << 20)) >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry4 = (s4 + (int64_t) (1L << 20)) >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);
    carry12 = (s12 + (int64_t) (1L << 20)) >> 21;
    s13 += carry12;
    s12 -= carry12 * ((uint64_t) 1L << 21);
    carry14 = (s14 + (int64_t) (1L << 20)) >> 21;
    s15 += carry14;
    s14 -= carry14 * ((uint64_t) 1L << 21);
    carry16 = (s16 + (int64_t) (1L << 20)) >> 21;
    s17 += carry16;
    s16 -= carry16 * ((uint64_t) 1L << 21);
    carry18 = (s18 + (int64_t) (1L << 20)) >> 21;
    s19 += carry18;
    s18 -= carry18 * ((uint64_t) 1L << 21);
    carry20 = (s20 + (int64_t) (1L << 20)) >> 21;
    s21 += carry20;
    s20 -= carry20 * ((uint64_t) 1L << 21);
    carry22 = (s22 + (int64_t) (1L << 20)) >> 21;
    s23 += carry22;
    s22 -= carry22 * ((uint64_t) 1L << 21);

    carry1 = (s1 + (int64_t) (1L << 20)) >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry3 = (s3 + (int64_t) (1L << 20)) >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry5 = (s5 + (int64_t) (1L << 20)) >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);
    carry13 = (s13 + (int64_t) (1L << 20)) >> 21;
    s14 += carry13;
    s13 -= carry13 * ((uint64_t) 1L << 21);
    carry15 = (s15 + (int64_t) (1L << 20)) >> 21;
    s16 += carry15;
    s15 -= carry15 * ((uint64_t) 1L << 21);
    carry17 = (s17 + (int64_t) (1L << 20)) >> 21;
    s18 += carry17;
    s17 -= carry17 * ((uint64_t) 1L << 21);
    carry19 = (s19 + (int64_t) (1L << 20)) >> 21;
    s20 += carry19;
    s19 -= carry19 * ((uint64_t) 1L << 21);
    carry21 = (s21 + (int64_t) (1L << 20)) >> 21;
    s22 += carry21;
    s21 -= carry21 * ((uint64_t) 1L << 21);

    s11 += s23 * 666643;
    s12 += s23 * 470296;
    s13 += s23 * 654183;
    s14 -= s23 * 997805;
    s15 += s23 * 136657;
    s16 -= s23 * 683901;

    s10 += s22 * 666643;
    s11 += s22 * 470296;
    s12 += s22 * 654183;
    s13 -= s22 * 997805;
    s14 += s22 * 136657;
    s15 -= s22 * 683901;

    s9 += s21 * 666643;
    s10 += s21 * 470296;
    s11 += s21 * 654183;
    s12 -= s21 * 997805;
    s13 += s21 * 136657;
    s14 -= s21 * 683901;

    s8 += s20 * 666643;
    s9 += s20 * 470296;
    s10 += s20 * 654183;
    s11 -= s20 * 997805;
    s12 += s20 * 136657;
    s13 -= s20 * 683901;

    s7 += s19 * 666643;
    s8 += s19 * 470296;
    s9 += s19 * 654183;
    s10 -= s19 * 997805;
    s11 += s19 * 136657;
    s12 -= s19 * 683901;

    s6 += s18 * 666643;
    s7 += s18 * 470296;
    s8 += s18 * 654183;
    s9 -= s18 * 997805;
    s10 += s18 * 136657;
    s11 -= s18 * 683901;

    carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);
    carry12 = (s12 + (int64_t) (1L << 20)) >> 21;
    s13 += carry12;
    s12 -= carry12 * ((uint64_t) 1L << 21);
    carry14 = (s14 + (int64_t) (1L << 20)) >> 21;
    s15 += carry14;
    s14 -= carry14 * ((uint64_t) 1L << 21);
    carry16 = (s16 + (int64_t) (1L << 20)) >> 21;
    s17 += carry16;
    s16 -= carry16 * ((uint64_t) 1L << 21);

    carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);
    carry13 = (s13 + (int64_t) (1L << 20)) >> 21;
    s14 += carry13;
    s13 -= carry13 * ((uint64_t) 1L << 21);
    carry15 = (s15 + (int64_t) (1L << 20)) >> 21;
    s16 += carry15;
    s15 -= carry15 * ((uint64_t) 1L << 21);

    s5 += s17 * 666643;
    s6 += s17 * 470296;
    s7 += s17 * 654183;
    s8 -= s17 * 997805;
    s9 += s17 * 136657;
    s10 -= s17 * 683901;

    s4 += s16 * 666643;
    s5 += s16 * 470296;
    s6 += s16 * 654183;
    s7 -= s16 * 997805;
    s8 += s16 * 136657;
    s9 -= s16 * 683901;

    s3 += s15 * 666643;
    s4 += s15 * 470296;
    s5 += s15 * 654183;
    s6 -= s15 * 997805;
    s7 += s15 * 136657;
    s8 -= s15 * 683901;

    s2 += s14 * 666643;
    s3 += s14 * 470296;
    s4 += s14 * 654183;
    s5 -= s14 * 997805;
    s6 += s14 * 136657;
    s7 -= s14 * 683901;

    s1 += s13 * 666643;
    s2 += s13 * 470296;
    s3 += s13 * 654183;
    s4 -= s13 * 997805;
    s5 += s13 * 136657;
    s6 -= s13 * 683901;

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;
    s12 = 0;

    carry0 = (s0 + (int64_t) (1L << 20)) >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry2 = (s2 + (int64_t) (1L << 20)) >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry4 = (s4 + (int64_t) (1L << 20)) >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);

    carry1 = (s1 + (int64_t) (1L << 20)) >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry3 = (s3 + (int64_t) (1L << 20)) >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry5 = (s5 + (int64_t) (1L << 20)) >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;
    s12 = 0;

    carry0 = s0 >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry1 = s1 >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry2 = s2 >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry3 = s3 >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry4 = s4 >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry5 = s5 >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry6 = s6 >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry7 = s7 >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry8 = s8 >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry9 = s9 >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry10 = s10 >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);
    carry11 = s11 >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;

    carry0 = s0 >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry1 = s1 >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry2 = s2 >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry3 = s3 >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry4 = s4 >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry5 = s5 >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry6 = s6 >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry7 = s7 >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry8 = s8 >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry9 = s9 >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry10 = s10 >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);

    s[0]  = s0 >> 0;
    s[1]  = s0 >> 8;
    s[2]  = (s0 >> 16) | (s1 * ((uint64_t) 1 << 5));
    s[3]  = s1 >> 3;
    s[4]  = s1 >> 11;
    s[5]  = (s1 >> 19) | (s2 * ((uint64_t) 1 << 2));
    s[6]  = s2 >> 6;
    s[7]  = (s2 >> 14) | (s3 * ((uint64_t) 1 << 7));
    s[8]  = s3 >> 1;
    s[9]  = s3 >> 9;
    s[10] = (s3 >> 17) | (s4 * ((uint64_t) 1 << 4));
    s[11] = s4 >> 4;
    s[12] = s4 >> 12;
    s[13] = (s4 >> 20) | (s5 * ((uint64_t) 1 << 1));
    s[14] = s5 >> 7;
    s[15] = (s5 >> 15) | (s6 * ((uint64_t) 1 << 6));
    s[16] = s6 >> 2;
    s[17] = s6 >> 10;
    s[18] = (s6 >> 18) | (s7 * ((uint64_t) 1 << 3));
    s[19] = s7 >> 5;
    s[20] = s7 >> 13;
    s[21] = s8 >> 0;
    s[22] = s8 >> 8;
    s[23] = (s8 >> 16) | (s9 * ((uint64_t) 1 << 5));
    s[24] = s9 >> 3;
    s[25] = s9 >> 11;
    s[26] = (s9 >> 19) | (s10 * ((uint64_t) 1 << 2));
    s[27] = s10 >> 6;
    s[28] = (s10 >> 14) | (s11 * ((uint64_t) 1 << 7));
    s[29] = s11 >> 1;
    s[30] = s11 >> 9;
    s[31] = s11 >> 17;
}


static void
fe25519_mul(fe25519 h, const fe25519 f, const fe25519 g)
{
    int32_t f0 = f[0];
    int32_t f1 = f[1];
    int32_t f2 = f[2];
    int32_t f3 = f[3];
    int32_t f4 = f[4];
    int32_t f5 = f[5];
    int32_t f6 = f[6];
    int32_t f7 = f[7];
    int32_t f8 = f[8];
    int32_t f9 = f[9];

    int32_t g0 = g[0];
    int32_t g1 = g[1];
    int32_t g2 = g[2];
    int32_t g3 = g[3];
    int32_t g4 = g[4];
    int32_t g5 = g[5];
    int32_t g6 = g[6];
    int32_t g7 = g[7];
    int32_t g8 = g[8];
    int32_t g9 = g[9];

    int32_t g1_19 = 19 * g1; /* 1.959375*2^29 */
    int32_t g2_19 = 19 * g2; /* 1.959375*2^30; still ok */
    int32_t g3_19 = 19 * g3;
    int32_t g4_19 = 19 * g4;
    int32_t g5_19 = 19 * g5;
    int32_t g6_19 = 19 * g6;
    int32_t g7_19 = 19 * g7;
    int32_t g8_19 = 19 * g8;
    int32_t g9_19 = 19 * g9;
    int32_t f1_2  = 2 * f1;
    int32_t f3_2  = 2 * f3;
    int32_t f5_2  = 2 * f5;
    int32_t f7_2  = 2 * f7;
    int32_t f9_2  = 2 * f9;
    
    // printf("%016llx\n", (int64_t) 0);
    // printf("%016llx\n", (int64_t) f0   );
    // printf("%016llx\n", (int64_t) f1   );
    // printf("%016llx\n", (int64_t) f2   );
    // printf("%016llx\n", (int64_t) f3   );
    // printf("%016llx\n", (int64_t) f4   );
    // printf("%016llx\n", (int64_t) f5   );
    // printf("%016llx\n", (int64_t) f6   );
    // printf("%016llx\n", (int64_t) f7   );
    // printf("%016llx\n", (int64_t) f8   );
    // printf("%016llx\n", (int64_t) f9   );
    // printf("%016llx\n", (int64_t) g0   );
    // printf("%016llx\n", (int64_t) g1   );
    // printf("%016llx\n", (int64_t) g2   );
    // printf("%016llx\n", (int64_t) g3   );
    // printf("%016llx\n", (int64_t) g4   );
    // printf("%016llx\n", (int64_t) g5   );
    // printf("%016llx\n", (int64_t) g6   );
    // printf("%016llx\n", (int64_t) g7   );
    // printf("%016llx\n", (int64_t) g8   );
    // printf("%016llx\n", (int64_t) g9   );
    // printf("%016llx\n", (int64_t) g1_19);
    // printf("%016llx\n", (int64_t) g2_19);
    // printf("%016llx\n", (int64_t) g3_19);
    // printf("%016llx\n", (int64_t) g4_19);
    // printf("%016llx\n", (int64_t) g5_19);
    // printf("%016llx\n", (int64_t) g6_19);
    // printf("%016llx\n", (int64_t) g7_19);
    // printf("%016llx\n", (int64_t) g8_19);
    // printf("%016llx\n", (int64_t) g9_19);
    // printf("%016llx\n", (int64_t) f1_2 );
    // printf("%016llx\n", (int64_t) f3_2 );
    // printf("%016llx\n", (int64_t) f5_2 );
    // printf("%016llx\n", (int64_t) f7_2 );
    // printf("%016llx\n", (int64_t) f9_2 );

    int64_t f0g0    = f0 * (int64_t) g0;
    int64_t f0g1    = f0 * (int64_t) g1;
    int64_t f0g2    = f0 * (int64_t) g2;
    int64_t f0g3    = f0 * (int64_t) g3;
    int64_t f0g4    = f0 * (int64_t) g4;
    int64_t f0g5    = f0 * (int64_t) g5;
    int64_t f0g6    = f0 * (int64_t) g6;
    int64_t f0g7    = f0 * (int64_t) g7;
    int64_t f0g8    = f0 * (int64_t) g8;
    int64_t f0g9    = f0 * (int64_t) g9;
    int64_t f1g0    = f1 * (int64_t) g0;
    int64_t f1g1_2  = f1_2 * (int64_t) g1;
    int64_t f1g2    = f1 * (int64_t) g2;
    int64_t f1g3_2  = f1_2 * (int64_t) g3;
    int64_t f1g4    = f1 * (int64_t) g4;
    int64_t f1g5_2  = f1_2 * (int64_t) g5;
    int64_t f1g6    = f1 * (int64_t) g6;
    int64_t f1g7_2  = f1_2 * (int64_t) g7;
    int64_t f1g8    = f1 * (int64_t) g8;
    int64_t f1g9_38 = f1_2 * (int64_t) g9_19;
    int64_t f2g0    = f2 * (int64_t) g0;
    int64_t f2g1    = f2 * (int64_t) g1;
    int64_t f2g2    = f2 * (int64_t) g2;
    int64_t f2g3    = f2 * (int64_t) g3;
    int64_t f2g4    = f2 * (int64_t) g4;
    int64_t f2g5    = f2 * (int64_t) g5;
    int64_t f2g6    = f2 * (int64_t) g6;
    int64_t f2g7    = f2 * (int64_t) g7;
    int64_t f2g8_19 = f2 * (int64_t) g8_19;
    int64_t f2g9_19 = f2 * (int64_t) g9_19;
    int64_t f3g0    = f3 * (int64_t) g0;
    int64_t f3g1_2  = f3_2 * (int64_t) g1;
    int64_t f3g2    = f3 * (int64_t) g2;
    int64_t f3g3_2  = f3_2 * (int64_t) g3;
    int64_t f3g4    = f3 * (int64_t) g4;
    int64_t f3g5_2  = f3_2 * (int64_t) g5;
    int64_t f3g6    = f3 * (int64_t) g6;
    int64_t f3g7_38 = f3_2 * (int64_t) g7_19;
    int64_t f3g8_19 = f3 * (int64_t) g8_19;
    int64_t f3g9_38 = f3_2 * (int64_t) g9_19;
    int64_t f4g0    = f4 * (int64_t) g0;
    int64_t f4g1    = f4 * (int64_t) g1;
    int64_t f4g2    = f4 * (int64_t) g2;
    int64_t f4g3    = f4 * (int64_t) g3;
    int64_t f4g4    = f4 * (int64_t) g4;
    int64_t f4g5    = f4 * (int64_t) g5;
    int64_t f4g6_19 = f4 * (int64_t) g6_19;
    int64_t f4g7_19 = f4 * (int64_t) g7_19;
    int64_t f4g8_19 = f4 * (int64_t) g8_19;
    int64_t f4g9_19 = f4 * (int64_t) g9_19;
    int64_t f5g0    = f5 * (int64_t) g0;
    int64_t f5g1_2  = f5_2 * (int64_t) g1;
    int64_t f5g2    = f5 * (int64_t) g2;
    int64_t f5g3_2  = f5_2 * (int64_t) g3;
    int64_t f5g4    = f5 * (int64_t) g4;
    int64_t f5g5_38 = f5_2 * (int64_t) g5_19;
    int64_t f5g6_19 = f5 * (int64_t) g6_19;
    int64_t f5g7_38 = f5_2 * (int64_t) g7_19;
    int64_t f5g8_19 = f5 * (int64_t) g8_19;
    int64_t f5g9_38 = f5_2 * (int64_t) g9_19;
    int64_t f6g0    = f6 * (int64_t) g0;
    int64_t f6g1    = f6 * (int64_t) g1;
    int64_t f6g2    = f6 * (int64_t) g2;
    int64_t f6g3    = f6 * (int64_t) g3;
    int64_t f6g4_19 = f6 * (int64_t) g4_19;
    int64_t f6g5_19 = f6 * (int64_t) g5_19;
    int64_t f6g6_19 = f6 * (int64_t) g6_19;
    int64_t f6g7_19 = f6 * (int64_t) g7_19;
    int64_t f6g8_19 = f6 * (int64_t) g8_19;
    int64_t f6g9_19 = f6 * (int64_t) g9_19;
    int64_t f7g0    = f7 * (int64_t) g0;
    int64_t f7g1_2  = f7_2 * (int64_t) g1;
    int64_t f7g2    = f7 * (int64_t) g2;
    int64_t f7g3_38 = f7_2 * (int64_t) g3_19;
    int64_t f7g4_19 = f7 * (int64_t) g4_19;
    int64_t f7g5_38 = f7_2 * (int64_t) g5_19;
    int64_t f7g6_19 = f7 * (int64_t) g6_19;
    int64_t f7g7_38 = f7_2 * (int64_t) g7_19;
    int64_t f7g8_19 = f7 * (int64_t) g8_19;
    int64_t f7g9_38 = f7_2 * (int64_t) g9_19;
    int64_t f8g0    = f8 * (int64_t) g0;
    int64_t f8g1    = f8 * (int64_t) g1;
    int64_t f8g2_19 = f8 * (int64_t) g2_19;
    int64_t f8g3_19 = f8 * (int64_t) g3_19;
    int64_t f8g4_19 = f8 * (int64_t) g4_19;
    int64_t f8g5_19 = f8 * (int64_t) g5_19;
    int64_t f8g6_19 = f8 * (int64_t) g6_19;
    int64_t f8g7_19 = f8 * (int64_t) g7_19;
    int64_t f8g8_19 = f8 * (int64_t) g8_19;
    int64_t f8g9_19 = f8 * (int64_t) g9_19;
    int64_t f9g0    = f9 * (int64_t) g0;
    int64_t f9g1_38 = f9_2 * (int64_t) g1_19;
    int64_t f9g2_19 = f9 * (int64_t) g2_19;
    int64_t f9g3_38 = f9_2 * (int64_t) g3_19;
    int64_t f9g4_19 = f9 * (int64_t) g4_19;
    int64_t f9g5_38 = f9_2 * (int64_t) g5_19;
    int64_t f9g6_19 = f9 * (int64_t) g6_19;
    int64_t f9g7_38 = f9_2 * (int64_t) g7_19;
    int64_t f9g8_19 = f9 * (int64_t) g8_19;
    int64_t f9g9_38 = f9_2 * (int64_t) g9_19;

    // printf("%016llx\n", (0x100000000 - 0xff8145bell) * (0x100000000 - 0xff8145bell));
    // printf("%016llx\n", (int64_t) (-1 * (int64_t) g0));
    // printf("%016llx\n", (int64_t) (-1 * (int64_t) g0));
    // printf("%016llx\n", f0g0   );
    // printf("%016llx\n", f0g1   );
    // printf("%016llx\n", f0g2   );
    // printf("%016llx\n", f0g3   );
    // printf("%016llx\n", f0g4   );
    // printf("%016llx\n", f0g5   );
    // printf("%016llx\n", f0g6   );
    // printf("%016llx\n", f0g7   );
    // printf("%016llx\n", f0g8   );
    // printf("%016llx\n", f0g9   );
    // printf("%016llx\n", f1g0   );
    // printf("%016llx\n", f1g1_2 );
    // printf("%016llx\n", f1g2   );
    // printf("%016llx\n", f1g3_2 );
    // printf("%016llx\n", f1g4   );
    // printf("%016llx\n", f1g5_2 );
    // printf("%016llx\n", f1g6   );
    // printf("%016llx\n", f1g7_2 );
    // printf("%016llx\n", f1g8   );
    // printf("%016llx\n", f1g9_38);
    // printf("%016llx\n", f2g0   );
    // printf("%016llx\n", f2g1   );
    // printf("%016llx\n", f2g2   );
    // printf("%016llx\n", f2g3   );
    // printf("%016llx\n", f2g4   );
    // printf("%016llx\n", f2g5   );
    // printf("%016llx\n", f2g6   );
    // printf("%016llx\n", f2g7   );
    // printf("%016llx\n", f2g8_19);
    // printf("%016llx\n", f2g9_19);
    // printf("%016llx\n", f3g0   );
    // printf("%016llx\n", f3g1_2 );
    // printf("%016llx\n", f3g2   );
    // printf("%016llx\n", f3g3_2 );
    // printf("%016llx\n", f3g4   );
    // printf("%016llx\n", f3g5_2 );
    // printf("%016llx\n", f3g6   );
    // printf("%016llx\n", f3g7_38);
    // printf("%016llx\n", f3g8_19);
    // printf("%016llx\n", f3g9_38);
    // printf("%016llx\n", f4g0   );
    // printf("%016llx\n", f4g1   );
    // printf("%016llx\n", f4g2   );
    // printf("%016llx\n", f4g3   );
    // printf("%016llx\n", f4g4   );
    // printf("%016llx\n", f4g5   );
    // printf("%016llx\n", f4g6_19);
    // printf("%016llx\n", f4g7_19);
    // printf("%016llx\n", f4g8_19);
    // printf("%016llx\n", f4g9_19);
    // printf("%016llx\n", f5g0   );
    // printf("%016llx\n", f5g1_2 );
    // printf("%016llx\n", f5g2   );
    // printf("%016llx\n", f5g3_2 );
    // printf("%016llx\n", f5g4   );
    // printf("%016llx\n", f5g5_38);
    // printf("%016llx\n", f5g6_19);
    // printf("%016llx\n", f5g7_38);
    // printf("%016llx\n", f5g8_19);
    // printf("%016llx\n", f5g9_38);
    // printf("%016llx\n", f6g0   );
    // printf("%016llx\n", f6g1   );
    // printf("%016llx\n", f6g2   );
    // printf("%016llx\n", f6g3   );
    // printf("%016llx\n", f6g4_19);
    // printf("%016llx\n", f6g5_19);
    // printf("%016llx\n", f6g6_19);
    // printf("%016llx\n", f6g7_19);
    // printf("%016llx\n", f6g8_19);
    // printf("%016llx\n", f6g9_19);
    // printf("%016llx\n", f7g0   );
    // printf("%016llx\n", f7g1_2 );
    // printf("%016llx\n", f7g2   );
    // printf("%016llx\n", f7g3_38);
    // printf("%016llx\n", f7g4_19);
    // printf("%016llx\n", f7g5_38);
    // printf("%016llx\n", f7g6_19);
    // printf("%016llx\n", f7g7_38);
    // printf("%016llx\n", f7g8_19);
    // printf("%016llx\n", f7g9_38);
    // printf("%016llx\n", f8g0   );
    // printf("%016llx\n", f8g1   );
    // printf("%016llx\n", f8g2_19);
    // printf("%016llx\n", f8g3_19);
    // printf("%016llx\n", f8g4_19);
    // printf("%016llx\n", f8g5_19);
    // printf("%016llx\n", f8g6_19);
    // printf("%016llx\n", f8g7_19);
    // printf("%016llx\n", f8g8_19);
    // printf("%016llx\n", f8g9_19);
    // printf("%016llx\n", f9g0   );
    // printf("%016llx\n", f9g1_38);
    // printf("%016llx\n", f9g2_19);
    // printf("%016llx\n", f9g3_38);
    // printf("%016llx\n", f9g4_19);
    // printf("%016llx\n", f9g5_38);
    // printf("%016llx\n", f9g6_19);
    // printf("%016llx\n", f9g7_38);
    // printf("%016llx\n", f9g8_19);
    // printf("%016llx\n", f9g9_38);

    int64_t h0 = f0g0 + f1g9_38 + f2g8_19 + f3g7_38 + f4g6_19 + f5g5_38 +
                 f6g4_19 + f7g3_38 + f8g2_19 + f9g1_38;
    int64_t h1 = f0g1 + f1g0 + f2g9_19 + f3g8_19 + f4g7_19 + f5g6_19 + f6g5_19 +
                 f7g4_19 + f8g3_19 + f9g2_19;
    int64_t h2 = f0g2 + f1g1_2 + f2g0 + f3g9_38 + f4g8_19 + f5g7_38 + f6g6_19 +
                 f7g5_38 + f8g4_19 + f9g3_38;
    int64_t h3 = f0g3 + f1g2 + f2g1 + f3g0 + f4g9_19 + f5g8_19 + f6g7_19 +
                 f7g6_19 + f8g5_19 + f9g4_19;
    int64_t h4 = f0g4 + f1g3_2 + f2g2 + f3g1_2 + f4g0 + f5g9_38 + f6g8_19 +
                 f7g7_38 + f8g6_19 + f9g5_38;
    int64_t h5 = f0g5 + f1g4 + f2g3 + f3g2 + f4g1 + f5g0 + f6g9_19 + f7g8_19 +
                 f8g7_19 + f9g6_19;
    int64_t h6 = f0g6 + f1g5_2 + f2g4 + f3g3_2 + f4g2 + f5g1_2 + f6g0 +
                 f7g9_38 + f8g8_19 + f9g7_38;
    int64_t h7 = f0g7 + f1g6 + f2g5 + f3g4 + f4g3 + f5g2 + f6g1 + f7g0 +
                 f8g9_19 + f9g8_19;
    int64_t h8 = f0g8 + f1g7_2 + f2g6 + f3g5_2 + f4g4 + f5g3_2 + f6g2 + f7g1_2 +
                 f8g0 + f9g9_38;
    int64_t h9 =
        f0g9 + f1g8 + f2g7 + f3g6 + f4g5 + f5g4 + f6g3 + f7g2 + f8g1 + f9g0;

    int64_t carry0;
    int64_t carry1;
    int64_t carry2;
    int64_t carry3;
    int64_t carry4;
    int64_t carry5;
    int64_t carry6;
    int64_t carry7;
    int64_t carry8;
    int64_t carry9;

    /*
     |h0| <= (1.65*1.65*2^52*(1+19+19+19+19)+1.65*1.65*2^50*(38+38+38+38+38))
     i.e. |h0| <= 1.4*2^60; narrower ranges for h2, h4, h6, h8
     |h1| <= (1.65*1.65*2^51*(1+1+19+19+19+19+19+19+19+19))
     i.e. |h1| <= 1.7*2^59; narrower ranges for h3, h5, h7, h9
     */

    carry0 = (h0 + (int64_t)(1L << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 * ((uint64_t) 1L << 26);
    carry4 = (h4 + (int64_t)(1L << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 * ((uint64_t) 1L << 26);
    /* |h0| <= 2^25 */
    /* |h4| <= 2^25 */
    /* |h1| <= 1.71*2^59 */
    /* |h5| <= 1.71*2^59 */

    carry1 = (h1 + (int64_t)(1L << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 * ((uint64_t) 1L << 25);
    carry5 = (h5 + (int64_t)(1L << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 * ((uint64_t) 1L << 25);
    /* |h1| <= 2^24; from now on fits into int32 */
    /* |h5| <= 2^24; from now on fits into int32 */
    /* |h2| <= 1.41*2^60 */
    /* |h6| <= 1.41*2^60 */

    carry2 = (h2 + (int64_t)(1L << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 * ((uint64_t) 1L << 26);
    carry6 = (h6 + (int64_t)(1L << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 * ((uint64_t) 1L << 26);
    /* |h2| <= 2^25; from now on fits into int32 unchanged */
    /* |h6| <= 2^25; from now on fits into int32 unchanged */
    /* |h3| <= 1.71*2^59 */
    /* |h7| <= 1.71*2^59 */

    carry3 = (h3 + (int64_t)(1L << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 * ((uint64_t) 1L << 25);
    carry7 = (h7 + (int64_t)(1L << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 * ((uint64_t) 1L << 25);
    /* |h3| <= 2^24; from now on fits into int32 unchanged */
    /* |h7| <= 2^24; from now on fits into int32 unchanged */
    /* |h4| <= 1.72*2^34 */
    /* |h8| <= 1.41*2^60 */

    carry4 = (h4 + (int64_t)(1L << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 * ((uint64_t) 1L << 26);
    carry8 = (h8 + (int64_t)(1L << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 * ((uint64_t) 1L << 26);
    /* |h4| <= 2^25; from now on fits into int32 unchanged */
    /* |h8| <= 2^25; from now on fits into int32 unchanged */
    /* |h5| <= 1.01*2^24 */
    /* |h9| <= 1.71*2^59 */

    carry9 = (h9 + (int64_t)(1L << 24)) >> 25;
    h0 += carry9 * 19;
    h9 -= carry9 * ((uint64_t) 1L << 25);
    /* |h9| <= 2^24; from now on fits into int32 unchanged */
    /* |h0| <= 1.1*2^39 */

    carry0 = (h0 + (int64_t)(1L << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 * ((uint64_t) 1L << 26);
    /* |h0| <= 2^25; from now on fits into int32 unchanged */
    /* |h1| <= 1.01*2^24 */

    h[0] = (int32_t) h0;
    h[1] = (int32_t) h1;
    h[2] = (int32_t) h2;
    h[3] = (int32_t) h3;
    h[4] = (int32_t) h4;
    h[5] = (int32_t) h5;
    h[6] = (int32_t) h6;
    h[7] = (int32_t) h7;
    h[8] = (int32_t) h8;
    h[9] = (int32_t) h9;

    // printf("%x\n", f0);
    // printf("%x\n", f1);
    // printf("%x\n", f2);
    // printf("%x\n", f3);
    // printf("%x\n", f4);
    // printf("%x\n", f5);
    // printf("%x\n", f6);
    // printf("%x\n", f7);
    // printf("%x\n", f8);
    // printf("%x\n", f9);

    // printf("\n");

    // printf("%x\n", g0);
    // printf("%x\n", g1);
    // printf("%x\n", g2);
    // printf("%x\n", g3);
    // printf("%x\n", g4);
    // printf("%x\n", g5);
    // printf("%x\n", g6);
    // printf("%x\n", g7);
    // printf("%x\n", g8);
    // printf("%x\n", g9);
}


static void
fe25519_sq(fe25519 h, const fe25519 f)
{
    int32_t f0 = f[0];
    int32_t f1 = f[1];
    int32_t f2 = f[2];
    int32_t f3 = f[3];
    int32_t f4 = f[4];
    int32_t f5 = f[5];
    int32_t f6 = f[6];
    int32_t f7 = f[7];
    int32_t f8 = f[8];
    int32_t f9 = f[9];

    int32_t f0_2  = 2 * f0;
    int32_t f1_2  = 2 * f1;
    int32_t f2_2  = 2 * f2;
    int32_t f3_2  = 2 * f3;
    int32_t f4_2  = 2 * f4;
    int32_t f5_2  = 2 * f5;
    int32_t f6_2  = 2 * f6;
    int32_t f7_2  = 2 * f7;
    int32_t f5_38 = 38 * f5; /* 1.959375*2^30 */
    int32_t f6_19 = 19 * f6; /* 1.959375*2^30 */
    int32_t f7_38 = 38 * f7; /* 1.959375*2^30 */
    int32_t f8_19 = 19 * f8; /* 1.959375*2^30 */
    int32_t f9_38 = 38 * f9; /* 1.959375*2^30 */

    int64_t f0f0    = f0 * (int64_t) f0;
    int64_t f0f1_2  = f0_2 * (int64_t) f1;
    int64_t f0f2_2  = f0_2 * (int64_t) f2;
    int64_t f0f3_2  = f0_2 * (int64_t) f3;
    int64_t f0f4_2  = f0_2 * (int64_t) f4;
    int64_t f0f5_2  = f0_2 * (int64_t) f5;
    int64_t f0f6_2  = f0_2 * (int64_t) f6;
    int64_t f0f7_2  = f0_2 * (int64_t) f7;
    int64_t f0f8_2  = f0_2 * (int64_t) f8;
    int64_t f0f9_2  = f0_2 * (int64_t) f9;
    int64_t f1f1_2  = f1_2 * (int64_t) f1;
    int64_t f1f2_2  = f1_2 * (int64_t) f2;
    int64_t f1f3_4  = f1_2 * (int64_t) f3_2;
    int64_t f1f4_2  = f1_2 * (int64_t) f4;
    int64_t f1f5_4  = f1_2 * (int64_t) f5_2;
    int64_t f1f6_2  = f1_2 * (int64_t) f6;
    int64_t f1f7_4  = f1_2 * (int64_t) f7_2;
    int64_t f1f8_2  = f1_2 * (int64_t) f8;
    int64_t f1f9_76 = f1_2 * (int64_t) f9_38;
    int64_t f2f2    = f2 * (int64_t) f2;
    int64_t f2f3_2  = f2_2 * (int64_t) f3;
    int64_t f2f4_2  = f2_2 * (int64_t) f4;
    int64_t f2f5_2  = f2_2 * (int64_t) f5;
    int64_t f2f6_2  = f2_2 * (int64_t) f6;
    int64_t f2f7_2  = f2_2 * (int64_t) f7;
    int64_t f2f8_38 = f2_2 * (int64_t) f8_19;
    int64_t f2f9_38 = f2 * (int64_t) f9_38;
    int64_t f3f3_2  = f3_2 * (int64_t) f3;
    int64_t f3f4_2  = f3_2 * (int64_t) f4;
    int64_t f3f5_4  = f3_2 * (int64_t) f5_2;
    int64_t f3f6_2  = f3_2 * (int64_t) f6;
    int64_t f3f7_76 = f3_2 * (int64_t) f7_38;
    int64_t f3f8_38 = f3_2 * (int64_t) f8_19;
    int64_t f3f9_76 = f3_2 * (int64_t) f9_38;
    int64_t f4f4    = f4 * (int64_t) f4;
    int64_t f4f5_2  = f4_2 * (int64_t) f5;
    int64_t f4f6_38 = f4_2 * (int64_t) f6_19;
    int64_t f4f7_38 = f4 * (int64_t) f7_38;
    int64_t f4f8_38 = f4_2 * (int64_t) f8_19;
    int64_t f4f9_38 = f4 * (int64_t) f9_38;
    int64_t f5f5_38 = f5 * (int64_t) f5_38;
    int64_t f5f6_38 = f5_2 * (int64_t) f6_19;
    int64_t f5f7_76 = f5_2 * (int64_t) f7_38;
    int64_t f5f8_38 = f5_2 * (int64_t) f8_19;
    int64_t f5f9_76 = f5_2 * (int64_t) f9_38;
    int64_t f6f6_19 = f6 * (int64_t) f6_19;
    int64_t f6f7_38 = f6 * (int64_t) f7_38;
    int64_t f6f8_38 = f6_2 * (int64_t) f8_19;
    int64_t f6f9_38 = f6 * (int64_t) f9_38;
    int64_t f7f7_38 = f7 * (int64_t) f7_38;
    int64_t f7f8_38 = f7_2 * (int64_t) f8_19;
    int64_t f7f9_76 = f7_2 * (int64_t) f9_38;
    int64_t f8f8_19 = f8 * (int64_t) f8_19;
    int64_t f8f9_38 = f8 * (int64_t) f9_38;
    int64_t f9f9_38 = f9 * (int64_t) f9_38;

    int64_t h0 = f0f0 + f1f9_76 + f2f8_38 + f3f7_76 + f4f6_38 + f5f5_38;
    int64_t h1 = f0f1_2 + f2f9_38 + f3f8_38 + f4f7_38 + f5f6_38;
    int64_t h2 = f0f2_2 + f1f1_2 + f3f9_76 + f4f8_38 + f5f7_76 + f6f6_19;
    int64_t h3 = f0f3_2 + f1f2_2 + f4f9_38 + f5f8_38 + f6f7_38;
    int64_t h4 = f0f4_2 + f1f3_4 + f2f2 + f5f9_76 + f6f8_38 + f7f7_38;
    int64_t h5 = f0f5_2 + f1f4_2 + f2f3_2 + f6f9_38 + f7f8_38;
    int64_t h6 = f0f6_2 + f1f5_4 + f2f4_2 + f3f3_2 + f7f9_76 + f8f8_19;
    int64_t h7 = f0f7_2 + f1f6_2 + f2f5_2 + f3f4_2 + f8f9_38;
    int64_t h8 = f0f8_2 + f1f7_4 + f2f6_2 + f3f5_4 + f4f4 + f9f9_38;
    int64_t h9 = f0f9_2 + f1f8_2 + f2f7_2 + f3f6_2 + f4f5_2;

    int64_t carry0;
    int64_t carry1;
    int64_t carry2;
    int64_t carry3;
    int64_t carry4;
    int64_t carry5;
    int64_t carry6;
    int64_t carry7;
    int64_t carry8;
    int64_t carry9;

    carry0 = (h0 + (int64_t)(1L << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 * ((uint64_t) 1L << 26);
    carry4 = (h4 + (int64_t)(1L << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 * ((uint64_t) 1L << 26);

    carry1 = (h1 + (int64_t)(1L << 24)) >> 25;
    h2 += carry1;
    h1 -= carry1 * ((uint64_t) 1L << 25);
    carry5 = (h5 + (int64_t)(1L << 24)) >> 25;
    h6 += carry5;
    h5 -= carry5 * ((uint64_t) 1L << 25);

    carry2 = (h2 + (int64_t)(1L << 25)) >> 26;
    h3 += carry2;
    h2 -= carry2 * ((uint64_t) 1L << 26);
    carry6 = (h6 + (int64_t)(1L << 25)) >> 26;
    h7 += carry6;
    h6 -= carry6 * ((uint64_t) 1L << 26);

    carry3 = (h3 + (int64_t)(1L << 24)) >> 25;
    h4 += carry3;
    h3 -= carry3 * ((uint64_t) 1L << 25);
    carry7 = (h7 + (int64_t)(1L << 24)) >> 25;
    h8 += carry7;
    h7 -= carry7 * ((uint64_t) 1L << 25);

    carry4 = (h4 + (int64_t)(1L << 25)) >> 26;
    h5 += carry4;
    h4 -= carry4 * ((uint64_t) 1L << 26);
    carry8 = (h8 + (int64_t)(1L << 25)) >> 26;
    h9 += carry8;
    h8 -= carry8 * ((uint64_t) 1L << 26);

    carry9 = (h9 + (int64_t)(1L << 24)) >> 25;
    h0 += carry9 * 19;
    h9 -= carry9 * ((uint64_t) 1L << 25);

    carry0 = (h0 + (int64_t)(1L << 25)) >> 26;
    h1 += carry0;
    h0 -= carry0 * ((uint64_t) 1L << 26);

    h[0] = (int32_t) h0;
    h[1] = (int32_t) h1;
    h[2] = (int32_t) h2;
    h[3] = (int32_t) h3;
    h[4] = (int32_t) h4;
    h[5] = (int32_t) h5;
    h[6] = (int32_t) h6;
    h[7] = (int32_t) h7;
    h[8] = (int32_t) h8;
    h[9] = (int32_t) h9;
}

void
fe25519_sqmul(fe25519 s, const int n, const fe25519 a)
{   
    int i;

    for (i = 0; i < n; i++) {
        fe25519_sq(s, s);
    }
    fe25519_mul(s, s, a);
}

/*
 * Inversion - returns 0 if z=0
 */
void
fe25519_invert(fe25519 out, const fe25519 z)
{
    fe25519 t0, t1, t2, t3;
    int     i;

    fe25519_sq(t0, z);
    fe25519_sq(t1, t0);
    fe25519_sq(t1, t1);
    fe25519_mul(t1, z, t1);
    fe25519_mul(t0, t0, t1);
    fe25519_sq(t2, t0);
    fe25519_mul(t1, t1, t2);
    fe25519_sq(t2, t1);
    for (i = 1; i < 5; ++i) {
        fe25519_sq(t2, t2);
    }
    fe25519_mul(t1, t2, t1);
    fe25519_sq(t2, t1);
    for (i = 1; i < 10; ++i) {
        fe25519_sq(t2, t2);
    }
    fe25519_mul(t2, t2, t1);
    fe25519_sq(t3, t2);
    for (i = 1; i < 20; ++i) {
        fe25519_sq(t3, t3);
    }
    fe25519_mul(t2, t3, t2);
    fe25519_sq(t2, t2);
    for (i = 1; i < 10; ++i) {
        fe25519_sq(t2, t2);
    }
    fe25519_mul(t1, t2, t1);
    fe25519_sq(t2, t1);
    for (i = 1; i < 50; ++i) {
        fe25519_sq(t2, t2);
    }
    fe25519_mul(t2, t2, t1);
    fe25519_sq(t3, t2);
    for (i = 1; i < 100; ++i) {
        fe25519_sq(t3, t3);
    }
    fe25519_mul(t2, t3, t2);
    fe25519_sq(t2, t2);
    for (i = 1; i < 50; ++i) {
        fe25519_sq(t2, t2);
    }
    fe25519_mul(t1, t2, t1);
    fe25519_sq(t1, t1);
    for (i = 1; i < 5; ++i) {
        fe25519_sq(t1, t1);
    }
    fe25519_mul(out, t1, t0);
}


static void
fe25519_pow22523(fe25519 out, const fe25519 z)
{
    fe25519 t0, t1, t2;
    int     i;

    fe25519_sq(t0, z);
    fe25519_sq(t1, t0);
    fe25519_sq(t1, t1);
    fe25519_mul(t1, z, t1);
    fe25519_mul(t0, t0, t1);
    fe25519_sq(t0, t0);
    fe25519_mul(t0, t1, t0);
    fe25519_sq(t1, t0);
    for (i = 1; i < 5; ++i) {
        fe25519_sq(t1, t1);
    }
    fe25519_mul(t0, t1, t0);
    fe25519_sq(t1, t0);
    for (i = 1; i < 10; ++i) {
        fe25519_sq(t1, t1);
    }
    fe25519_mul(t1, t1, t0);
    fe25519_sq(t2, t1);
    for (i = 1; i < 20; ++i) {
        fe25519_sq(t2, t2);
    }
    fe25519_mul(t1, t2, t1);
    fe25519_sq(t1, t1);
    for (i = 1; i < 10; ++i) {
        fe25519_sq(t1, t1);
    }
    fe25519_mul(t0, t1, t0);
    fe25519_sq(t1, t0);
    for (i = 1; i < 50; ++i) {
        fe25519_sq(t1, t1);
    }
    fe25519_mul(t1, t1, t0);
    fe25519_sq(t2, t1);
    for (i = 1; i < 100; ++i) {
        fe25519_sq(t2, t2);
    }
    fe25519_mul(t1, t2, t1);
    fe25519_sq(t1, t1);
    for (i = 1; i < 50; ++i) {
        fe25519_sq(t1, t1);
    }
    fe25519_mul(t0, t1, t0);
    fe25519_sq(t0, t0);
    fe25519_sq(t0, t0);
    fe25519_mul(out, t0, z);
}

void
sc25519_reduce(unsigned char s[64])
{
    int64_t s0  = 2097151 & load_3(s);
    int64_t s1  = 2097151 & (load_4(s + 2) >> 5);
    int64_t s2  = 2097151 & (load_3(s + 5) >> 2);
    int64_t s3  = 2097151 & (load_4(s + 7) >> 7);
    int64_t s4  = 2097151 & (load_4(s + 10) >> 4);
    int64_t s5  = 2097151 & (load_3(s + 13) >> 1);
    int64_t s6  = 2097151 & (load_4(s + 15) >> 6);
    int64_t s7  = 2097151 & (load_3(s + 18) >> 3);
    int64_t s8  = 2097151 & load_3(s + 21);
    int64_t s9  = 2097151 & (load_4(s + 23) >> 5);
    int64_t s10 = 2097151 & (load_3(s + 26) >> 2);
    int64_t s11 = 2097151 & (load_4(s + 28) >> 7);
    int64_t s12 = 2097151 & (load_4(s + 31) >> 4);
    int64_t s13 = 2097151 & (load_3(s + 34) >> 1);
    int64_t s14 = 2097151 & (load_4(s + 36) >> 6);
    int64_t s15 = 2097151 & (load_3(s + 39) >> 3);
    int64_t s16 = 2097151 & load_3(s + 42);
    int64_t s17 = 2097151 & (load_4(s + 44) >> 5);
    int64_t s18 = 2097151 & (load_3(s + 47) >> 2);
    int64_t s19 = 2097151 & (load_4(s + 49) >> 7);
    int64_t s20 = 2097151 & (load_4(s + 52) >> 4);
    int64_t s21 = 2097151 & (load_3(s + 55) >> 1);
    int64_t s22 = 2097151 & (load_4(s + 57) >> 6);
    int64_t s23 = (load_4(s + 60) >> 3);

    int64_t carry0;
    int64_t carry1;
    int64_t carry2;
    int64_t carry3;
    int64_t carry4;
    int64_t carry5;
    int64_t carry6;
    int64_t carry7;
    int64_t carry8;
    int64_t carry9;
    int64_t carry10;
    int64_t carry11;
    int64_t carry12;
    int64_t carry13;
    int64_t carry14;
    int64_t carry15;
    int64_t carry16;

    s11 += s23 * 666643;
    s12 += s23 * 470296;
    s13 += s23 * 654183;
    s14 -= s23 * 997805;
    s15 += s23 * 136657;
    s16 -= s23 * 683901;

    s10 += s22 * 666643;
    s11 += s22 * 470296;
    s12 += s22 * 654183;
    s13 -= s22 * 997805;
    s14 += s22 * 136657;
    s15 -= s22 * 683901;

    s9 += s21 * 666643;
    s10 += s21 * 470296;
    s11 += s21 * 654183;
    s12 -= s21 * 997805;
    s13 += s21 * 136657;
    s14 -= s21 * 683901;

    s8 += s20 * 666643;
    s9 += s20 * 470296;
    s10 += s20 * 654183;
    s11 -= s20 * 997805;
    s12 += s20 * 136657;
    s13 -= s20 * 683901;

    s7 += s19 * 666643;
    s8 += s19 * 470296;
    s9 += s19 * 654183;
    s10 -= s19 * 997805;
    s11 += s19 * 136657;
    s12 -= s19 * 683901;

    s6 += s18 * 666643;
    s7 += s18 * 470296;
    s8 += s18 * 654183;
    s9 -= s18 * 997805;
    s10 += s18 * 136657;
    s11 -= s18 * 683901;

    carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);
    carry12 = (s12 + (int64_t) (1L << 20)) >> 21;
    s13 += carry12;
    s12 -= carry12 * ((uint64_t) 1L << 21);
    carry14 = (s14 + (int64_t) (1L << 20)) >> 21;
    s15 += carry14;
    s14 -= carry14 * ((uint64_t) 1L << 21);
    carry16 = (s16 + (int64_t) (1L << 20)) >> 21;
    s17 += carry16;
    s16 -= carry16 * ((uint64_t) 1L << 21);

    carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);
    carry13 = (s13 + (int64_t) (1L << 20)) >> 21;
    s14 += carry13;
    s13 -= carry13 * ((uint64_t) 1L << 21);
    carry15 = (s15 + (int64_t) (1L << 20)) >> 21;
    s16 += carry15;
    s15 -= carry15 * ((uint64_t) 1L << 21);

    s5 += s17 * 666643;
    s6 += s17 * 470296;
    s7 += s17 * 654183;
    s8 -= s17 * 997805;
    s9 += s17 * 136657;
    s10 -= s17 * 683901;

    s4 += s16 * 666643;
    s5 += s16 * 470296;
    s6 += s16 * 654183;
    s7 -= s16 * 997805;
    s8 += s16 * 136657;
    s9 -= s16 * 683901;

    s3 += s15 * 666643;
    s4 += s15 * 470296;
    s5 += s15 * 654183;
    s6 -= s15 * 997805;
    s7 += s15 * 136657;
    s8 -= s15 * 683901;

    s2 += s14 * 666643;
    s3 += s14 * 470296;
    s4 += s14 * 654183;
    s5 -= s14 * 997805;
    s6 += s14 * 136657;
    s7 -= s14 * 683901;

    s1 += s13 * 666643;
    s2 += s13 * 470296;
    s3 += s13 * 654183;
    s4 -= s13 * 997805;
    s5 += s13 * 136657;
    s6 -= s13 * 683901;

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;
    s12 = 0;

    carry0 = (s0 + (int64_t) (1L << 20)) >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry2 = (s2 + (int64_t) (1L << 20)) >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry4 = (s4 + (int64_t) (1L << 20)) >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry6 = (s6 + (int64_t) (1L << 20)) >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry8 = (s8 + (int64_t) (1L << 20)) >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry10 = (s10 + (int64_t) (1L << 20)) >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);

    carry1 = (s1 + (int64_t) (1L << 20)) >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry3 = (s3 + (int64_t) (1L << 20)) >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry5 = (s5 + (int64_t) (1L << 20)) >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry7 = (s7 + (int64_t) (1L << 20)) >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry9 = (s9 + (int64_t) (1L << 20)) >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry11 = (s11 + (int64_t) (1L << 20)) >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;
    s12 = 0;

    carry0 = s0 >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry1 = s1 >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry2 = s2 >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry3 = s3 >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry4 = s4 >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry5 = s5 >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry6 = s6 >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry7 = s7 >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry8 = s8 >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry9 = s9 >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry10 = s10 >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);
    carry11 = s11 >> 21;
    s12 += carry11;
    s11 -= carry11 * ((uint64_t) 1L << 21);

    s0 += s12 * 666643;
    s1 += s12 * 470296;
    s2 += s12 * 654183;
    s3 -= s12 * 997805;
    s4 += s12 * 136657;
    s5 -= s12 * 683901;

    carry0 = s0 >> 21;
    s1 += carry0;
    s0 -= carry0 * ((uint64_t) 1L << 21);
    carry1 = s1 >> 21;
    s2 += carry1;
    s1 -= carry1 * ((uint64_t) 1L << 21);
    carry2 = s2 >> 21;
    s3 += carry2;
    s2 -= carry2 * ((uint64_t) 1L << 21);
    carry3 = s3 >> 21;
    s4 += carry3;
    s3 -= carry3 * ((uint64_t) 1L << 21);
    carry4 = s4 >> 21;
    s5 += carry4;
    s4 -= carry4 * ((uint64_t) 1L << 21);
    carry5 = s5 >> 21;
    s6 += carry5;
    s5 -= carry5 * ((uint64_t) 1L << 21);
    carry6 = s6 >> 21;
    s7 += carry6;
    s6 -= carry6 * ((uint64_t) 1L << 21);
    carry7 = s7 >> 21;
    s8 += carry7;
    s7 -= carry7 * ((uint64_t) 1L << 21);
    carry8 = s8 >> 21;
    s9 += carry8;
    s8 -= carry8 * ((uint64_t) 1L << 21);
    carry9 = s9 >> 21;
    s10 += carry9;
    s9 -= carry9 * ((uint64_t) 1L << 21);
    carry10 = s10 >> 21;
    s11 += carry10;
    s10 -= carry10 * ((uint64_t) 1L << 21);

    s[0]  = s0 >> 0;
    s[1]  = s0 >> 8;
    s[2]  = (s0 >> 16) | (s1 * ((uint64_t) 1 << 5));
    s[3]  = s1 >> 3;
    s[4]  = s1 >> 11;
    s[5]  = (s1 >> 19) | (s2 * ((uint64_t) 1 << 2));
    s[6]  = s2 >> 6;
    s[7]  = (s2 >> 14) | (s3 * ((uint64_t) 1 << 7));
    s[8]  = s3 >> 1;
    s[9]  = s3 >> 9;
    s[10] = (s3 >> 17) | (s4 * ((uint64_t) 1 << 4));
    s[11] = s4 >> 4;
    s[12] = s4 >> 12;
    s[13] = (s4 >> 20) | (s5 * ((uint64_t) 1 << 1));
    s[14] = s5 >> 7;
    s[15] = (s5 >> 15) | (s6 * ((uint64_t) 1 << 6));
    s[16] = s6 >> 2;
    s[17] = s6 >> 10;
    s[18] = (s6 >> 18) | (s7 * ((uint64_t) 1 << 3));
    s[19] = s7 >> 5;
    s[20] = s7 >> 13;
    s[21] = s8 >> 0;
    s[22] = s8 >> 8;
    s[23] = (s8 >> 16) | (s9 * ((uint64_t) 1 << 5));
    s[24] = s9 >> 3;
    s[25] = s9 >> 11;
    s[26] = (s9 >> 19) | (s10 * ((uint64_t) 1 << 2));
    s[27] = s10 >> 6;
    s[28] = (s10 >> 14) | (s11 * ((uint64_t) 1 << 7));
    s[29] = s11 >> 1;
    s[30] = s11 >> 9;
    s[31] = s11 >> 17;
}

void
sc25519_invert(unsigned char recip[32], const unsigned char s[32])
{
    unsigned char _10[32], _100[32], _1000[32], _10000[32], _100000[32],
        _1000000[32], _10010011[32], _10010111[32], _100110[32], _1010[32],
        _1010000[32], _1010011[32], _1011[32], _10110[32], _10111101[32],
        _11[32], _1100011[32], _1100111[32], _11010011[32], _1101011[32],
        _11100111[32], _11101011[32], _11110101[32];

    sc25519_sq(_10, s);
    sc25519_mul(_11, s, _10);
    sc25519_mul(_100, s, _11);
    sc25519_sq(_1000, _100);
    sc25519_mul(_1010, _10, _1000);
    sc25519_mul(_1011, s, _1010);
    sc25519_sq(_10000, _1000);
    sc25519_sq(_10110, _1011);
    sc25519_mul(_100000, _1010, _10110);
    sc25519_mul(_100110, _10000, _10110);
    sc25519_sq(_1000000, _100000);
    sc25519_mul(_1010000, _10000, _1000000);
    sc25519_mul(_1010011, _11, _1010000);
    sc25519_mul(_1100011, _10000, _1010011);
    sc25519_mul(_1100111, _100, _1100011);
    sc25519_mul(_1101011, _100, _1100111);
    sc25519_mul(_10010011, _1000000, _1010011);
    sc25519_mul(_10010111, _100, _10010011);
    sc25519_mul(_10111101, _100110, _10010111);
    sc25519_mul(_11010011, _10110, _10111101);
    sc25519_mul(_11100111, _1010000, _10010111);
    sc25519_mul(_11101011, _100, _11100111);
    sc25519_mul(_11110101, _1010, _11101011);

    sc25519_mul(recip, _1011, _11110101);
    sc25519_sqmul(recip, 126, _1010011);
    sc25519_sqmul(recip, 9, _10);
    sc25519_mul(recip, recip, _11110101);
    sc25519_sqmul(recip, 7, _1100111);
    sc25519_sqmul(recip, 9, _11110101);
    sc25519_sqmul(recip, 11, _10111101);
    sc25519_sqmul(recip, 8, _11100111);
    sc25519_sqmul(recip, 9, _1101011);
    sc25519_sqmul(recip, 6, _1011);
    sc25519_sqmul(recip, 14, _10010011);
    sc25519_sqmul(recip, 10, _1100011);
    sc25519_sqmul(recip, 9, _10010111);
    sc25519_sqmul(recip, 10, _11110101);
    sc25519_sqmul(recip, 8, _11010011);
    sc25519_sqmul(recip, 8, _11101011);
}

int
sc25519_is_canonical(const unsigned char s[32])
{
    /* 2^252+27742317777372353535851937790883648493 */
    static const unsigned char L[32] = {
        0xed, 0xd3, 0xf5, 0x5c, 0x1a, 0x63, 0x12, 0x58, 0xd6, 0x9c, 0xf7,
        0xa2, 0xde, 0xf9, 0xde, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10
    };
    unsigned char c = 0;
    unsigned char n = 1;
    unsigned int  i = 32;

    do {
        i--;
        c |= ((s[i] - L[i]) >> 8) & n;
        n &= ((s[i] ^ L[i]) - 1) >> 8;
    } while (i != 0);

    return (c != 0);
}

/* montgomery to edwards */
static void
ge25519_mont_to_ed(fe25519 xed, fe25519 yed, const fe25519 x, const fe25519 y)
{
    fe25519 one;
    fe25519 x_plus_one;
    fe25519 x_minus_one;
    fe25519 x_plus_one_y_inv;

    fe25519_1(one);
    fe25519_add(x_plus_one, x, one);
    fe25519_sub(x_minus_one, x, one);

    /* xed = sqrt(-A-2)*x/y */
    fe25519_mul(x_plus_one_y_inv, x_plus_one, y);
    fe25519_invert(x_plus_one_y_inv, x_plus_one_y_inv); /* 1/((x+1)*y) */
    fe25519_mul(xed, x, ed25519_sqrtam2);
    fe25519_mul(xed, xed, x_plus_one_y_inv);            /* sqrt(-A-2)*x/((x+1)*y) */
    fe25519_mul(xed, xed, x_plus_one);

    /* yed = (x-1)/(x+1) */
    fe25519_mul(yed, x_plus_one_y_inv, y);              /* 1/(x+1) */
    fe25519_mul(yed, yed, x_minus_one);
    fe25519_cmov(yed, one, fe25519_iszero(x_plus_one_y_inv));
}

void zero (unsigned char *const c, const size_t len) {
    for (int i = 0U; i < len; i++) {
        c[i] = 0;
    }
}

static unsigned char a[32] = {
  171,  69, 129,  47,  90,  82, 223, 134,
    6, 147,  54,  76,  55, 148, 252,  37,
  234, 216, 113,  62, 223,  49,  33,  36,
  172, 246,  18, 226,  50, 249, 198, 231
};

unsigned char too_big[32];

static unsigned char b[32] = {
  226,  38,  16,  80, 186, 183, 134, 239,
  190,  24, 150, 125,  14, 254,  19,  44,
   55, 112, 156,   5, 141, 230,  91,  84,
  110, 130, 213,  39, 249, 107, 145, 140
};

static unsigned char c[32] = {
  190,  24, 150, 125,  14, 254,  19,  44,
   55, 112, 156,   5, 141, 230,  91,  84,
  110, 130, 213,  39, 249, 107, 145, 140,
  226,  38,  16,  80, 186, 183, 134, 239
};

static unsigned char c64[64] = {
  190,  24, 150, 125,  14, 254,  19,  44,
   55, 112, 156,   5, 141, 230,  91,  84,
  110, 130, 213,  39, 249, 107, 145, 140,
  226,  38,  16,  80, 186, 183, 134, 239,
  190,  24, 150, 125,  14, 254,  19,  44,
   55, 112, 156,   5, 141, 230,  91,  84,
  110, 130, 213,  39, 249, 107, 145, 140,
  226,  38,  16,  80, 186, 183, 134, 239
};

int main (int argc, char   *argv[]) {
    static fe25519               f;
    static fe25519               g;
    static fe25519               h;
    char                     s[32];
    unsigned char          s64[64];
    static unsigned char   res[32];
    static char            hex[32];
    static char          hex64[64];
    int                          i;

    fe25519_frombytes(f, a);
    fe25519_frombytes(g, b);

    fe25519_mul(h, f, g);
    fe25519_tobytes(res, h);
    
    memset(hex, 0, sizeof hex);
    bin2hex(hex, sizeof hex, res, sizeof res);
    printf("fe_mul: %s\n", hex);

    // fe25519_sq(h, f);
    // fe25519_tobytes(res, h);

    // memset(hex, 0, sizeof hex);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("fe_sq:  %s\n", hex);

    // memset(too_big, 128, sizeof too_big);
    // fe25519_frombytes(f, b);
    // fe25519_tobytes(res, f);

    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("%s\n", hex);
    // fe25519_reduce(h, f);
    // fe25519_tobytes(res, h);

    // memset(hex, 0, sizeof hex);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("fe_red: %s\n", hex);

    // fe25519_frombytes(f, a);
    // fe25519_frombytes(g, b);
    // fe25519_sqmul(f, 8734U, g);
    // fe25519_tobytes(res, f);

    // memset(hex, 0, sizeof hex);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("fe_sqm: %s\n", hex);

    // fe25519_invert(f, f);
    // fe25519_tobytes(res, f);

    // memset(hex, 0, sizeof hex);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("fe_inv: %s\n", hex);

    // fe25519_pow22523(f, f);
    // fe25519_tobytes(res, f);

    // memset(hex, 0, sizeof hex);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("fe_p25: %s\n", hex);

    // fe25519_cneg(f, f, 1);
    // fe25519_tobytes(res, f);

    // memset(hex, 0, sizeof hex);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("fe_cng: %s\n", hex);

    // sc25519_mul(res, a, b);

    // memset(hex, 0, sizeof hex);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("sc_mul: %s\n", hex);

    // sc25519_muladd(res, a, b, c);

    // memset(hex, 0, sizeof hex);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("sc_mad: %s\n", hex);

    // memcpy(&s64, &c64, sizeof c64);
    // sc25519_reduce(s64);

    // bin2hex(hex, sizeof hex, s64, (sizeof s64) / 2);
    // printf("sc_red: %s\n", hex);

    // sc25519_invert(res, c);
    // bin2hex(hex, sizeof hex, res, sizeof res);
    // printf("sc_inv: %s\n", hex);

    // int canon = sc25519_is_canonical(b);
    // printf("canon:  %d\n", canon);
    return 1;
}

