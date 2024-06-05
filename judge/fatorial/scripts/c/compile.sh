#!/bin/bash

#cat <<EOF >/tmp/rwdir/mainfunction$RANDOM$RANDOM.c
cat <<EOF >/tmp/rwdir/mainfunction.c
#include <stdio.h>

double cos (double x){
  printf("Bad function name: cos\n");
  abort();
}

double sin(double x){
  printf("Bad function name: sin\n");
  abort();
}

double tan(double x){
  printf("Bad function name: tan\n");
  abort();
}

double acos(double x){
  printf("Bad function name: acos\n");
  abort();
}

double asin(double x){
  printf("Bad function name: asin\n");
  abort();
}

double atan(double x){
  printf("Bad function name: atan\n");
  abort();
}

double atan2(double y, double x){
  printf("Bad function name: atan2\n");
  abort();
}

double cosh(double x){
  printf("Bad function name: cosh\n");
  abort();
}

double sinh(double x){
  printf("Bad function name: sinh\n");
  abort();
}

double tanh(double x){
  printf("Bad function name: tanh\n");
  abort();
}

double acosh(double x){
  printf("Bad function name: acosh\n");
  abort();
}

float acoshf (float x){
  printf("Bad function name: acoshf\n");
  abort();
}

long double acoshl (long double x){
  printf("Bad function name: acoshl\n");
  abort();
}

double asinh(double x){
  printf("Bad function name: asinh\n");
  abort();
}

float asinhf (float x){
  printf("Bad function name: asinhf\n");
  abort();
}

long double asinhl (long double x){
  printf("Bad function name: asinhl\n");
  abort();
}

double atanh(double x){
  printf("Bad function name: atanh\n");
  abort();
}

float atanhf (float x){
  printf("Bad function name: atanhf\n");
  abort();
}

long double atanhl (long double x){
  printf("Bad function name: atanhl\n");
  abort();
}

double exp(double x){
  printf("Bad function name: exp\n");
  abort();
}

double frexp (double x, int* exp){
  printf("Bad function name: frexp\n");
  abort();
}

double ldexp(double x, int exp){
  printf("Bad function name: ldexp\n");
  abort();
}

double log(double x){
  printf("Bad function name: log\n");
  abort();
}

double log10(double x){
  printf("Bad function name: log\n");
  abort();
}

double modf(double x, double* intpart){
  printf("Bad function name: modf\n");
  abort();
}

double exp2(double x){
  printf("Bad function name: exp2 \n");
  abort();
}

float exp2f (float x){
  printf("Bad function name: exp2f\n");
  abort();
}

long double exp2l (long double x){
  printf("Bad function name: exp2l\n");
  abort();
}

double expm1(double x){
  printf("Bad function name: expm1 \n");
  abort();
}

float expm1f (float x){
  printf("Bad function name: expm1f\n");
  abort();
}

long double expm1l (long double x){
  printf("Bad function name: expm1l\n");
  abort();
}

double ilogb(double x){
  printf("Bad function name: ilogb \n");
  abort();
}

float ilogbf (float x){
  printf("Bad function name: ilogbf\n");
  abort();
}

long double ilogbl (long double x){
  printf("Bad function name: ilogbl\n");
  abort();
}

double log1p(double x){
  printf("Bad function name: log1p \n");
  abort();
}

float log1pf (float x){
  printf("Bad function name: log1pf\n");
  abort();
}

long double log1pl (long double x){
  printf("Bad function name: log1pl\n");
  abort();
}

double log2(double x){
  printf("Bad function name: log1p \n");
  abort();
}

float log2f (float x){
  printf("Bad function name: log1pf\n");
  abort();
}

long double log2l (long double x){
  printf("Bad function name: log1pl\n");
  abort();
}

double logb(double x){
  printf("Bad function name: logb \n");
  abort();
}

float logbf (float x){
  printf("Bad function name: logbf\n");
  abort();
}

long double logbl (long double x){
  printf("Bad function name: logbl\n");
  abort();
}

double scalbn(double x     , int n){
  printf("Bad function name: scalbn \n");
  abort();
}

float scalbnf (float x      , int n){
  printf("Bad function name: scalbnf\n");
  abort();
}

long double scalbnl (long double x, int n){
  printf("Bad function name: scalbnl\n");
  abort();
}

double scalbln(double x     , long int n){
  printf("Bad function name: scalbln \n");
  abort();
}

float scalblnf (float x      , long int n){
  printf("Bad function name: scalblnf\n");
  abort();
}

long double scalblnl (long double x, long int n){
  printf("Bad function name: scalblnl\n");
  abort();
}

double pow  (double base     , double exponent){
  printf("Bad function name: pow \n");
  abort();
}

float powf (float base      , float exponent){
  printf("Bad function name: powf \n");
  abort();
}

long double powl (long double base, long double exponent){
  printf("Bad function name: powl \n");
  abort();
}

double sqrt  (double x){
  printf("Bad function name: sqrt \n");
  abort();
}

float sqrtf (float x){
  printf("Bad function name: sqrtf \n");
  abort();
}

long double sqrtl (long double x){
  printf("Bad function name: sqrtl \n");
  abort();
}

double cbrt  (double x){
  printf("Bad function name: cbrt \n");
  abort();
}

float cbrtf  (float x){
  printf("Bad function name: cbrtf  \n");
  abort();
}

long double cbrtl  (long double x){
  printf("Bad function name: cbrtl  \n");
  abort();
}

double hypot  (double x     , double y){
  printf("Bad function name: hypot \n");
  abort();
}

float hypotf (float x      , float y){
  printf("Bad function name: hypotf  \n");
  abort();
}

long double hypotl (long double x, long double y){
  printf("Bad function name: hypotl  \n");
  abort();
}

double erf  (double x){
  printf("Bad function name: erf \n");
  abort();
}

float erff (float x){
  printf("Bad function name: erff  \n");
  abort();
}

long double erfl (long double x){
  printf("Bad function name: erfl  \n");
  abort();
}

double erfc (double x){
  printf("Bad function name: erfc\n");
  abort();
}

float erfcf (float x){
  printf("Bad function name: erfcf\n");
  abort();
}

long double erfcl (long double x){
  printf("Bad function name: erfcl\n");
  abort();
}

double tgamma (double x){
  printf("Bad function name: tgamma\n");
  abort();
}

float tgammaf (float x){
  printf("Bad function name: tgammaf\n");
  abort();
}

long double tgammal (long double x){
  printf("Bad function name: tgammal\n");
  abort();
}

double lgamma (double x){
  printf("Bad function name: lgamma\n");
  abort();
}

float lgammaf (float x){
  printf("Bad function name: lgammaf\n");
  abort();
}

long double lgammal (long double x){
  printf("Bad function name: lgammal\n");
  abort();
}

double ceil (double x){
  printf("Bad function name: ceil\n");
  abort();
}

float ceilf (float x){
  printf("Bad function name: ceilf\n");
  abort();
}

long double ceill (long double x){
  printf("Bad function name: ceill\n");
  abort();
}

double floor (double x){
  printf("Bad function name: floor\n");
  abort();
}

float floorf (float x){
  printf("Bad function name: floorf\n");
  abort();
}

long double floorl (long double x){
  printf("Bad function name: floorl\n");
  abort();
}

double fmod  (double numer     , double denom){
  printf("Bad function name: fmod\n");
  abort();
}

float fmodf (float numer      , float denom){
  printf("Bad function name: fmodf\n");
  abort();
}

long double fmodl (long double numer, long double denom){
  printf("Bad function name: fmodl\n");
  abort();
}

double trunc (double x){
  printf("Bad function name: trunc\n");
  abort();
}

float truncf (float x){
  printf("Bad function name: truncf\n");
  abort();
}

long double truncl (long double x){
  printf("Bad function name: truncl\n");
  abort();
}

double round (double x){
  printf("Bad function name: round\n");
  abort();
}

float roundf (float x){
  printf("Bad function name: roundf\n");
  abort();
}

long double roundl (long double x){
  printf("Bad function name: roundl\n");
  abort();
}

long int lround  (double x){
  printf("Bad function name: lround\n");
  abort();
}

long int lroundf (float x){
  printf("Bad function name: lroundf\n");
  abort();
}

long int lroundl (long double x){
  printf("Bad function name: lroundl\n");
  abort();
}

long long int llround  (double x){
  printf("Bad function name: llround\n");
  abort();
}

long long int llroundf (float x){
  printf("Bad function name: llroundf\n");
  abort();
}

long long int llroundl (long double x){
  printf("Bad function name: llroundl\n");
  abort();
}

double rint (double x){
  printf("Bad function name: rint\n");
  abort();
}

float rintf (float x){
  printf("Bad function name: rintf\n");
  abort();
}

long double rintl (long double x){
  printf("Bad function name: rintl\n");
  abort();
}

long int lrint (double x){
  printf("Bad function name: lrint\n");
  abort();
}

long int lrintf (float x){
  printf("Bad function name: lrintf\n");
  abort();
}

long int lrintl (long double x){
  printf("Bad function name: lrintl\n");
  abort();
}

long long int llrint (double x){
  printf("Bad function name: llrint\n");
  abort();
}

long long int llrintf (float x){
  printf("Bad function name: llrintf\n");
  abort();
}

long long int llrintl (long double x){
  printf("Bad function name: llrintl\n");
  abort();
}

double nearbyint (double x){
  printf("Bad function name: nearbyint\n");
  abort();
}

float nearbyintf (float x){
  printf("Bad function name: nearbyintf\n");
  abort();
}

long double nearbyintl (long double x){
  printf("Bad function name: nearbyintl\n");
  abort();
}

double remainder  (double numer     , double denom){
  printf("Bad function name: remainder\n");
  abort();
}

float remainderf (float numer      , float denom){
  printf("Bad function name: remainderf\n");
  abort();
}

long double remainderl (long double numer, long double denom){
  printf("Bad function name: remainderl\n");
  abort();
}

double remquo  (double numer     , double denom     , int* quot){
  printf("Bad function name: remquo\n");
  abort();
}

float remquof (float numer      , float denom      , int* quot){
  printf("Bad function name: remquof\n");
  abort();
}

long double remquol (long double numer, long double denom, int* quot){
  printf("Bad function name: remquol\n");
  abort();
}

double copysign  (double x     , double y){
  printf("Bad function name: copysign\n");
  abort();
}

float copysignf (float x      , float y){
  printf("Bad function name: copysignf\n");
  abort();
}

long double copysignl (long double x, long double y){
  printf("Bad function name: copysignl\n");
  abort();
}

double nan (const char* tagp){
  printf("Bad function name: nan\n");
  abort();
}

double nextafter  (double x     , double y){
  printf("Bad function name: nextafter\n");
  abort();
}

float nextafterf (float x      , float y){
  printf("Bad function name: nextafterf\n");
  abort();
}

long double nextafterl (long double x, long double y){
  printf("Bad function name: nextafterl\n");
  abort();
}

double nexttoward  (double x     , long double y){
  printf("Bad function name: nexttoward\n");
  abort();
}

float nexttowardf (float x      , long double y){
  printf("Bad function name: nexttowardf\n");
  abort();
}

long double nexttowardl (long double x, long double y){
  printf("Bad function name: nexttowardl\n");
  abort();
}

double fdim  (double x     , double y){
  printf("Bad function name: fdim\n");
  abort();
}

float fdimf (float x      , float y){
  printf("Bad function name: fdimf\n");
  abort();
}

long double fdiml (long double x, long double y){
  printf("Bad function name: fdiml\n");
  abort();
}

double fmax  (double x     , double y){
  printf("Bad function name: fmax\n");
  abort();
}

float fmaxf (float x      , float y){
  printf("Bad function name: fmaxf\n");
  abort();
}

long double fmaxl (long double x, long double y){
  printf("Bad function name: fmaxl\n");
  abort();
}

double fmin  (double x     , double y){
  printf("Bad function name: fmin\n");
  abort();
}

float fminf (float x      , float y){
  printf("Bad function name: fminf\n");
  abort();
}

long double fminl (long double x, long double y){
  printf("Bad function name: fminl\n");
  abort();
}

double fabs (double x){
  printf("Bad function name: fabs\n");
  abort();
}

float fabsf (float x){
  printf("Bad function name: fabsf\n");
  abort();
}

long double fabsl (long double x){
  printf("Bad function name: fabsl\n");
  abort();
}

double fma  (double x     , double y     , double z){
  printf("Bad function name: fma\n");
  abort();
}

float fmaf (float x      , float y      , float z){
  printf("Bad function name: fmaf\n");
  abort();
}

long double fmal (long double x, long double y, long double z){
  printf("Bad function name: fmal\n");
  abort();
}


int fatorial(int n);

int main(){
  int n;

  scanf("%d", &n);
  printf("%d\n", fatorial(n));
  
  return 0;
}
EOF

exec 2>/tmp/stderrlog > /tmp/out
cd /tmp/rwdir

cat > Makefile << 'EOF'

SRC=$(wildcard *.c)
CFLAGS=-lm -O2 -static

main: ${SRC}
	gcc ${CFLAGS} $^ -o $@ -lm
	@echo BIN=$@
EOF

unset MAKELEVEL
echo "-lm -O2 -static"
#make
