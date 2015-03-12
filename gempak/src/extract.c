#include <stdio.h>
#include <string.h>
#define LineLen	128
#define True	(0 == 0)
#define False	(!True)

/*
 * extract:
 *
 *	This program converts GDLIST output into something that standard
 * text manipulation tools can use:  each row is a tab-separated line,
 * terminated with a newline character.
 *
 */
main(int argc, char **argv) {
char	line[LineLen],
	target[LineLen];
float	f;
int	cmin,
	cmax,
	col,
	done = False,
	rmin,
	rmax,
	row;
FILE	*in = stdin;
#ifdef DEBUG
char	word[LineLen];
int	i,
	number;
#endif

/* How big is the grid? */
	while(!done) {
		fgets(line, LineLen, in);
	/* Throw away useless lines */
		if(strstr(line, "COLUMNS") != NULL) {
		/* and read the row/column counts. */
			(void) sscanf(line, "%*s %d %d %*s %d %d",
				&cmin, &cmax, &rmin, &rmax);
			done = True;
		}
	}

#ifdef DEBUG
	(void) fprintf(stderr, "rows:  %d < %d; columns:  %d < %d\n",
		rmin, rmax, cmin, cmax);
#endif

/* Throw away more useless lines; the columns will be listed in */
/* ascending order, so we look for the largest column number. */
	(void) sprintf(target, " %d", cmax);
	fgets(line, LineLen, in);
	while(strstr(line, target) == NULL)
		fgets(line, LineLen, in);

/* Generate output */
	for(row = rmax; row >= rmin; row--) {
#ifdef DEBUG
	i = fscanf(in, "%s %d", word, &number);
#else
	(void) fscanf(in, "%*s %*d");
#endif
		(void) fscanf(in, "%e", &f);
		(void) printf("%.2f", f);
		for(col = cmin; col < cmax; col++) {
			(void) fscanf(in, "%e", &f);
			(void) printf("\t%.2f", f);
		}
		(void) putchar('\n');
	}
}
