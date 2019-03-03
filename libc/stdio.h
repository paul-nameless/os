#ifndef STDIO_H
#define STDIO_H

void clear_screen();
void print(char* format);

int print_hex(int n);

int printf(char* format, ...);
int sprintf(char* format, ...);

#endif
