#!/usr/bin/perl
package JSON::Generator;
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

sub string {
	my ($string) = @_;
	my $json = "\"$string\"";
	
	return $json;
}

sub number {
	my ($number) = @_;
	my $json = undef;

	if( looks_like_number($number) ) {
		$json = $number;
	}

	return $json;
}


1;
