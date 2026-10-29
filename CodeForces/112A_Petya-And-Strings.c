#include <stdio.h>

char lowercase(char c) {
	return (c >= 65 && c <= 90) ? c + 32 : c;
	
}

int main() {

	char word1[101];
	char word2[101];
	scanf("%s\n%s", word1, word2);
	int idx = 0;
	int cmp;

	while (word1[idx] != '\0') {
		cmp = lowercase(word1[idx]) - lowercase(word2[idx++]);
		if (cmp != 0) {
			printf("%s", cmp < 0 ? "-1\n" : "1\n");
			return 0;
		}
	}

	printf("0\n");

	return 0;

}
