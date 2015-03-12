#include <stdio.h>
#include "nearLine.h"

main() {
float	x, y,
	x1, y1,
	x2, y2;

	while (!feof(stdin)) {
		(void) printf("x, y, x1, y1, x2, y2:  ");
		(void) scanf("%f %f %f %f %f %f", &x, &y, &x1, &y1, &x2, &y2);
		(void) printf("distance:  %.3f\n",
			nearLine(x, y, x1, y1, x2, y2));
	}
}
