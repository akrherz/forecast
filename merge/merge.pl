#!/usr/bin/perl

# To do the job, we need to know what day today and yesterday are.
die "two days needed\n" unless (@ARGV == 2);
$today = @ARGV[0];
$yesterday = @ARGV[1];
$lyest = '20' . $yesterday; # Use four-digit year.  Fix before 2100.

# magic "missing data" value
$missing = -9999;

# Read the list of three-letter station identifiers.
open(STATIONS, "<grid.list") or die "unable to read grid.list: $!\n";
while($line = <STATIONS>) {
	$line =~ s/\W//g;
	push @stn, $line;
}
close(STATIONS);

##
# Read the data

# clouds
foreach $hour ('06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20') {
	$name = "raw/cloud." . $yesterday . $hour;
	$cloud{$hour} = { readone($name) };
}

# advection
foreach $hour ('16', '17', '18', '19', '20') {
	$name = "raw/af" . $yesterday . $hour . ".list";
	$adv{$hour} = { readone($name) };
}
foreach $hour ('10', '11', '12', '13', '14') {
	$name = "raw/af" . $yesterday . $hour . ".list";
	$adv{$hour} = { readone($name) };
}
#foreach $hour ('10', '11', '12', '13', '14') {
#	$name = "raw/af" . $today . $hour . ".list";
#	$adv{$hour} = { readone($name) };
#}

# fronts
foreach $hour ('01', '04', '07', '10', '13', '16', '19', '22') {
	$name = "raw/" . $lyest . $hour . ".WARM";
	$warm{$hour} = { readone($name) };
	$name = "raw/" . $lyest . $hour . ".COLD";
	$cold{$hour} = { readone($name) };
	$name = "raw/" . $lyest . $hour . ".OCFNT";
	$ocfnt{$hour} = { readone($name) };
	$name = "raw/" . $lyest . $hour . ".STNRY";
	$stnry{$hour} = { readone($name) };
}

# relative humidity (850mb?)
$name = "raw/hf" . $yesterday . "_12.list";
$hf{one} = { readone($name) };
$name = "raw/hf" . $today . "_00.list";
$hf{two} = { readone($name) };
$name = "raw/hf" . $today . "_12.list";
$hf{three} = { readone($name) };

# 850mb temperatures
$name = "raw/tf" . $yesterday . "_12.list";
$tf{one} = { readone($name) };
$name = "raw/tf" . $today . "_00.list";
$tf{two} = { readone($name) };
$name = "raw/tf" . $today . "_12.list";
$tf{three} = { readone($name) };

# precipitation
$name = "raw/precip" . $yesterday . "_13.list";
$precip{one} = { readone($name) };
$name = "raw/precip" . $today . "_00.list";
$precip{two} = { readone($name) };

# assorted surface data
$name = "raw/tmpf_" . $yesterday . "_11.list";
$tmpf{'11'} = { readone($name) };
$name = "raw/tmpf_" . $yesterday . "_12.list";
$tmpf{'12'} = { readone($name) };
$name = "raw/tmpf_" . $yesterday . "_13.list";
$tmpf{'13'} = { readone($name) };
$name = "raw/tmpf_" . $yesterday . "_14.list";
$tmpf{'14'} = { readone($name) };
$name = "raw/tmpf_" . $yesterday . "_17.list";
$tmpf{'17'} = { readone($name) };
$name = "raw/tmpf_" . $yesterday . "_18.list";
$tmpf{'18'} = { readone($name) };
$name = "raw/tmpf_" . $yesterday . "_19.list";
$tmpf{'19'} = { readone($name) };
$name = "raw/tmpf_" . $yesterday . "_20.list";
$tmpf{'20'} = { readone($name) };
$name = "raw/drct_" . $yesterday . "_17.list";
$drct{'17'} = { readone($name) };
$name = "raw/sknt_" . $yesterday . "_17.list";
$sknt{'17'} = { readone($name) };
$name = "raw/drct_" . $yesterday . "_18.list";
$drct{'18'} = { readone($name) };
$name = "raw/sknt_" . $yesterday . "_18.list";
$sknt{'18'} = { readone($name) };
$name = "raw/drct_" . $yesterday . "_19.list";
$drct{'19'} = { readone($name) };
$name = "raw/sknt_" . $yesterday . "_19.list";
$sknt{'19'} = { readone($name) };
$name = "raw/drct_" . $yesterday . "_20.list";
$drct{'20'} = { readone($name) };
$name = "raw/sknt_" . $yesterday . "_20.list";
$sknt{'20'} = { readone($name) };

##
# report answers
foreach $place (@stn) {
	# station identifier
	print "STATION=K$place\n";

	# 11Z clouds
	my $sum = 0;
	foreach $time ('06', '07', '08', '09', '10', '11') {
		if ($cloud{$time}{$place} >= 0.75) {
			$sum += 1;
		}
	}
	if ($sum > 2) {
		print "CLOUD_11=1\n";
	} else {
		print "CLOUD_11=2\n";
	}

	# 12Z clouds
	my $sum = 0;
	foreach $time ('07', '08', '09', '10', '11', '12') {
		if ($cloud{$time}{$place} >= 0.75) {
			$sum += 1;
		}
	}
	if ($sum > 2) {
		print "CLOUD_12=1\n";
	} else {
		print "CLOUD_12=2\n";
	}

	# 13Z clouds
	my $sum = 0;
	foreach $time ('08', '09', '10', '11', '12', '13') {
		if ($cloud{$time}{$place} >= 0.75) {
			$sum += 1;
		}
	}
	if ($sum > 2) {
		print "CLOUD_13=1\n";
	} else {
		print "CLOUD_13=2\n";
	}

	# 14Z clouds
	my $sum = 0;
	foreach $time ('09', '10', '11', '12', '13', '14') {
		if ($cloud{$time}{$place} >= 0.75) {
			$sum += 1;
		}
	}
	if ($sum > 2) {
		print "CLOUD_14=1\n";
	} else {
		print "CLOUD_14=2\n";
	}

	# 17Z clouds
	$sum = 0;
	foreach $time ('14', '15', '16', '17') {
		if ($cloud{$time}{$place} >= 0.75) {
			$sum += 1;
		}
	}
	if ($sum > 1) {
		print "CLOUD_17=1\n";
	} else {
		print "CLOUD_17=2\n";
	}

	# 18Z clouds
	$sum = 0;
	foreach $time ('15', '16', '17', '18') {
		if ($cloud{$time}{$place} >= 0.75) {
			$sum += 1;
		}
	}
	if ($sum > 1) {
		print "CLOUD_18=1\n";
	} else {
		print "CLOUD_18=2\n";
	}

	# 19Z clouds
	$sum = 0;
	foreach $time ('16', '17', '18', '19') {
		if ($cloud{$time}{$place} >= 0.75) {
			$sum += 1;
		}
	}
	if ($sum > 1) {
		print "CLOUD_19=1\n";
	} else {
		print "CLOUD_19=2\n";
	}

	# 20Z clouds
	$sum = 0;
	foreach $time ('17', '18', '19', '20') {
		if ($cloud{$time}{$place} >= 0.75) {
			$sum += 1;
		}
	}
	if ($sum > 1) {
		print "CLOUD_20=1\n";
	} else {
		print "CLOUD_20=2\n";
	}

	# advection
	foreach $hour ('11', '12', '13', '14', '17', '18', '19', '20') {
		my $prev = $hour - 1;
		$sum = $adv{$prev}{$place} + $adv{$hour}{$place};
		print "ADVECT_$hour=";
		if ($sum > 1) {
			print "1\n";
		} elsif ($sum < -1) {
			print "2\n";
		} else {
			print "3\n";
		}
	}

#	# 12Z advection
#	$sum = $adv{11}{$place} + $adv{12}{$place};
#	print "ADVECT_12=";
#	if ($sum > 1) {
#		print "1\n";
#	} elsif ($sum < -1) {
#		print "2\n";
#	} else {
#		print "3\n";
#	}
#
#	# 18Z advection
#	$sum = $adv{17}{$place} + $adv{18}{$place};
#	print "ADVECT_18=";
#	if ($sum > 1) {
#		print "1\n";
#	} elsif ($sum < -1) {
#		print "2\n";
#	} else {
#		print "3\n";
#	}

	# 12Z fronts
	$sum = "";
	if ( ($warm{'07'}{$place} eq "close") or 
		($warm{'10'}{$place} eq "close") or
		($warm{'13'}{$place} eq "close") ) {
		$sum = $sum . "1|";
	}
	if ( ($cold{'07'}{$place} eq "close") or 
		($cold{'10'}{$place} eq "close") or
		($cold{'13'}{$place} eq "close") ) {
		$sum = $sum . "2|";
	}
	if ( ($ocfnt{'07'}{$place} eq "close") or 
		($ocfnt{'10'}{$place} eq "close") or
		($ocfnt{'13'}{$place} eq "close") ) {
		$sum = $sum . "3|";
	}
	if ( ($stnry{'07'}{$place} eq "close") or 
		($stnry{'10'}{$place} eq "close") or
		($stnry{'13'}{$place} eq "close") ) {
		$sum = $sum . "4|";
	}
	print "FRONT_12=";
	if ($sum =~ /\|/) {
		$sum =~ s/\|$//;
		print "$sum\n";
	} else {
		print "5\n";
	}

	# 18Z fronts
	$sum = "";
	if ( ($warm{'13'}{$place} eq "close") or 
		($warm{'16'}{$place} eq "close") or
		($warm{'19'}{$place} eq "close") ) {
		$sum = $sum . "1|";
	}
	if ( ($cold{'13'}{$place} eq "close") or 
		($cold{'16'}{$place} eq "close") or
		($cold{'19'}{$place} eq "close") ) {
		$sum = $sum . "2|";
	}
	if ( ($ocfnt{'13'}{$place} eq "close") or 
		($ocfnt{'16'}{$place} eq "close") or
		($ocfnt{'19'}{$place} eq "close") ) {
		$sum = $sum . "3|";
	}
	if ( ($stnry{'13'}{$place} eq "close") or 
		($stnry{'16'}{$place} eq "close") or
		($stnry{'19'}{$place} eq "close") ) {
		$sum = $sum . "4|";
	}
	print "FRONT_18=";
	if ($sum =~ /\|/) {
		$sum =~ s/\|$//;
		print "$sum\n";
	} else {
		print "5\n";
	}

	## precipitation influences
	# moisture supply
	$sum = "";
	if ( ($hf{one}{$place} >= 80) or
		($hf{two}{$place} >= 80) or
		($hf{three}{$place} >= 80) ) {
		$sum = $sum . "1,";
	}
	# frontal passage
	$tmp = "no";
	foreach $hour ('01', '04', '07', '10', '13', '16', '19', '22') {
		if ( ($warm{$hour}{$place} eq "close") or
			($cold{$hour}{$place} eq "close") or
			($ocfnt{$hour}{$place} eq "close") or
			($stnry{$hour}{$place} eq "close") ) {
			$tmp = "yes";
		}
	}
	if ($tmp eq "yes") {
		$sum = $sum . "2,";
	}
	# unstable atmosphere
	if ( ($tf{one}{$place} >= 25) or
		($tf{two}{$place} >= 25) or
		($tf{three}{$place} >= 25) ) {
		$sum = $sum . "3,";
	}
	print "FAVOR_PRECIP=";
	if ($sum == "") {
		print "0\n";
	} else {
		$sum =~ s/,$//;
		print "$sum\n";
	}

	# surface temperature
	foreach $hour ('11', '12', '13', '14', '17', '18', '19', '20') {
		my $low, $high;
		if ( ($tmpf{$hour}{$place} == $missing) or
			($tmpf{$hour}{$place} eq '') ) {
			$low = -50;
			$high = 100;
		} else {
			$low = int ($tmpf{$hour}{$place} + .5) - 5;
			$high = $low + 10;
		}
		print "TEMP_$hour=$low:$high\n";
	}

	# wind
	foreach $hour ('17', '18', '19', '20') {
		# direction
		$tmp = $drct{$hour}{$place};
		print "WDIR_$hour=";
		if ( ($tmp == $missing) or ($sknt{$hour}{$place} < 1) ) {
			print "N|NE|E|SE|S|SW|W|NW\n";
		} elsif ($tmp <= 22.5) {
			print "NW|N|NE\n";
		} elsif ($tmp <= 67.5) {
			print "N|NE|E\n";
		} elsif ($tmp <= 112.5) {
			print "NE|E|SE\n";
		} elsif ($tmp <= 157.5) {
			print "E|SE|S\n";
		} elsif ($tmp <= 202.5) {
			print "SE|S|SW\n";
		} elsif ($tmp <= 247.5) {
			print "S|SW|W\n";
		} elsif ($tmp <= 292.5) {
			print "SW|W|NW\n";
		} elsif ($tmp <= 337.5) {
			print "W|NW|N\n";
		} else {
			print "NW|N|NE\n";
		}

		# speed
		{
			my $low, $high;
                        if ($sknt{$hour}{$place} < 0){
                           $sknt{$hour}{$place} = 0;
                        }
			$low = $sknt{$hour}{$place} - 5;
			$high = $low + 10;
			print "WSPD_$hour=$low:$high\n";
		}
	}

	# precipitation
	if ( ($precip{one}{$place} > 0) or
		($precip{two}{$place} > 0) ) {
		print "PRECIP=1\n";
	} else {
		print "PRECIP=2\n";
	}

}

sub readone {
	my ($name) = @_;
	my %hash;

	open(IN, "<$name") or die "unable to read $name: $!\n";
	while($line = <IN>) {
		$line =~ /(\S+)\s+(\S+)\W+/;
		$hash{$1} = $2;
	}
	close(IN);
	return %hash;
}
