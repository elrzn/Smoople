package Smoople::Table;
use Moose;
use namespace::autoclean;

has 'name',    is => 'ro', isa => 'Str';
has 'columns', is => 'rw', isa => 'ArrayRef[Smoople::Table::Column]';

sub insert
{ my ($self, %p) = @_;
  my @columns = @{$self->columns};
  $_->add(@{$p{$_->name}}) for @columns;
  $self->columns(\@columns);
}

sub search
{ my ($self, %p) = @_;
  my $n_conditions = scalar keys %p;
  my @indexes      = do
  { my %h;    # Temporal hash to store candidate indexes.
    $h{$_}++
     for map { $_->seek(@{$p{$_->name}}) }
         map { $self->column($_) }
         keys %p;
    grep { $h{$_} == $n_conditions } keys %h;
  };

  # Just return the data for now.
  map { [@$_[@indexes]] } map { $_->data } @{$self->columns};
}

sub column
{ my ($self, $name) = @_;
  [grep { $_->name eq $name } @{$self->columns}]->[0];
}

__PACKAGE__->meta->make_immutable;

1;
