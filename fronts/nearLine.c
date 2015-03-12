#include <stdio.h>
#include <math.h>
#include "pythagoras.h"
#include "nearLine.h"

/*
 * nearLine:
 *
 *	This function computes the distance between a point and a line
 * segment.
 *
 */
double	nearLine(double x, double y,
	double x1, double y1,
	double x2, double y2) {
double	d1 = pythagoras(x - x1, y - y1),
	d2 = pythagoras(x - x2, y - y2),
	d3,
	distance = d1,
	slope = (y1 - y2) / (x1 - x2),
	x3,
	y3;

/* The segment can't be farther away than the closer endpoint. */
/* Use this distance unless the normal through the point */
/*  intersects the segment. */
	if (d2 < d1)
		distance = d2;

	if (fabs(slope) < Epsilon) {
	/* The line segment is effectively horizontal; y1 ~= y2 */
#ifdef DEBUG
		(void) printf("horizontal\n");
#endif

	/* Is the point between the normals at the endpoints? */
		if (((x > x1) && (x > x2)) || ((x < x1) && (x < x2)))
		/* No. */
			return distance;
		else
		/* Yes; use the vertical distance. */
			return fabs(y - y1 + y - y2) / 2.0;

	} else if (fabs(slope) > (1 / Epsilon)) {
	/* The line segment is effectively vertical; x1 ~= x2 */
#ifdef DEBUG
		(void) printf("vertical\n");
#endif

	/* Is the point between the normals at the endpoints? */
		if (((y > y1) && (y > y2)) || ((y < y1) && (y < y2)))
		/* No. */
			return distance;
		else
		/* Yes; use the horizontal distance. */
			return fabs(x - x1 + x - x2) / 2.0;

	} else {
	/* general case */

		x3 = (slope * slope * x1 - slope * (y1 - y) + x)
			/ (slope * slope + 1);
		y3 = (slope * slope * y - slope * (x1 - x) + y1)
			/ (slope * slope + 1);
		d3 = pythagoras(x - x3, y - y3);
#ifdef DEBUG
		(void) printf("front: (%.3f, %.3f) to (%.3f, %.3f)\n",
			x1, y1, x2, y2);
		(void) printf("city:  (%.3f, %.3f)\n", x, y);
		(void) printf("intersection:  (%.3f, %.3f)\n", x3, y3);
		(void) printf("intersection distance:  %.3f\n", d3);
		(void) printf("endpoint distance:  %.3f\n", distance);
#endif

	/* Is the intersection on the line segment? */
		if (((x3 > x1) && (x3 > x2)) || ((x3 < x1) && (x3 < x2)))
		/* No. */
			return distance;
		else
		/* Yes. */
			return d3;
	}
}
