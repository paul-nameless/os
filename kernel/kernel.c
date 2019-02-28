#include "../drivers/screen.h"

void main () {
  // Create a pointer to a char , and point it to the first text cell of
  // video memory ( i . e . the top - left of the screen )
  /* char* video_memory = (char*) 0xb8000; */
  clear_screen();

  /* char* video_memory = (char*) 0xb8000; */
  // At the address pointed to by video_memory , store the character ’X ’
  // ( i . e . display ’X ’ in the top - left of the screen ).
  /* *video_memory = 'V'; */

  /* set_cursor(0); */
  /* int offset = get_cursor(); */
  /* print_char('H', offset, 2, WHITE_ON_BLACK); */
  /* print("Hello world"); */

  /* print_char((unsigned char)(offset), 0, 0, WHITE_ON_BLACK); */
  /* print_at("Hello :)", 0, 1); */
  /* print("Hello :)"); */
  /* print_at("------------------------------------------------------------------------------------------", 0, 2); */
  print("Hello\n>>");
}
