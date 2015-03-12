#include <stdio.h>
#include "distance.h"

#define CloseName	"close.txt"
#define FarName	"far.txt"
#define ErrName	"err.txt"

/*
 * distance:
 *
 *	This program figures out whether a city is within a certain distance
 * of a set of fronts.
 *
 */
main(int argc, char **argv) {
float	d,
	lat,
	lon;
FILE	*fronts,
	*out;

/* Did the user provide enough information? */
	if (argc < 6) {
	/* No. */
		(void) fprintf(stderr,
			"%s synopsis:  %s name lat lon d fronts",
			argv[0], argv[0]);
		return BadArg;
	}

/* Try to read the fronts file. */
	fronts = fopen(argv[5], "r");
	if (fronts == (FILE *) NULL) {
		(void) fprintf(stderr,
			"%s:  unable to read fronts file %s.\n",
			argv[0], argv[5]);
		return BadFile;
	}

/* Is the city close enough? */
	(void) sscanf(argv[2], "%f", &lat);
	(void) sscanf(argv[3], "%f", &lon);
	(void) sscanf(argv[4], "%f", &d);
	/* I would have preferred to use atof, but that claims that */
	/* all numbers are -48. */

	switch (range(lat, lon, d, fronts)) {
	case Close:
	/* Close enough; report success. */
		out = fopen(CloseName, "a");
		(void) fprintf(out, "%s\tclose\n", argv[1]);
		(void) fclose(out);
		break;
	case Far:
	/* Too far; report failure. */
		out = fopen(FarName, "a");
		(void) fprintf(out, "%s\tfar\n", argv[1]);
		(void) fclose(out);
		break;
	case Error:
	/* Unable to process; report error. */
		out = fopen(ErrName, "a");
		(void) fprintf(out, "%s\n", argv[1]);
		(void) fclose(out);
		(void) fprintf(stderr,
			"%s:  unable to parse fronts file %s.\n",
			argv[0], argv[5]);
		return BadFile;
		break;
	}

/* No error; exit quietly. */
	return Okay;
}
