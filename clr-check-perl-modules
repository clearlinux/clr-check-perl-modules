#!/usr/bin/perl
use strict;
use warnings;

use Config;

# Get the current Perl version string
my $version = $Config{version};

print "Perl version $version -- checking for outdated module paths\n";

# Get the list of currently-supported version-specific dirs
my @current_version_dirs = grep { m#/\Q${version}\E(?:/|$)# } @INC;

# Build patterns from this version's dirs
my %patterns;
my %supported;
foreach my $dir (@current_version_dirs) {
	my $pattern = $dir;
	my $basedir = $dir;
	$pattern =~ s/\Q${version}\E/([0-9\.]+)/;
	$basedir =~ s/\Q${version}\E.*$//;
	$patterns{$basedir}{$pattern}++;

	# Make a list of the other supported version directories that do *not*
	# match the current version
	foreach my $dir (@INC) {
		if ($dir =~ m/$pattern/ && $1 ne $version) {
			$supported{$dir}++;
		}
	}
}

# Scan for version-specific dirs in the same places and identify the
# versions they actually use
my %results;
# Scan longest stems first
my @basedirs = sort { length($b) <=> length($a) } keys %patterns;
foreach my $basedir (@basedirs) {
	foreach my $pattern (sort { length($b) <=> length($a) }
		keys %{$patterns{$basedir}}) {
		open(my $fh, "-|", "find ${basedir} -type d")
			or die "find: $!";
		while (my $result = <$fh>) {
			chomp $result;
			if ($result =~ m/($pattern)/ && $2 ne $version) {
				if ($supported{$1}) {
					$results{supported}{$2}{$1}++;
				}
				else {
					$results{obsolete}{$2}{$1}++;
				}
			}
		}
		close($fh)
			or die "find: $!\n";
	}
}

# Report out the results
if (%results) {
	if ($results{supported}) {
		print "\n";
		print "NOTE: The following paths may contain modules that were installed\n";
		print "      under a previous version of Perl, but should still be\n";
		print "      supported under the current version (${version}).\n";
		foreach my $version (sort { $b cmp $a } keys %{$results{supported}}) {
			foreach my $dir (sort keys %{$results{supported}{$version}}) {
				print "\	$dir\n";
			}
		}
	}
	if ($results{obsolete}) {
		print "\n";
		print "WARN: The following paths may contain modules that were installed\n";
		print "      under a previous version of Perl AND ARE NOT\n";
		print "      supported under the current version (${version})!\n";
		foreach my $version (sort { $b cmp $a } keys %{$results{obsolete}}) {
			foreach my $dir (sort keys %{$results{obsolete}{$version}}) {
				print "\	$dir\n";
			}
		}
	}

}
else {
	print "No obsolete module paths found\n";
}
