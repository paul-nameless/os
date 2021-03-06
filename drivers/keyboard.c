#include "keyboard.h"
#include "../cpu/ports.h"
#include "../cpu/isr.h"
#include "../cpu/types.h"
#include "../libc/stdio.h"
#include "../libc/string.h"
#include "../libc/mem.h"

#define UNUSED(x) (void)(x)

#define BACKSPACE 0x0E
#define ENTER 0x1C

static char key_buffer[256];

#define SC_MAX 57
const char *sc_name[] = { "ERROR", "Esc", "1", "2", "3", "4", "5", "6",
    "7", "8", "9", "0", "-", "=", "Backspace", "Tab", "Q", "W", "E",
        "R", "T", "Y", "U", "I", "O", "P", "[", "]", "Enter", "Lctrl",
        "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "`",
        "LShift", "\\", "Z", "X", "C", "V", "B", "N", "M", ",", ".",
        "/", "RShift", "Keypad *", "LAlt", "Spacebar"};
const char sc_ascii[] = { '?', '?', '1', '2', '3', '4', '5', '6',
    '7', '8', '9', '0', '-', '=', '?', '?', 'Q', 'W', 'E', 'R', 'T', 'Y',
        'U', 'I', 'O', 'P', '[', ']', '?', '?', 'A', 'S', 'D', 'F', 'G',
        'H', 'J', 'K', 'L', ';', '\'', '`', '?', '\\', 'Z', 'X', 'C', 'V',
        'B', 'N', 'M', ',', '.', '/', '?', '?', '?', ' '};

void user_input(char *input) {
    if (strcmp(input, "HALT") == 0) {
        print("Stopping the CPU. Bye!\n");
        __asm__ __volatile__("hlt");
    } else if (strcmp(input, "PAGE") == 0) {
      /* Lesson 22: Code to test kmalloc, the rest is unchanged */
      u32 phys_addr;
      u32 page = kmalloc(1000, 1, &phys_addr);
      print("Page: ");
      print_hex(page);
      print(", physical address: ");
      print_hex(phys_addr);
      print("\n");
    }

    print("You said: ");
    print(input);
    print("\n> ");
}

static void keyboard_callback(registers_t r) {
    /* The PIC leaves us the scancode in port 0x60 */
    /* The PIC leaves us the scancode in port 0x60 */
    u8 scancode = port_byte_in(0x60);

    if (scancode > SC_MAX) return;
    if (scancode == BACKSPACE) {
        backspace(key_buffer);
        print_backspace();
    } else if (scancode == ENTER) {
        print("\n");
        user_input(key_buffer); /* kernel-controlled function */
        key_buffer[0] = '\0';
    } else {
        char letter = sc_ascii[(int)scancode];
        /* Remember that kprint only accepts char[] */
        char str[2] = {letter, '\0'};
        append(key_buffer, letter);
        print(str);
    }
    UNUSED(r);
}

void init_keyboard() {
   register_interrupt_handler(IRQ1, keyboard_callback);
}
