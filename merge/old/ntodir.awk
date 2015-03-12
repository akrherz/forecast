{
	if ($1 <= 22.5) {
		print "NW|N|NE";
	} else if ($1 <= 67.5) {
		print "N|NE|E";
	} else if ($1 <= 112.5) {
		print "NE|E|SE";
	} else if ($1 <= 157.5) {
		print "E|SE|S";
	} else if ($1 <= 202.5) {
		print "SE|S|SW";
	} else if ($1 <= 247.5) {
		print "S|SW|W";
	} else if ($1 <= 292.5) {
		print "SW|W|NW";
	} else if ($1 <= 337.5) {
		print "W|NW|N";
	} else {
		print "NW|N|NE";
	}
}
