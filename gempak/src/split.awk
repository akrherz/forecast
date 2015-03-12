{
	name = $1
	lat = 51 - $2
	lon = 131 + $3
	cmd = "head -" lat " " grid " | tail -1 | cut -f" lon
	system (cmd)
}
