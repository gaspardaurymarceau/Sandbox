#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {

	// printf("Input the number of words you want to give, followed by the list of words :\n");
	char len_str[4];
	scanf("%s", len_str);
	int len = atoi(len_str);
	char* output = malloc(11 * len);
	
	for (int i = 0 ; i < len ; i++) {
		int start = 11 * i;
		char word[101];
		scanf("%s", word);
		int wlen = strlen(word);
		int slen = wlen - 2;
		if (wlen <= 10) {
			strcpy(&output[start], word);
		} else if (wlen < 12) {
			output[start] = word[0];
			output[start+1] = 48 + slen;
			output[start+2] = word[slen + 1];
			output[start+3] = '\0';
		} else {
			output[start] = word[0];
			output[start+1] = 48 + (slen / 10);
			output[start+2] = 48 + (slen % 10);
			output[start+3] = word[slen + 1];
			output[start+4] = '\0';
		}
	}

	// printf("Output (shortened words) :\n");
	
	for (int i = 0 ; i < len ; i++) {
		printf("%s\n", &output[11 * i]);
	}

	free(output);
	output = NULL;

	return 0;

}
