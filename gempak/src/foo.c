#include <stdio.h>

main() {
float	foo;
	(void) scanf("%f", &foo);
	(void) printf("%f\n", foo);
	if (foo > 0.0)
		(void) printf("%f > 0\n", foo);
	else if (foo == 0.0)
		(void) printf("%f = 0\n", foo);
	else if (foo < 0.0)
		(void) printf("%f < 0\n", foo);
	else
		(void) printf("%f is not a number\n", foo);
}
