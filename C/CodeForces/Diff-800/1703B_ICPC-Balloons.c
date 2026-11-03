#include <stdio.h>
#include <stdlib.h>

int reset_problems(char* problems) {

	for (int i = 0 ; i < 26 ; i++) {
		problems[i] = 0;
	}
	return 0;

}

int read_score(char* problems) {
	
	reset_problems(problems);
	int len;
	scanf("%i", &len);
	int balloons = 0;
	char* solutions = malloc(len + 1);
	scanf("%s", solutions);

	for (int i = 0 ; i < len ; i++) {
		if (!problems[solutions[i] - 65]) {
			balloons += 2;
			problems[solutions[i] - 65] = 1;
		} else balloons++;
	}

	free(solutions);
	solutions = NULL;
	return balloons;

}

int main() {

	int test_cases;
	scanf("%i", &test_cases);
	char problems[26];
	int* results = (int*) malloc(test_cases * sizeof(int));

	for (int i = 0 ; i < test_cases ; i++) {
		results[i] = read_score(problems);
	}

	for (int i = 0 ; i < test_cases ; i++) {
		printf("%i\n", results[i]);
	}

	free(results);
	results = NULL;
	return 0;

}
