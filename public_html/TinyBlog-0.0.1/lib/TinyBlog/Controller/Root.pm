package TinyBlog::Controller::Root;
{
  $TinyBlog::Controller::Root::VERSION = '0.0.1';
}
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');


sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}


sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}


sub end : ActionClass('RenderView') {}


__PACKAGE__->meta->make_immutable;

1;

__END__
=pod

=encoding utf-8

=head1 NAME

TinyBlog::Controller::Root

=head1 VERSION

version 0.0.1

=head1 DESCRIPTION

[enter your description here]

=head1 NAME

TinyBlog::Controller::Root - Root Controller for TinyBlog

=head1 METHODS

=head2 index

The root page (/)

=head2 default

Standard 404 error page

=head2 end

Attempt to render a view, if needed.

=head1 AUTHOR

Keedi Kim - 김도형 <keedi@cpan.org>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Keedi Kim - 김도형 <keedi@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Keedi Kim.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

