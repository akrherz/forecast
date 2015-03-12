#include <stdio.h>
#include <math.h>
#include "convert.h"
#include "earth.h"

/*
 * parse:
 *
 *	This function converts front data from the raw form such data
 * is transmitted in to a form that can be used more easily.
 *
 */
int	parse(FILE *in, FILE *out, char *tag) {
char	word[StrLen];
int	lat,
	lon;

/* Make sure the files are ready. */
	if ((in == (FILE *) NULL) || (out == (FILE *) NULL))
		return BadFile;

/* Do the actual work. */
	(void) fscanf(in, "%s", word);
	while (!feof(in)) {
		if (!strcmp(word, tag)) {
		/* Now we have the right kind of front. */
		/* Throw away the strength designator, */
			(void) fscanf(in, "%s", word);
			(void) fscanf(in, "%s", word);
		/* report the start of a new front, */
			(void) fprintf(out, "front\n");
		/* and show all its points. */
			do {
			/* Latitude is the first two digits, */
			/* longitude the others (two or three); */
			/* both are expressed in degrees. */
				lon = atoi(word + 2);
				word[2] = '\0';
				lat = atoi(word);
#ifdef DEBUG
				(void) fprintf(out, "%d\t%d\n", lat, lon);
#else
				(void) fprintf(out, "%.3f\t%.3f\n",
					R * DtoR(lat),
					R * DtoR(lon) * cos(DtoR(lat))
				);
#endif
			/* Get the next word. */
				(void) fscanf(in, "%s", word);
			} while (!feof(in) && isdigit((int) word[0]));
		} else {
		/* That wasn't the right sort of front; keep looking. */
			(void) fscanf(in, "%s", word);
		}
	}

/* Report success. */
	return Okay;
}
