package Smoople;

use Moose;
use namespace::autoclean;

our $VERSION = '0.01';

has 'tables', is => 'rw', isa => 'ArrayRef[Smoople::Table]';

sub _make_table
{ my ($self, %p) = @_;
  Smoople::Table->new(name => $p{name}, columns => $p{columns});
}

sub create_table
{ my ($self, %p) = @_;
  $self->tables([@{$self->tables || []}, $self->_make_table(%p)]);
}

sub table
{ my ($self, $name) = @_;
  [grep { $_->name eq $name } @{$self->tables}]->[0];
}

__PACKAGE__->meta->make_immutable;

1;
