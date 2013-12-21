#!/usr/bin/perl 
#


# http://search.cpan.org/~gbrown/X11-WMCtrl-0.01/lib/X11/WMCtrl.pm
#
use X11::WMCtrl;
use strict;

my $wmctrl = X11::WMCtrl->new;
printf("window manager is %s\n", $wmctrl->get_window_manager->{name});

my @windows = $wmctrl->get_windows;

foreach (@windows) {
	print "$_ ... ";
}
