/* return values */
#define Okay	0
#define	BadArg	1
#define	BadFile	2

/* How close is equal with doubles? */
#define Delta	0.01

/* range values */
#define Close	0
#define Far	1
#define Error	2

/* function prototype */
int	range(double lat, double lon, double d, FILE *in);
