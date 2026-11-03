#include <stdio.h>
#include <stdlib.h>

int main() {

	int n;
	int t;
	scanf("%i %i", &n, &t);
	int idx;
	char* queue = (char*) malloc(n + 1);
	scanf("%s", queue);

	for (int i = 0 ; i < t ; i++) {
		idx = 0;
		while (idx < n - 1) {
			if (queue[idx++] == 'B' && queue[idx] == 'G') {
				queue[idx - 1] = 'G';
				queue[idx] = 'B';
				idx++;
			}
		}
	}

	printf("%s", queue);
	return 0;

}
