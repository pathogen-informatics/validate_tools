package ValidateFasta::Filename;
use Moose;
use ValidateFasta::Types;
=head1 NAME

ValidateFasta::Filename - check that fasta file name is valid for Sanger pathogens pipelines

=head1 SYNOPSIS



=cut

has 'filename'=>(is =>'ro', required=>1, isa=>'ValidateFasta::Filename::Name');


__PACKAGE__->meta->make_immutable;

no Moose;

1;
