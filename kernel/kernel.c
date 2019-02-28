#include "../include/stdio.h"
#include "../drivers/screen.h"

void main () {
  clear_screen();
  print("hello :)\n");
  print_hex(0xFACE);
}
