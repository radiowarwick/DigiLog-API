#!/usr/bin/perl
use strict;
use warnings;

use FindBin;
use lib("$FindBin::Bin/../lib");
use Test::More;

# Tests around the tests...
BEGIN{use_ok("DigiLogTests::Config");}
BEGIN{use_ok("DigiLogTests::Retrieve");}

# Some standard variables used later
our $location = "/tmp/DigiplayAPI-tests";
our $length = 300;
our $config; # Needed by objects later - will be created as appropriate

my $test_count = 2;

$test_count += DigiLogTests::Config::run_tests();
undef($config);
$test_count += DigiLogTests::Retrieve::run_tests();
undef($config);

done_testing($test_count);

exit;