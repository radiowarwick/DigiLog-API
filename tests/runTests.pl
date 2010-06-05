#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 2;
use File::Path qw(remove_tree);
use FindBin;
use lib("$FindBin::Bin/../lib");

use DigiLog::Config;
use DigiLog::Retrieve;

my $LOCATION = "/tmp/DigiLog-API-tests";
my $LENGTH = 300;


our $config = DigiLog::Config->new($LOCATION, $LENGTH);

run_config_tests();

run_retrieve_tests();

exit;

sub run_config_tests {
    # Test 1 - confirm location is set
    cmp_ok($main::config->{location}, 'eq', $LOCATION, "Config location check");
    
    # Test 2 - confir length is set
    cmp_ok($main::config->{length}, '==', $LENGTH, "Config length check");
}

sub run_retrieve_tests {
    my @files = ('1234329900.0','1234567890.0','1247432700.0');
    
    set_up_test_env(\@files);
    
    clean_up_test_env();
}

sub set_up_test_env {
    my ($files) = @_;
    # Set up a folder to use for test files - assume we can use /tmp
    mkdir($LOCATION);
    
    FILE:
    for my $file (@{$files}) {
        `touch $LOCATION/$file`;
    }
}

sub clean_up_test_env {
    # Remove the test directory
    File::Path::remove_tree($LOCATION);
}