#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('ValidateFasta::FastaFile');
    }
    ok{ValidateFasta::FastaFile->new(fastafile=>"t/data/corr.fa"),"validate fasta sequence object initialisation"};
    throws_ok{ValidateFasta::FastaFile->new(fastafile=>"t/data/dupe.fa")} qr/Validation failed/, 'duplicate fasta header';
    throws_ok{ValidateFasta::FastaFile->new(fastafile=>"t/data/pipe.fa")} qr/Validation failed/, 'pipes in header';
    throws_ok{ValidateFasta::FastaFile->new(fastafile=>"t/data/noseq.fa")} qr/Validation failed/, 'no sequence';
    throws_ok{ValidateFasta::FastaFile->new(fastafile=>"t/data/emptyhead.fa")} qr/Validation failed/, 'no header';
    throws_ok{ValidateFasta::FastaFile->new(fastafile=>"t/data/protein.fa")} qr/Validation failed/, 'characters other than acgtn - not DNA';
    throws_ok{ValidateFasta::FastaFile->new(fastafile=>"t/data/corr.gff")} qr/Validation failed/, 'not fasta file';

done_testing();
