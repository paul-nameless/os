#include "../drivers/screen.h"

/*
%[flags][width][.precision][length]specifier
%d
%x
*/
int printf(char* format) {
    /* ... */
    /* int *ap, x, c ; */
    /* ap = &fmt ; /\* argument pointer *\/ */
    /* ap++; /\* ap now points to first optional argument *\/ */
    /* ... */
  // iterate over format
  print(format);
  return 0;
}

#define HEX_BUF_LEN 7
#define ASCII_NUM_OFFSET 48
#define ASCII_ALPHA_OFFSET 55


int print_hex(int number) {
  // string buffer followed by null terminated character
  char buf[HEX_BUF_LEN] = {'0', 'x', 0, 0, 0, 0, 0};
  for (int i = 0; i < 4; i++) {
    char c = (number >> i * 4) & 0xf;
    if (c < 9) {
      c += ASCII_NUM_OFFSET;
    } else {
      c += ASCII_ALPHA_OFFSET;
    }
    buf[HEX_BUF_LEN-2-i] = c;
  }
  print(buf);
  return HEX_BUF_LEN - 1;
}
