package Smoople::Table;
use Moose;
use namespace::autoclean;

has 'name',    is => 'ro', isa => 'Str';
has 'columns', is => 'ro', isa => 'ArrayRef[Str]';
has 'records', is => 'rw', isa => 'ArrayRef[Smoople::Table::Record]';

sub insert
{ my ($self, @data) = @_;
  $self->records([Smoople::Table::Record->new(data => \@data), @{$self->records || []}]);
}

__PACKAGE__->meta->make_immutable;

1;
