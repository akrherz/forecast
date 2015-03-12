#!/bin/csh
if ( ${1} <= 22 ) then
	echo NW|N|NE
else if ( ${1} <= 67 ) then
	echo N|NE|E
else if ( ${1} <= 112 ) then
	echo NE|E|SE
else if ( ${1} <= 157 ) then
	echo E|SE|S
else if ( ${1} <= 202 ) then
	echo SE|S|SW
else if ( ${1} <= 247 ) then
	echo S|SW|W
else if ( ${1} <= 292 ) then
	echo SW|W|NW
else if ( ${1} <= 337 ) then
	echo W|NW|N
else
	echo NW|N|NE
endif
