#include <stdio.h>
#include <string.h>

int main() {

	char word1[101];
	char word2[101];
	scanf("%s\n%s", word1, word2);
	int len = strlen(word1);

	if (strlen(word2) != len) {
		printf("NO\n");
		return 0;
	}

	for (int i = 0 ; i < len ; i++) {
		if (word1[i] != word2[len - i - 1]) {
		printf("NO\n");
		return 0;
		}
	}

	printf("YES\n");
	return 0;

}
