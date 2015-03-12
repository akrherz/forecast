#include <stdio.h>
#include <string.h>

#define StrLen	256

static
char	root[StrLen];

/*
 * extract:
 *
 *	This function extracts the root filename from a whole filename,
 * cutting off any path information and anything after the last period
 * ('.') character.
 *
 *	The output is returned in a static area, so it should be copied
 * before calling this function again.  If anything goes wrong, the
 * return value will be NULL.
 *
 */
char	*extract(char *whole) {
char	*cp;

	if (whole == NULL)	/* pointer to nothing */
		return NULL;

	if (*whole == '\0') {	/* pointer to zero-length string */
		root[0] = *whole;
		return root;
	}

/* cut off leading slashes */
	cp = strrchr(whole, '/');
	if (cp == NULL)	/* no slashes */
		(void) strcpy(root, whole);
	else {	/* at least one slash */
		(void) strcpy(root, cp + 1);
	}

/* cut off the last period */
	cp = strrchr(root, '.');
	if (cp != NULL)	/* there actually is a period to cut off */
		*cp = '\0';

/* nothing went wrong, so report success */
#ifdef DEBUG
	(void) puts(root);
#endif
	return root;
}
