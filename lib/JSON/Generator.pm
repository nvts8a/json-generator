#!/usr/bin/perl
package JSON::Generator;
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

# Will stringify any given item to JSON string
sub string {
	my ($string) = @_;
	my $json = "\"$string\"";
	
	return $json;
}

# Variable that looks like a number to JSON number format
sub number {
	my ($number) = @_;
	my $json = undef;

	if( looks_like_number($number) ) {
		$json = $number;
	}

	return $json;
}

# Array to JSON Array
sub array {
	my($array_ref) = @_;
	my $json = undef;

	if( ref($array_ref) eq 'ARRAY' ) {
		$json = '[';
		my @array = @$array_ref;
		my $index = 1;
		my $array_size = scalar @array;

		foreach my $array_item (@array) {

			$json .= &create_json( $array_item );

			if( $index < $array_size ) {
				$json .= ',';
			}

			$index++;
		}

		$json .= ']'
	}

	return $json;
}

# Hash to JSON Object
sub hash {
	my($hash_ref) = @_;
	my $json = undef;

	if( ref($hash_ref) eq 'HASH' ) {
		$json .= '{';
		my %hash = %$hash_ref;
		my @keys = sort { lc($a) cmp lc($b) } keys( %hash );
		my $index = 1;
		my $key_size = scalar @keys;	

		foreach my $key (@keys) {
			
			$json .= &string( $key );
			$json .= ':';
			$json .= &create_json( $hash{$key} );
			
			if( $index < $key_size ) {
				$json .= ',';
			}

			$index++;

		}

		$json .= '}';
	}

	return $json;
}

# Determines JSON datatype and returns the appropriate JSON
sub create_json {
	my ($item) = @_;
	my $json = undef;
	my $item_json = undef;

	# Since the methods return undef if invalid type I made a switch and call each one to validate
	if( $item_json = &number( $item ) ) {
		$json = $item_json;
	}
	elsif( $item_json = &array( $item ) ) {
		$json = $item_json;
	}
	elsif( $item_json = &hash( $item ) ) {
		$json = $item_json;
	}
	else {
		$json = &string( $item );
	}

	return $json;
}

1;
