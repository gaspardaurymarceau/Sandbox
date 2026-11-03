#include <stdio.h>

int main() {

	int dims[2];
	scanf("%i %i", dims, &dims[1]);
	printf("%i\n", (dims[0] / 2) *  dims[1] + (dims[0] % 2) * (dims[1] / 2));
	return 0;

}
