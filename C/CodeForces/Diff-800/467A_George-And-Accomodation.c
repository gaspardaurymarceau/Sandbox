#include <stdio.h>

int main() {

	int rooms;
	scanf("%i", &rooms);
	int occ;
	int max;
	int possible = 0;

	for (int i = 0 ; i < rooms ; i++) {
		scanf("%i %i", &occ, &max);
		if (max - occ > 1) possible++;
	}

	printf("%i", possible);
	return 0;

}
