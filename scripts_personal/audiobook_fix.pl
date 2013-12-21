#!/usr/bin/perl 
#
#

$ffmpeg_command='/opt/ffmpeg-0.11.2/bin/ffmpeg';
$bandwidth="64k"; 
$channels=1; 
$freq=44100;

use File::Glob ':glob';
# Config
$test = 0;

$dirname = $ARGV[0];

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

		 # print "$file \n";

		if( $file =~ /mp3$/ || $file =~ /MP3$/ || $file =~ /m4b$/ || $file =~ /m4a$/ || $file =~ /wma$/ ){
			print ">>$ffmpeg_command -i \"$file\" -ab $bandwidth -ac $channels -ar $freq -vn -y \"$file2\"\n";
			system("$ffmpeg_command -i \"$file\" -ab $bandwidth -ac $channels -ar $freq -vn -y \"$file2\" &> /tmp/audiobook_shrink.out");
			system("id3v2 --TCON \"audiobook\" \"$file2\"");
			sleep(1);
		}
	}
}

my @files = glob("$dirname/*");
foreach my $file (@files) {
	&the_operation($file);
}

print "done...\n\n";

