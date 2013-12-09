package Smoople::Table::Column;
use Moose;
use namespace::autoclean;

has 'name', is => 'ro', isa => 'Str';
has 'data', is => 'rw', isa => 'Any';

sub add
{ my $self = shift;
  $self->data([@_, @{$self->data || []}]);
}

__PACKAGE__->meta->make_immutable;

1;
