#ifndef   MEM_H
#define   MEM_H

void memory_copy(char* source, char* dest, int n_bytes);

/* At this stage there is no 'free' implemented. */
unsigned int kmalloc(unsigned int size, int align, unsigned int *phys_addr);

#endif
