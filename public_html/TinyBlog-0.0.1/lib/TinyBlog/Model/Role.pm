package TinyBlog::Model::Role;
{
  $TinyBlog::Model::Role::VERSION = '0.0.1';
}
use Fey::ORM::Table;
use TinyBlog::Schema;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use namespace::autoclean;

sub load {
    my $class = shift;

    return unless $class;
    return if     $class->Table;

    my $schema = TinyBlog::Schema->Schema;
    my $table  = $schema->table('role');

    has_table( $table );

    #
    # Add another relationships like has_one, has_many or etc.
    #
    #has_many items => ( table => $schema->table('item') );
}

1;

__END__
=pod

=encoding utf-8

=head1 NAME

TinyBlog::Model::Role

=head1 VERSION

version 0.0.1

=head1 AUTHOR

Keedi Kim - 김도형 <keedi@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Keedi Kim.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

