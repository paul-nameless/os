void memory_copy(char* source, char* dest, int n_bytes) {
  int i;
  for (i = 0; i < n_bytes; i++) {
    *(dest + i) = *(source + i);
  }
}

/* This should be computed at link time, but a hardcoded
 * value is fine for now. Remember that our kernel starts
 * at 0x1000 as defined on the Makefile */
unsigned int free_mem_addr = 0x10000;
/* Implementation is just a pointer to some free memory which
 * keeps growing */
unsigned int kmalloc(unsigned int size, int align, unsigned int *phys_addr) {
    /* Pages are aligned to 4K, or 0x1000 */
    if (align == 1 && (free_mem_addr & 0xFFFFF000)) {
        free_mem_addr &= 0xFFFFF000;
        free_mem_addr += 0x1000;
    }
    /* Save also the physical address */
    if (phys_addr) {
      *phys_addr = free_mem_addr;
    }

    unsigned int ret = free_mem_addr;
    free_mem_addr += size; /* Remember to increment the pointer */
    return ret;
}
