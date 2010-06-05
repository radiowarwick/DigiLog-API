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

package DigiLogTests::Config;
use strict;
use Test::More;

BEGIN{ use_ok("DigiLog::Config");}

my $tests = 1;

sub run_tests {

    constructor_tests();
    
    return $tests;
}

sub constructor_tests {
    ++$tests;
    my @args = ($main::location, $main::length);
    $main::config = new_ok("DigiLog::Config", \@args);
    
    ++$tests;
    ok($main::config->{location} == $main::location, "DigiLog::Config{Location retrieval check}");
    
    ++$tests;
    ok($main::config->{length} == $main::length, "DigiLog::Config{Length retrieval check}");
    
    ++$tests;
    is(undef, DigiLog::Config->new(), "DigiLog::Config{No-arg constructor call}");
    
    return 1;
}

1;
