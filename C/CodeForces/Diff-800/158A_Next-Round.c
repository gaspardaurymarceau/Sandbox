#include <stdio.h>

int main() {

	int len;
	int k;
	scanf("%i %i", &len, &k);
	int to_keep = 0, to_equal = 1, idx = 1, score;

	do {
		scanf("%i", &score);
		if (idx == k && score > 0) to_equal = score;
		if (score >= to_equal) to_keep++;
		idx++;
	} while (score >= to_equal && idx <= len);

	printf("%i\n", to_keep);
	return 0;
}
