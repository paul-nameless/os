#include "../libc/stdio.h"
#include "../drivers/keyboard.h"
#include "../cpu/isr.h"
#include "../cpu/timer.h"

void main () {
  clear_screen();
  print("hello :)\n");
  print_hex(0xFACE);
  print("\n");

  isr_install();
  /* Test the interrupts */
  __asm__ __volatile__("int $2");
  __asm__ __volatile__("int $3");

  /* asm volatile("sti"); */
  /* init_timer(50); */

  // sti shoud be called for irq
  asm volatile("sti");
  init_keyboard();
}
