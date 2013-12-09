package Smoople::Table::Record;
use Moose;
use namespace::autoclean;
use Digest::MD5;

extends 'Smoople::Table';

has 'id', is => 'ro', isa => 'Any', default => sub { Digest::MD5::md5_hex($$ . time . rand) };
has 'data', is => 'rw', isa => 'ArrayRef[Any]';

__PACKAGE__->meta->make_immutable;

1;
