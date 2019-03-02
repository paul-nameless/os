#include "../include/stdio.h"
#include "../drivers/screen.h"
#include "../cpu/isr.h"

void main () {
  clear_screen();
  print("hello :)\n");
  print_hex(0xFACE);
  print("\n");

  isr_install();
  /* Test the interrupts */
  __asm__ __volatile__("int $2");
  __asm__ __volatile__("int $3");
}
