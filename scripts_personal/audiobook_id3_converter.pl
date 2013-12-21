#!/usr/bin/perl

# use modules
use MP3::Tag;
use Carp;
use File::Glob ':glob';
use File::Find;
# References
# http://www.perlmonks.org/?displaytype=print;node_id=823779;replies=1
# http://en.wikipedia.org/wiki/ID3
# http://help.mp3tag.de/main_tags.html
# TMED Media type -> Audiobook 
# ? TCON Content type
# print $#ARGV;
#
# id3v2 --TCON "audiobook" 12_the_gathering_storm_1.m4b.mp3
if ($#ARGV != 0 ) {
	print "usage: First input is the directory\n";
	exit;
}

$dirname = $ARGV[0];
# create new MP3-Tag object

sub create_id3tag {
	my $filename = $_[0]; 
	my($id3v1,$id3v2);

	if( $filename eq "." || $filename !~ /mp3$/ ){
		#not an mp3
		return;
	}
	my @filename_parts = split(/\//, $filename);
	my $filename_short = $filename_parts[-1];
	print "Reading: $filename_short\n";

    # No point in doing anything if we can't 
    # write to the file
    if(!-w $filename)
      {
        print("  Cannot write to $filename\n");
        return;
      }

    my $mp3 = MP3::Tag->new($filename);
    if(!defined $mp3)
      {
        print("  Failed to read tags from $filename\n");
        return;
      }
    $mp3->get_tags();

	if (exists $mp3->{ID3v1}) {
		print "  Detected: id3v1\n";
	}
	if (exists $mp3->{ID3v2}) {
		print "  Detected: id3v2\n";
		$id3v2 = $mp3->{ID3v2};
	}

	if (!exists $mp3->{ID3v1} && !exists $mp3->{ID3v2}) {
		print "  Creating new id3v2 tag\n";
		$id3v2 = $mp3->new_tag("ID3v2");
	}

	if (exists $mp3->{ID3v1} && !exists $mp3->{ID3v2}) {
		print "  Copying id3v1 to id3v2\n";
	}

	$frameIDs_hash = $mp3->{ID3v2}->get_frame_ids('truename');
	$TMED_detected=0;
	foreach $frame (keys %$frameIDs_hash) 
	{
		if ($frame eq "TCON") {
 			print "  Detected TCON\n";
			$TMED_detected=1;
		}
	}
	if ( $TMED_detected ) {
		$mp3->{ID3v2}->change_frame("TCON", "audiobook");
		$mp3->{ID3v2}->write_tag();
	    print "  Modifying TCON\n";
	} else {
		$mp3->{ID3v2}->add_frame("TCON", "audiobook");
		$mp3->{ID3v2}->write_tag();
	    print "  Creating TCON\n";
	}
	$media_type = $mp3->{ID3v2}->get_frame("TCON");
	print "  Content: $media_type\n";

	$mp3->close();
	return;
}

# find(\&create_id3tag, $dirname); #recusive

# print "$dirname";
my @files = glob("$dirname/*.mp3");
foreach my $file (@files) {
	&create_id3tag($file);
}

print "\nAll done\n\n";
