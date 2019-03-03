#include "../libc/stdio.h"
#include "../libc/stdlib.h"
#include "../cpu/isr.h"

void main () {
  clear_screen();
  /* print("hello :)\n"); */
  /* print_hex(0xFACE); */
  /* print("\n"); */
  print("> ");

  isr_install();
  irq_install();

  /* Test the interrupts */
  /* __asm__ __volatile__("int $2"); */
  /* __asm__ __volatile__("int $3"); */

}
