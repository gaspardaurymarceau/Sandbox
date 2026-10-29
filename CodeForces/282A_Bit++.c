#include <stdio.h>

int main() {

	int num_instr;
	scanf("%i", &num_instr);
	char instruction[4];
	int x = 0;

	for (int i = 0 ; i < num_instr ; i++) {
		scanf("%s", instruction);
		x += (instruction[1] == '+') ? 1 : -1;
	}

	printf("%i\n", x);
	return 0;

}
