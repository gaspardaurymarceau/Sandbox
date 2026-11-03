#include <stdio.h>
#include <stdbool.h>

int main() {

	char name[101];
	scanf("%s", name);
	bool alphabet[26];
	int diff_chars = 0;
	int idx = 0;
	int chr;

	for (int i = 0 ; i < 26 ; i++) {
		alphabet[i] = false;
	}

	while (name[idx] != '\0') {
		chr = name[idx++] - 97;
		if (!alphabet[chr]) {
			alphabet[chr] = true;
			diff_chars++;
		}
	}

	printf("%s", diff_chars % 2 == 0 ? "CHAT WITH HER!\n" : "IGNORE HIM!\n");
	return 0;


}
