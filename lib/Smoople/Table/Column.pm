package Smoople::Table::Column;
use Moose;
use namespace::autoclean;

has 'name', is => 'ro', isa => 'Str';
has 'data', is => 'rw', isa => 'ArrayRef[Any]';

sub add
{ my ($self, @xs) = @_;
  my @data = @{$self->data || []};
  unshift @data, @xs;
  $self->data(\@data);
}

sub seek
{ my ($self, @equals) = @_;
  my @data    = @{$self->data};
  my @indexes = ();
  for my $i (0 .. $#data)
  { push @indexes, $i if grep { $data[$i] eq $_ } @equals;
  }
  @indexes;
}

__PACKAGE__->meta->make_immutable;

1;
