#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

BEGIN { unshift(@INC, './modules') }
BEGIN {
    use Test::Most;
    use_ok('ValidateFasta::Filename');}
ok(ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_v0.04_IMG.fa"),"validate filename object initialisation");
ok(ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_v0.04.fa"),"validate filename object initialisation");
ok(ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_v1.fa"),"validate filename object initialisation");
ok(ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_StrainX1_v0.04_IMG.fa"),"validate filename object initialisation");
ok(ValidateFasta::Filename->new(filename=>"Parastrongyloides_sp._Str1_v0.04_IMG.fa"),"validate filename object initialisation");
ok(ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_StrainX-1_v0.04_IMG.fa"),"validate filename object initialisation");
throws_ok{ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri__v0.04_IMG.fa")} qr/Validation failed/, 'double underscore fail';
throws_ok{ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_v0.04_IMG.f")} qr/Validation failed/, 'Not .fa';
throws_ok{ValidateFasta::Filename->new(filename=>"arastrongyloides_trichosuri_v0.04_IMG.fa")} qr/Validation failed/, 'Invalid genus';
throws_ok{ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_0.04_IMG.fa")} qr/Validation failed/, 'no v in version number';
throws_ok{ValidateFasta::Filename->new(filename=>"_trichosuri_0.04_IMG.fa")} qr/Validation failed/, 'opening underscore';
throws_ok{ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_v0.04_IMG_123.fa")} qr/Validation failed/, 'double suffix';
throws_ok{ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_v0_IMG.fa")} qr/Validation failed/, 'version zero';
throws_ok{ValidateFasta::Filename->new(filename=>"Parastrongyloides_trichosuri_06Apr2012_IMG.fa")} qr/Validation failed/, 'date not version number';

done_testing();
