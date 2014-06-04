#!/usr/bin/perl
use strict;
use warnings;

use Test::More qw(no_plan);

#####
# Can access module?
use_ok( 'JSON::Generator' );

# Tests for string to JSON
is( JSON::Generator::string('10'), '"10"', 'Valid: 10' ); 
is( JSON::Generator::string('hello'), '"hello"', 'Valid: hello' ); 
is( JSON::Generator::string('-1'), '"-1"', 'Valid: -1' ); 
is( JSON::Generator::string('!@#$%^&*()-_{}[]|\:;<>,?/~`'), '"!@#$%^&*()-_{}[]|\:;<>,?/~`"', 'Valid: !@#$%^&*()-_{}[]|\:;<>,?/~`' ); 


# Tests for number to JSON
is( JSON::Generator::number( -1 ), -1, 'Valid: -1' );
is( JSON::Generator::number( 10 ), 10, 'Valid: 10' );
is( JSON::Generator::number( 1.23 ), 1.23, 'Valid: 1.23' );
is( JSON::Generator::number( 'hello' ), undef, 'Invalid: hello' );


# Tests for array to JSON 
my $test_array_ref = [ 1, 2, 3 ];
is( JSON::Generator::array( $test_array_ref ), '[1,2,3]', 'Valid: Array with numbers' );

push( @$test_array_ref, 'string1' );
push( @$test_array_ref, 'string2' );
is( JSON::Generator::array( $test_array_ref ), '[1,2,3,"string1","string2"]', 'Valid: Array with numbers and strings' );

my $test_subarray_ref = [ 1, 2, 3 ];
push( @$test_array_ref, $test_subarray_ref );
is( JSON::Generator::array( $test_array_ref ), '[1,2,3,"string1","string2",[1,2,3]]', "Valid: Array with numbers, strings, and another array" );

my $test_subhash_ref = { 'key1' => 'value1', 'key2' => 2 };
push( @$test_array_ref, $test_subhash_ref );
is( JSON::Generator::array( $test_array_ref ), '[1,2,3,"string1","string2",[1,2,3],{"key1":"value1","key2":2}]', "Valid: Array with numbers, array, and hash" );

is( JSON::Generator::array( 'string' ), undef, 'Invalid: String' );
is( JSON::Generator::array( 10 ), undef, 'Invalid: Number' );
is( JSON::Generator::array( $test_subhash_ref ), undef, 'Invalid: Hash' );


# Tests for hash to JSON
my $test_hash_ref = { 'keyString' => 'value1' };
is( JSON::Generator::hash( $test_hash_ref ), '{"keyString":"value1"}', 'Valid: Hash with string' );

$test_hash_ref->{'keyNumber'} = 2;
is( JSON::Generator::hash( $test_hash_ref ), '{"keyNumber":2,"keyString":"value1"}', 'Valid: Hash with string and number' );

$test_hash_ref->{'keyArray'} = $test_subarray_ref;
is( JSON::Generator::hash( $test_hash_ref ), '{"keyArray":[1,2,3],"keyNumber":2,"keyString":"value1"}', 'Valid: Hash with string, number, and hash' );

$test_hash_ref->{'keyHash'} = $test_subhash_ref;
is( JSON::Generator::hash( $test_hash_ref ), '{"keyArray":[1,2,3],"keyHash":{"key1":"value1","key2":2},"keyNumber":2,"keyString":"value1"}', 'Valid: Hash with strings, numbers, array, and hash' );

is( JSON::Generator::hash( 'string' ), undef, 'Invalid: String' );
is( JSON::Generator::hash( 10 ), undef, 'Invalid: Number' );
is( JSON::Generator::hash( $test_subarray_ref ), undef, 'Invalid: Array' );
