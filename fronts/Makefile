CC = gcc

all: front_convert distance city.list

citycvt: citycvt.c earth.h
	${CC} ${CFLAGS} ${DEFINES} citycvt.c -o citycvt -lm

city.list: citycvt
	grep "US  K" /usr/home/wxp/etc/city_sfc | citycvt | sort | uniq > city.list

front_convert: convert.o extract.o parse.o
	${CC} ${CFLAGS} front_convert.o extract.o parse.o -o front_convert -lm

convert.o: convert.c convert.h
	${CC} ${CFLAGS} ${DEFINES} -c convert.c

extract.o: extract.c
	${CC} ${CFLAGS} ${DEFINES} -c extract.c

parse.o: parse.c convert.h earth.h
	${CC} ${CFLAGS} ${DEFINES} -c parse.c

distance.o: distance.c distance.h
	${CC} ${CFLAGS} ${DEFINES} -c distance.c

distance: distance.o nearLine.o pythagoras.o range.o
	${CC} ${CFLAGS} distance.o nearLine.o pythagoras.o range.o -o distance -lm

nearLine.o: nearLine.c nearLine.h pythagoras.h
	${CC} ${CFLAGS} ${DEFINES} -c nearLine.c

pythagoras.o: pythagoras.c pythagoras.h
	${CC} ${CFLAGS} ${DEFINES} -c pythagoras.c

range.o: range.c distance.h pythagoras.h
	${CC} ${CFLAGS} ${DEFINES} -c range.c

tl: tl.o nearLine.o pythagoras.o
	${CC} ${CFLAGS} tl.o nearLine.o pythagoras.o -o tl -lm

clean:
	rm -f *.o core citycvt convert *.COLD *.OCFNT *.STNRY *.WARM

test: convert
	convert /data/`date -u +%y%m%d`01.frt COLD
	convert /data/`date -u +%y%m%d`01.frt OCFNT
	convert /data/`date -u +%y%m%d`01.frt STNRY
	convert /data/`date -u +%y%m%d`01.frt WARM
