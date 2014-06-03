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
is( JSON::Generator::number( { 'number' => 10 } ), undef, 'Invalid: Hash' );


