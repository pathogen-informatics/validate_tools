package ValidateFasta::FastaFile;
use Moose;
use ValidateFasta::Types;
=head1 NAME

ValidateFasta::File - check that fasta file content is valid for Sanger pathogens pipelines

=head1 SYNOPSIS



=cut

has 'fastafile'=>(is =>'ro', required=>1, isa=>'ValidateFasta::Fastaseq::File');


__PACKAGE__->meta->make_immutable;

no Moose;

1;
