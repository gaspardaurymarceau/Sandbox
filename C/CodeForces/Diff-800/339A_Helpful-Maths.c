#include <stdio.h>

int main() {

	char expression[101];
	scanf("%s", expression);
	int nums[3] = {0, 0, 0};
	int idx = 0;
	char skipped = ' ';

	while (skipped != '\0') {
		nums[expression[idx++] - 49] += 1;
		skipped = expression[idx++];
	}

	idx = 0;

	for (int i = 0 ; i < 3 ; i++) {
		for (int j = 0 ; j < nums[i] ; j++) {
			expression[idx] = i + 49;
			idx += 2;
		}
	}

	printf("%s\n", expression);
	return 0;

}
