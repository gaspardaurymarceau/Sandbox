#include <stdio.h>

int main() {

	int num_probs;
	scanf("%i", &num_probs);
	int output = 0;
	int answers[3];

	for (int i = 0 ; i < num_probs ; i++) {
		scanf("%i %i %i", &answers[0], &answers[1], &answers[2]);
		if (answers[0] + answers[1] + answers[2] > 1) output++;
	}

	printf("%i\n", output);
	return 0;

}
