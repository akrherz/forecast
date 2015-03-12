#include <stdio.h>
#include <string.h>
#define StrLen	128
#define ShortStr	32
#define Target	"US  K"
#define Offset	23

/*
 * get_city:
 *
 *	This program extracts city name, latitude and longitude from WXP
 * configuration files (rounding the numbers to the nearest integer).
 *
 */
main() {
char	line[StrLen],
	name[ShortStr];
float	lat,
	lon;
FILE	*in = stdin;

	(void) fgets(line, StrLen, in);
	while(!feof(in)) {
		if(strstr(line, Target) != NULL) {
			(void) sscanf(line + Offset, "%s %*s %f %f",
				name, &lat, &lon);
			(void) fprintf(stdout, "%s\t%d\t%d\n",
				name, (int) (lat + 0.5), (int) (lon + 0.5));
		}
		(void) fgets(line, StrLen, in);
	}

	return(0);
}
