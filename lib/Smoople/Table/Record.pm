package Smoople::Table::Record;
use Moose;
use namespace::autoclean;
use Digest::MD5;

extends 'Smoople::Table';

has 'id', is => 'ro', isa => 'Any', default => sub { Digest::MD5::md5_hex($$ . time . rand) };
has 'ts', is => 'ro', isa => 'Int', default => sub { time };
has 'index', is => 'ro', isa => 'Int';
has 'data',  is => 'rw', isa => 'HashRef[Any]';

sub BUILD
{ my $self = shift;
  my $data = $self->data;
  $data->{_id} = $self->id;
  $data->{_ts} = $self->ts;
}

__PACKAGE__->meta->make_immutable;

1;
