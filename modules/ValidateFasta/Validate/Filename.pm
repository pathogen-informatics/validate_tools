package ValidateFasta::Validate::Filename;
use Moose;
=head1 NAME

ValidateFasta::Validate::Filename

=head1 SYNOPSIS



=cut

sub is_valid
{
 my($self, $input_string) = @_;
 return 1 if ($input_string =~/^[A-Z][a-z]+_(sp.|[a-z]+)(_[a-zA-Z0-9\-]+){0,}_v(0\.{1,1}|[1-9]+\.{0,1})[0-9]{0,}(_[a-zA-Z0-9]+){0,1}\.fa$/);
  return 0;
}

__PACKAGE__->meta->make_immutable;

no Moose;

1;
