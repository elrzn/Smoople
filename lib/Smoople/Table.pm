package Smoople::Table;
use Moose;
use namespace::autoclean;
use List::Util qw(max);

has 'name',    is => 'ro', isa => 'Str';
has 'columns', is => 'rw', isa => 'ArrayRef[Smoople::Table::Column]';

sub insert
{ my ($self, %p) = @_;
  my $last = max map { scalar @{$p{$_}} - 1 } keys %p;
  my @columns = @{$self->columns};
  for my $index (0 .. $last)
  { my %params = map { $_ => $p{$_}->[$index] } keys %p;
    my $record = Smoople::Table::Record->new(data => \%params);
    $_->add($record->data->{$_->name}) for @columns;
  }
  $self->columns(\@columns);
}

sub column
{ my ($self, $name) = @_;
  [grep { $_->name eq $name } @{$self->columns}]->[0];
}

__PACKAGE__->meta->make_immutable;

1;
