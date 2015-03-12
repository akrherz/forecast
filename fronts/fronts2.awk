BEGIN {
	ifs = "	"
	ofs = " "
	range = 140
	getline file < "front.data"
}

{
	cmd = "distance", $1, $2, $3, range, file
	system(cmd)
}
