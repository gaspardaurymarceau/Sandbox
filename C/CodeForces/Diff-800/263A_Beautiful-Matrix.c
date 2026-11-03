#include <stdio.h>

int main() {

	int x = 0, y = 0;
	int reader;
	scanf("%i", &reader);
	
	while (reader == 0 && (x != 4 || y != 4)) {
		y++;
		if (y == 5) {
			x++;
			y = 0;
		}
		scanf("%i", &reader);
	}

	printf("%i", (x > 2 ? x - 2 : 2 - x) + (y > 2 ? y - 2 : 2 - y));
	return 0;

}
