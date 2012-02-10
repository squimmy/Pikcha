#!/usr/bin/perl
package Pikcha;

use Moose;
use LWP::UserAgent;
use JSON;
use URI::Escape;

has http_referer => (
	is       => 'rw',
	isa      => 'Str',
	required => 1,);

has _base_url => (
	is       => 'ro',
	init_arg => undef,
	default  => "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=",);


has _ua => (
	is       => 'ro',
	init_arg => undef,
	default  => sub { return  LWP::UserAgent->new(); },);

sub BUILD
{
	my $self = shift;
	$self->_ua->default_header(HTTP_REFERER => $self->http_referer);
}

sub get_image
{
	my $self = shift;
	my $term = shift;
	my $escaped = uri_escape($term);
	my $url = $self->_base_url . $escaped;
	my $body = $self->_ua->get($url);
	my $json = from_json($body->decoded_content);
	my $result = ${$json->{responseData}->{results}}[0];
	return $result->{url}
}

no Moose;
__PACKAGE__->meta->make_immutable;
