package TinyBlog::Model::User;
{
  $TinyBlog::Model::User::VERSION = '0.0.1';
}
use Fey::ORM::Table;
use TinyBlog::Schema;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use namespace::autoclean;

has roles => (
    is         => 'ro',
    isa        => 'Fey::Object::Iterator::FromSelect',
    lazy_build => 1,
);

sub _build_roles {
    my $self = shift;

    my $schema    = TinyBlog::Schema->Schema;
    my $dbh       = TinyBlog::Schema->DBIManager->default_source->dbh;
    my $user      = $schema->table('user');
    my $role      = $schema->table('role');
    my $user_role = $schema->table('user_role');

    my $select = TinyBlog::Schema->SQLFactoryClass->new_select
        ->select($role)
        ->from($role,      $user_role)
        ->from($user_role, $user)
        ->where($user->column('id'), '=', Fey::Placeholder->new)
        ;

    return Fey::Object::Iterator::FromSelect->new(
        classes     => 'TinyBlog::Model::Role',
        dbh         => $dbh,
        select      => $select,
        bind_params => [ $self->id ],
    );
}

sub load {
    my $class = shift;

    return unless $class;
    return if     $class->Table;

    my $schema = TinyBlog::Schema->Schema;
    my $table  = $schema->table('user');

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

TinyBlog::Model::User

=head1 VERSION

version 0.0.1

=head1 AUTHOR

Keedi Kim - 김도형 <keedi@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Keedi Kim.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

