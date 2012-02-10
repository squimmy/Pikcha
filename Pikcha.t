#!/usr/bin/perl

use warnings; use strict;
use Test::More tests => 2;

use Pikcha;

my $pikcha;
ok($pikcha = Pikcha->new(http_referer => "https://github.com/squimmy/Pikcha"), "Constructor");
is($pikcha->get_image("nasa logo wikipedia"), "http://upload.wikimedia.org/wikipedia/commons/2/25/Nasa-logo.gif", "Sample Google image search");
