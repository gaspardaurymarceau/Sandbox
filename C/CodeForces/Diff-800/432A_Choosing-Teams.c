#include <stdio.h>

int main() {

	int candidates;
	int rounds;
	scanf("%i %i", &candidates, &rounds);
	int previous_rounds;
	int kept = 0;

	for (int i = 0 ; i < candidates ; i++) {
		scanf("%i", &previous_rounds);
		if (previous_rounds + rounds <= 5) kept++;
	}

	printf("%i", kept / 3);
	return 0;

}
