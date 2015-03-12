#include <stdio.h>
#include <math.h>
#include "earth.h"

#define StrLen	256
#define ShortStr	32
#define NameStart	21
#define LatStart	31

/*
 * citycvt:
 *
 *	This program converts a city database from a Unidata form into the
 * form that this package can deal with. 
 *	Front data doesn't allow negative longitude, and the data we're
 * in has negative longitude (as defined by city_sfc), so that sign is
 * switched in this program.
 *
 */
main() {
char	line[StrLen],
	name[ShortStr];
float	lat,
	lon;

	while (!feof(stdin)) {
		gets(line);
		(void) sscanf(line + NameStart, "%s %*s %f %f",
			name, &lat, &lon);
		(void) printf("%s\t%.3f\t%.3f\n",
			name,
			R * DtoR(lat),
			R * cos(DtoR(lat)) * DtoR(-lon)
		);
	}
}
