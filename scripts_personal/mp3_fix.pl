#!/usr/bin/perl -w
#
#

$start_pos=95; #sec
$stop_pos=1400; #sec

use File::Glob ':glob';
# Config
$test = 0;

$dirname = $ARGV[0];
$duration = $stop_pos - $start_pos;

if($dirname eq ""){
  print "the first arg is the directory\n";
  exit;
}


print "starting processes....\n";

sub the_operation {
	my $file = $_[0];
	if( not( $file eq '.' || $file eq '..') && -f $file  ) {
		$file2 = $file;
		$file2 =~ s/$/_fixed.mp3/;
		$file2  =~ tr/A-Z/a-z/;
		$file2 =~ s/[_\!\[\]\(\)\s]/_/g;

		 print "$file \n";

		if( $file =~ /mp3$/ || $file =~ /MP3$/ ){
			print "ffmpeg -i \"$file\" -acodec copy \"$file2\"";
			system("ffmpeg -i \"$file\" -acodec copy \"$file2\"");
		}
	}
}

my @files = glob("$dirname/*");
foreach my $file (@files) {
	&the_operation($file);
}

print "done...\n\n";

