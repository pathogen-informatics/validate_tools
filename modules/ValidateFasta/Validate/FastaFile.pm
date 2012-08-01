package ValidateFasta::Validate::FastaFile;
use Moose;
use Bio::SeqIO;

=head1 NAME

ValidateFasta::Validate::FastaFile

=head1 SYNOPSIS



=cut

sub is_valid
{
 my($self, $input_string) = @_; 
 return 1 if ($self->bio_file($input_string)==1);
  return 0;
}

sub bio_file
{
 my($self, $input_string) = @_; 
 if ($self->line_check($input_string)==1)
 {
     return 0;
 }
 my $seq;
 my $header;
 my %headers;
 my $inseq = Bio::SeqIO->new(
                            -file   => "$input_string",
                            -format => 'fasta',
     );
 while( $seq = $inseq->next_seq() ) {
     $header=$seq->id;
     if($seq->description)
     {
      $header.=" ";
      $header.=$seq->description;
     }
   if($header){ 
   if(!exists($headers{$header}))
   {
    $headers{$header}=0;
   } 
      else   
   {
    $headers{$header}=1;
    return 0;
   }
   if($self->header_check($header)==1)
   {return 0;}
   }
   else
   {return 0;}
   if($self->seq_check($seq->seq)==1) 
   {return 0;}
 }
     return 1;
}

sub line_check
{
  my($self, $input_string) = @_;
  open(FILE,"$input_string");
  while(<FILE>)
  {
   if($_=~/^$/)
   {
    return 1;
   }
  }
  return 0;
}

sub header_check
{
  my($self, $input_string) = @_;
#  print"$input_string\n";
  return 1 if ($input_string =~/\|/);
  return 1 if ($input_string eq "");
  return 0;
}

sub seq_check
{
 my($self, $input_string) = @_;
 if($input_string){
# print"$input_string\n";
 return 1 if ($input_string =~/[^ACGTNacgtn]+/);
    }
    else{return 1;}
 return 0; 
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;
