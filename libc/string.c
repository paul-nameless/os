int strlen(char* str) {
  int i = 0;
  while (str[i++] != '\0');
  return i - 1;
}

/* Returns <0 if s1<s2, 0 if s1==s2, >0 if s1>s2 */
int strcmp(char s1[], char s2[]) {
    int i;
    for (i = 0; s1[i] == s2[i]; i++) {
      if (s1[i] == '\0') {
        return 0;
      }
    }
    return s1[i] - s2[i];
}

void append(char s[], char n) {
    int len = strlen(s);
    s[len] = n;
    s[len+1] = '\0';
}

void backspace(char s[]) {
    int len = strlen(s);
    s[len-1] = '\0';
}
