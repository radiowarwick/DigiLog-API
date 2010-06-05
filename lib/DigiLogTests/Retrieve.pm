#   This file is part of DigiLog-API.
#
#   DigiLog-API is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   DigiLog-API is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with DigiLog-API.  If not, see <http://www.gnu.org/licenses/>.

package DigiLogTests::Retrieve;
use strict;
use Test::More;

BEGIN{use_ok("DigiLog::Retrieve")};

use File::Path qw(remove_tree);

my $tests = 1;

sub run_tests {
    
    available_times_tests();
    
    return $tests;
}

sub available_times_tests {
    
    $main::config = {};
    $main::config->{location} = $main::location;
    
    my @files = ('1234329900.0','1234567890.0','1247432700.0');
    
    create_test_files(\@files);
    
    my ($first, $last);
    eval {
        ($first, $last) = DigiLog::Retrieve::available_times();
    };
    SKIP: {
        skip "An error occured in available_times: $@", 2 if $@;
        ++$tests;
        ok($first eq '1234329900', "DigiLog::Retrieve{available_times - first}");
        
        ++$tests;
        ok($last eq '1247432699', "DigiLog::Retrieve{available_times - last}");
    }
    
    cleanup_test_files();
    
    return 1;
}

sub create_test_files {
    my ($files) = @_;
    mkdir $main::location;
    
    for my $file (@{$files}) {
        `touch $main::location/$file`;
    }
}

sub cleanup_test_files {
    File::Path::remove_tree($main::location);
}

1;
