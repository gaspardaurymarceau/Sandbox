#include <stdio.h>
#include <stdlib.h>

/* Problem :

Input

The first (and the only) input line contains integer number w (1 ≤ w ≤ 100) — the weight of the watermelon bought by the boys.

Output

Print YES, if the boys can divide the watermelon into two parts, each of them weighing even number of kilos; and NO in the opposite case.i

*/

int main() {
	
	int weight;
	scanf("%i", &weight);
	
	if (weight > 3 && weight % 2 == 0 && weight <= 100) {
		printf("%s\n", "YES");
		return 0;
	}

	printf("%s\n", "NO");
	return 0;
	
}
