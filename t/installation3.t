#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin;
use App::perlbrew;
require 'test_helpers.pl';

use Test::More;

{
    no warnings 'redefine';

    sub App::perlbrew::available_perls {
        return map { "perl-$_" }
            qw<5.8.9 5.17.7 5.16.2 5.14.3 5.12.5 5.10.1>;
    }
}

plan tests => 2;

{
    my $app = App::perlbrew->new("install", "perl-stable");
    $app->run;

    my @installed = $app->installed_perls;
    is 0+@installed, 1, "install perl-stable installs one perl";

    is $installed[0]{name}, "perl-5.16.2",
        "install perl-stable installs correct perl";
}

done_testing;
