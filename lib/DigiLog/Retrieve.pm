#   This file is part of DigiLog-API.
#
#   DigiLog-API is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#    DigiLog-API is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with DigiLog-API.  If not, see <http://www.gnu.org/licenses/>.

package DigiLog::Retrieve;
use strict;

use IO::Dir;

use DigiLog::Config;

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}

sub available_times {
    my $dir = new IO::Dir($main::config->{location})
        or die("Couldn't open directory $main::config->{location}");
    
    my @files;
    
    FILE:
    for my $file($dir->read()) {
        if ($file =~ /^[0-9]+\.0$/) {
            push (@files, $file);
        }
    }
    
    if (!@files) {
        die("No files found in $main::config->{location}");
    }
    
    my @sorted_files = sort(@files);
    my ($first, undef) = split(/\./, $sorted_files[0]);
    my ($last, undef) = split(/\./, $sorted_files[$#sorted_files]);
    
    return($first, $last-1);
}


1;
