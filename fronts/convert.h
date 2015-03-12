#define StrLen	256
#define	ShortStr	32
#define	Okay	0
#define	NoFile	1
#define	BadFile	2

char	*extract(char *whole);
int	parse(FILE *in, FILE *out, char *tag);
