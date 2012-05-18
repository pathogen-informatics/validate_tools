#!/software/bin/perl
$* = 1;
$/ = "";
use strict;
use warnings;
use Getopt::Std;
my $usage = "
 Usage : $0 -h (for help)
         $0 -f <fasta file name>
Required

  f <fasta file name> : file to be validated as pipeline compliant fasta";
my %options;
    getopts('hf:', \%options);
    defined $options{h} and die $usage;
    defined $options{f} or die "No file name given\n";
my $file=$options{f};
if ($file!~/^[A-Z][a-z]+_[a-z]+/)
{die "Genus and\/or species name not found or incorrectly formatted.\n";}
if ($file!~/\.fa$/)
{die "File suffix not .fa\n";}
if ($file!~/^[A-Z][a-z]+_[a-z]+\w{0,}_v[0-9]{1,}\.{0,1}[0-9]{0,}/)
{die "Version number not found or not correctly formatted.\n";}
if ($file!~/^[A-Z][a-z]+_[a-z]+\w{0,}_v[0-9]{1,}\.{0,1}[0-9]{0,}(_\w+){0,}\.fa/)
{die "Character string after version number not valid.\n";}
if ($file=~/__/)
{die "Consecutive underscores found in file name.\n";}
if ((($file=~/v0/)&&($file!~/v0\./))||($file=~/v0.fa$/))
{die "File cannot just be version 0.\n";}
if ($file=~/_\./)
{die "Reference name cannot end with underscore.\n";}
if ($file=~/\._/)
{die "Reference version number with decimal point but nothing beyond.\n";}
open(FILE,"< $file");
while(<FILE>)
{
 my @lines=split("\n", $_);
 my %headers;
 my $seqcount=0;
 my $caught=0;
 if($lines[0] !~/\>/)
 {
     die "File doesn't start with fasta header";
 }
 foreach my $x (0..$#lines)
 {
  if($lines[$x]=~/\>/)
  {
   $caught=0;
   $seqcount++;
   my $header=$lines[$x];
   $header=~s/^\>//;
   if($header=~/[^\w]+/)
   {
       print"Header contains invalid characters, sequence $seqcount!\n";
   }
   if(!exists($headers{$header}))
   {
    $headers{$header}=0;
   }
   else   
   {
    $headers{$header}=1;
    print"Duplicate sequence ID sequence $seqcount, value: $header\n";
   }
  }
  if(($lines[$x]=~/\>/)&&($lines[$x+1]=~/^[^acgtnACGTN]/))
  {
      print "Sequence $seqcount empty or doesn't begin with valid DNA sequence\n";
  }
  
  if(($lines[$x]!~/\>/)&&($lines[$x]=~/[^acgtnACGTN]+/)&&($caught==0))
  {
      print "Sequence $seqcount contains characters other than A, C, G, T and N\n";
      $caught=1;
  }
 }
}
close(FILE);


