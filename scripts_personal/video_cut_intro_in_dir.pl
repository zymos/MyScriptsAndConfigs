#!/usr/bin/perl -w
#
#
#
# Get video length
# 	$video_length=`mplayer -vo null -ao null -frames 0 -identify "$@" 2>/dev/null |  grep "^ID_LENGTH" | sed -e 's/ID_LENGTH=//g'`
#
# 	 cabac=1 ref=3 deblock=1:0:0 analyse=0x1:0x111 me=hex subme=7 psy=1 psy_rd=1.00:0.00 mixed_ref=0 me_range=16 chroma_me=1 trellis=1 8x8dct=0 cqm=0 deadzone=21,11 fast_pskip=1 chroma_qp_offset=-2 threads=3 sliced_threads=0 nr=0 decimate=1 interlaced=0 bluray_compat=0 constrained_intra=0 bframes=3 b_pyramid=0 b_adapt=1 b_bias=0 direct=1 weightb=0 open_gop=1 weightp=2 keyint=250 keyint_min=23 scenecut=40 intra_refresh=0 rc_lookahead=40 rc=crf mbtree=1 crf=23.0 qcomp=0.60 qpmin=0 qpmax=69 qpstep=4 ip_ratio=1.25 aq=1:1.00
#
# for f in *.ogm; do avconv -i "$f" -ss 110 -t 1246 ${f%.ogm}.mp4; done

# $FFMPEG_CMD='/opt/ffmpeg-0.11.2/bin/ffmpeg';
$niceness="nice -n 19 ionice -c2 -n7";

# $get_var='source /etc/profile.d/env_vars.sh && echo $FFMPEG_CMD';
# $FFMPEG_CMD=`$get_var`;
$FFMPEG_CMD="avconv";

use File::Glob ':glob';
# Config

$start_pos=$ARGV[0];
$stop_pos= $ARGV[1];
$dirname = $ARGV[2];



sub print_usage() {
	 print "Usage: \n  video_cut_intro_in_dir.pl [START_POSITION] [STOP_POSITION] [DIRECTORY]\n\n";
  print "  START_POSITION must be an integer in seconds,\n    or use \"BEGINING\"to have the intro uncut\n";
    print "  STOP_POSITION must be an integer in seconds,\n    or use \"END\"to have the ending uncut\n\n";
	print "Examples:\n";
	print "  video_cut_intro_in_dir.pl 10 1000 /home/bob/videos\n";
	print "  video_cut_intro_in_dir.pl BEGINING 1000 /home/bob/videos\n";
	print "  video_cut_intro_in_dir.pl 10 END /home/bob/videos\n\n";
  exit;
}

if( $start_pos eq "" ){
	&print_usage;
	exit;
}
$cut_begin_opt='';
$cut_end_opt='';
if( $start_pos eq "BEGINNING" ){
	$cut_begin_opt=''; # no cut
	$start_pos = 0;
}elsif( $start_pos =~ /\d/ ){
	$cut_begin_opt="-ss $start_pos";
}else{
	 print "Input error: START_POSITION != integer or BEGINNING\n\n";
	&print_usage;
	exit 1;

}
if( $stop_pos eq "END" ){
	$cut_end_opt=''; # no cut
}elsif( $stop_pos =~ /\d/ ){
	$duration = $stop_pos - $start_pos;
	$cut_end_opt="-t $duration";
}else{
	print "Input error: STOP_POSITION != integer or END\n\n";
	&print_usage;
	exit 1;
}
if( $stop_pos <= $start_pos ){
	print "Input error: STOP_POSITION can not be less than or equal to START_POSITION \n\n";
	&print_usage;
	exit 1;
}
if( ! -d  $dirname || $dirname eq ""){
	print "Input error: DIRECTORY entered is not valid\n\n";
	&print_usage;
	exit 1;
}




print "starting processes....\n";

sub the_operation {
	my $file = $_[0];
	if( not( $file eq '.' || $file eq '..') && -f $file  ) {
		$file =~ s/\!/\\\!/;
		$file2 = $file;
		$file_name = $file;
		$file2 =~ s/$/.no.intro.mp4/;

		$file_name =~ s/^.*\///;
#		$video_length=`mplayer -vo null -ao null -frames 0 -identify "$file" 2>/dev/null |  grep "^ID_LENGTH" | sed -e 's/ID_LENGTH=//g'`;
#		print " $video_length\n";
		print "Processing...\n   $file_name\n";
		sleep 1;
		print "   Stage 1 started... ";
		$cmd = "$niceness $FFMPEG_CMD -i \"$file\" $cut_begin_opt $cut_end_opt -vcodec mpeg2video -pix_fmt yuv420p -me_method epzs -threads 4 -r 29.97 -g 45 -bf 2 -trellis 2 -cmp 2 -subcmp 2 -b 2500k -bt 300k -acodec mp2 -ac 2 -ab 192k -ar 44100 -async 1 -y -f vob -y \"/tmp/no.intro.video.tmp.mpg\" 2>&1";
		$cmd_out .= `$cmd`;
		print "Complete, ";
		sleep 1;
		print "Stage 2 started... ";
		$cmd = "$niceness $FFMPEG_CMD -i \"/tmp/no.intro.video.tmp.mpg\" -vcodec libx264 -crf 22 -threads 0 -acodec libfaac -ac 2 -ar 44100 -ab 96k -y \"$file2\"  2>&1";
		$cmd_out .= `$cmd`;

		print "Complete.\n";
	}
}

my @files = glob("$dirname/*");
foreach my $file (@files) {
	&the_operation($file);
}

mkdir "$dirname/processed";
system("mv $dirname/*.no.intro.* $dirname/processed/");

print "done...\n\n";

