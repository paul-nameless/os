#include "math.h"

void swap(char* x, char* y) {
  char t = *x;
  *x = *y;
  *y = t;
}

char* reverse(char* buffer, int i, int j) {
  while (i < j) {
    swap(&buffer[i++], &buffer[j--]);
  }
  return buffer;
}

char* itoa(int value, char* buffer, int base) {
  if (base < 2 || base > 32) {
    return buffer;
  }

  int n = abs(value);

  int i = 0;
  while (n) {
    int r = n % base;

    if (r >= 10) {
      buffer[i] = 65 + (r - 10);
    } else {
      buffer[i] = 48 + r;
    }

    i += 1;
    n = n / base;
  }

  // if number is 0
  if (i == 0) {
    buffer[i] = '0';
    i += 1;
  }

  if (value < 0 && base == 10) {
    buffer[i] = '-';
    i += 1;
  }

  buffer[i] = '\0';

  return reverse(buffer, 0, i - 1);
}

/* int atoi(char* value, int base) { */
/*   return 0; */
/* } */
