#!/usr/bin/env perl
use strict;
use warnings;
use TinyBlog;

TinyBlog->setup_engine('PSGI');
my $app = sub { TinyBlog->run(@_) };

use Plack::Builder;

builder {
    enable_if {
        $_[0]->{REMOTE_ADDR} eq '127.0.0.1'
    } "Plack::Middleware::ReverseProxy";

    $app;
};
