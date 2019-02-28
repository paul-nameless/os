void memory_copy(char* source, char* dest, int n_bytes) {
  int i;
  for (i = 0; i < n_bytes; i++) {
    *(dest + i) = *(source + i);
  }
}
