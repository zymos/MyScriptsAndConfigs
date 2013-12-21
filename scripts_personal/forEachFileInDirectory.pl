#!/usr/bin/perl -w
#
#

use File::Glob ':glob';
# Config

$dirname = $ARGV[0];

if($dirname eq ""){
  print "the first arg is the directory\n";
  exit;
}


print "starting processes....\n";

sub the_operation {
	my $file = $_[0];
	if( not( $file eq '.' || $file eq '..') && -f $file  ) {
		# print ">";
		$file2 = $file;
		$file2 =~ s/^/family_logo-/;
		# $file2 =~ s/^AMD-//;

		# $file2 =~ s/\.jpg/-1.jpg/;

		# $file3 = $file;
		# $file3 =~ s/^/a-/;
		# $file2 =~ s/\.jpg/-2.jpg/;

		# $file2 =~ s/JPG$/jpg/;
		# $file2 =~ s/\(/-/;
		# $file2 =~ s/\)//;
		# $file2 =~

		# system("convert $file -crop 820x1080+0+0 $file2");
		# system("convert $file -crop 820x1080+820+0 $file3");
		# print "$file $file2\n";
		if( $file ne $file2 ){
			system("mv \"$file\" \"$file2\"");
			print ">$file\n>>$file2\n";
		}else{
			print "No change: $file\n";
		}

	}
}


chdir($dirname);

my @files = glob("*");
foreach my $file (@files) {
	&the_operation($file);
}

print "done...\n\n";

