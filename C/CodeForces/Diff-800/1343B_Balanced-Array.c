#include <stdio.h>
#include <stdlib.h>
int make_balanced_array(int* array_to_fill, int len) {

	int half_len = len / 2;

	for (int i = 0 ; i < half_len ; i += 2) {
		int num = i + 2;
		array_to_fill[i] = num;
		array_to_fill[i + 1] = len + 2 - num;
		array_to_fill[half_len + i] = num - 1;
		array_to_fill[half_len + i + 1] = len + 3 - num;
	}

	return 0;

}

int print_array(int* array_to_print, int len) {

	for (int i = 0 ; i < len ; i++) {
		if (i == len - 1) {
			printf("%i", array_to_print[i]);
		} else {
			printf("%i ", array_to_print[i]);
		}
	}

	printf("\n");
	return 0;

}

int main() {

	int test_cases;
	scanf("%i", &test_cases);
	int* lengths = (int*) malloc(test_cases * sizeof(int*));
	int len;

	for (int i = 0 ; i < test_cases ; i++) {
		
		scanf("%i", &len);
		
		if (len % 4 == 0) {
			lengths[i] = len;
		} else {
			lengths[i] = -1;
		}
	}

	for (int i = 0 ; i < test_cases ; i++) {
		
		len = lengths[i];
		if (len == -1) {
			printf("NO\n");
		} else {
			printf("YES\n");
			int* balanced_array = (int*) malloc(len * sizeof(int));
			make_balanced_array(balanced_array, len);
			print_array(balanced_array, len);
			free(balanced_array);
			balanced_array = NULL;
		}
		
	}
	free(lengths);
	lengths = NULL;
	return 0;

}
