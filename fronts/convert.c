#include <stdio.h>
#include <string.h>
#include "convert.h"

/*
 * convert:
 *
 *	This program extracts front data from an LDM front file into a form
 * more convenient for another program meant to score a forecast contest.
 *
 */
main(int argc, char **argv) {
FILE	*in,
	*out;
char	*cp,
	name[StrLen],
	*root;

	if (argc < 3) {
	/* the user forgot to specify a front file or front type */
		(void) fprintf(stderr, "%s synopsis:  %s file type\n",
			argv[0], argv[0]);
		return NoFile;
	}

	in = fopen(argv[1], "r");
	if (in == (FILE *) NULL) {
	/* unable to read specified front file */
		(void) fprintf(stderr, "%s:  unable to read %s.\n",
			argv[0], argv[1]);
		return BadFile;
	}

/* create the output file */
	root = extract(argv[1]);
	(void) sprintf(name, "%s.%s", root, argv[2]);
	out = fopen(name, "w");
	if (out == (FILE *) NULL) {
	/* unable to create output file */
		(void) fprintf(stderr, "%s:  unable to write %s.\n",
			argv[0], name);
		return BadFile;
	}

/* do the real work */
	return parse(in, out, argv[2]);
}
