# $Id$

my $NUM;
BEGIN { $NUM = 4; }
use strict;
use Test::More tests => $NUM;

my $windoze = 1;

SKIP: {
	unless ( $^O =~ /win32|cygwin/i) {
		# has X11 ? 
		eval "use Prima;";
		if ( $@) {
			skip "This module won't run without X11", $NUM;
			$windoze = 0;
		}
	}

	eval "use Win32::GUIRobot qw(:all);";
	ok(not($@), 'use Win32::GUIRobot'); 
	warn $@ if $@;

	my $grab = ScreenGrab( 0, 0, 100, 100);
	ok( $grab, 'grab screen');

	my $halfgrab = $grab-> extract( 25, 100 - 25, 25, 25);
	ok( $halfgrab, 'extract from image');

	my ( $x, $y) = FindImage( $grab, $halfgrab);
	ok((defined($x) and defined($y) and ($x == 25) and ($y == 25)), 'find image');
}

