#include <stdio.h>

int main() {

	char expression[101];
	scanf("%s", expression);
	int nums[3] = {0, 0, 0};
	int idx = 0;

	while (expression[idx + 1] != '\0') {
		nums[expression[idx] - 30]++;
		idx += 2;
	}

	

	for (int i = 0 ; i < 3 ; i++) {
		for (int j = 0 ; j < nums[i] ; j++) {
			expression[j++] = i + 30;
			expression[j] = '+';
		}
	}

}
