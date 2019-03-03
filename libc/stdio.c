#include "../drivers/screen.h"

void clear_screen() {
  int row = 0;
  int col = 0;
  /* Loop through video memory and write blank characters. */
  for (row=0; row<MAX_ROWS; row++) {
    for (col=0; col<MAX_COLS; col++) {
      print_char(' ', col, row, WHITE_ON_BLACK);
    }
  }
  // Move the cursor back to the top left.
  set_cursor(get_screen_offset(0, 0));
}

void print(char* message) {
  print_at(message , -1, -1);
}

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
