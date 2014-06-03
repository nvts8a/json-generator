#!/usr/bin/perl
package JSON::Generator;
use strict;
use warnings;

sub string {
	my ($string) = @_;
	my $json = "\"$string\"";
	
	return $json;
}


1;
