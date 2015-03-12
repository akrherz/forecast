#!/usr/sbin/perl

$missing = -9999;	# magic number to indicate missing data
$debug = 0;		# should we print debugging messages?

while ($line = <STDIN>) {
	# a good line looks like this:
	# three alphanumerics, to name the station
	# whitespace
	# a date/time (digits, slash, digits)
	# more whitespace
	# and stuff we don't check for yet
	if ($line =~ s/^(\w\w\w)\s+\d+\/\d+\s+//) {
		$stn = $1;
		if ($debug) {
			print "Station $stn: ";
		}
		$total = 0;
		$found = 0;	# we might not find any data
		# Look for data.
		# The data is whitespace-separated floating-point numbers,
		# possibly with a leading '-', maybe starting with '.'
		# instead of a digit.
		while ($line =~ s/^\s*(-?\d*\.\d+)\s+//) {
			$num = $1;
			if ($num != $missing) {
				$found = 1;	# found something
				$total += $num;	# add it to the rest
			}
		}
		if (!$found) {
			$total = $missing;
		}
		if ($debug) {
			print "$total\n";
		}
		# The line has been processed.  $stn has the station ID,
		# and $total has the sum of all valid data entries.
		# Did we find actual data?
		if ($total != $missing) {
			# Yes.  Keep it.
			# Have we seen this station before?
			if (exists $data{$stn}) {
				# Yes.  Add this data to previous entries. 
				$data{$stn} += $total;
			} else {
				# No.  Insert this entry.
				$data{$stn} = $total;
			}
		}
	}
}

# Report
while (($stn, $total) = each %data) {
	print "$stn\t$total\n";
}
