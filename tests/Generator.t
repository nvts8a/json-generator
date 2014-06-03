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

