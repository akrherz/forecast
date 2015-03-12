#include <stdio.h>
#include <string.h>
#include "distance.h"
#include "pythagoras.h"
#include "nearLine.h"

#define StrLen	256

/*
 * range:
 *
 *	This function does the actual work of figuring out whether a city
 * is within the specified range of a set of fronts.  The main() function
 * is just a driver and reporter.
 *
 */
int	range(double lat, double lon, double d, FILE *in) {
float	newLat,
	newLon,
	oldLat,
	oldLon;
char	line[StrLen],
	oldValid;

/* Process the whole file */
	while (!feof(in)) {
		oldValid = 'f';
	/* Deal with one front at a time; they're not necessarily connected. */
		while ((fgets(line, StrLen, in) != NULL) \
			&& (strcmp(line, "front\n"))) {
		/* Read the point. */
			(void) sscanf(line, "%f %f", &newLat, &newLon);
			if (pythagoras(lat - newLat, lon - newLon) <= d)
			/* The endpoint is close enough; good enough. */
				return Close;

			if (oldValid == 't') {
			/* Are the points distinct? */
				if (pythagoras(newLat - oldLat,
					newLon - oldLon) > Delta) {
				/* Yes.  Use them. */
					if (nearLine(lat, lon,
						newLat, newLon,
						oldLat, oldLon) <= d)
						return Close;
				}
			/* No.  Do nothing. */
			} else {
				oldLat = newLat;
				oldLon = newLon;
				oldValid = 't';
			}
		}
	}

/* No errors, but no front in range. */
	return Far;
}
