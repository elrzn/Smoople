package Smoople;
use Moose;
use namespace::autoclean;
use Smoople::Table;
use Smoople::Table::Column;

has 'tables', is => 'rw', isa => 'ArrayRef[Smoople::Table]';

our $VERSION = '0.03';

sub _make_table
{ my ($self, %p) = @_;
  my @cols = map { Smoople::Table::Column->new(name => $_) } @{$p{columns}};
  Smoople::Table->new(name    => $p{name},
                      columns => \@cols);
}

sub create_table
{ my ($self, %p) = @_;
  my $table = $self->_make_table(%p);
  $self->tables([@{$self->tables || []}, $table]);
  $table;
}

sub table
{ my ($self, $name) = @_;
  [grep { $_->name eq $name } @{$self->tables}]->[0];
}

__PACKAGE__->meta->make_immutable;

1;
