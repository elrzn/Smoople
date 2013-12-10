package Smoople::Table::Column;
use Moose;
use namespace::autoclean;

has 'name', is => 'ro', isa => 'Str';
has 'data', is => 'rw', isa => 'ArrayRef[Any]';

sub add
{ my ($self, @xs) = @_;
  my @data = @{$self->data || []};
  unshift @xs, @data;
  $self->data(\@data);
}

__PACKAGE__->meta->make_immutable;

1;
