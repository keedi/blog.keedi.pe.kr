package TinyBlog::Schema;
{
  $TinyBlog::Schema::VERSION = '0.0.1';
}

use Fey::DBIManager::Source;
use Fey::Loader;
use Fey::ORM::Schema;
use TinyBlog::Model::Role;
use TinyBlog::Model::User;
use TinyBlog::Model::UserRole;

use Storable;
use File::Basename;
use File::Path qw(make_path);

sub load {
    my ( $class, %params ) = @_;

    return unless $class;
    return if     $class->Schema;

    _load_schema(%params) or die "cannot load schema\n";
    _load_tables(qw/
        TinyBlog::Model::Role
        TinyBlog::Model::User
        TinyBlog::Model::UserRole
    /) or die "cannot load tables\n";
}

sub _load_schema {
    my %params = @_;

    my %source_params = map {
        defined $params{$_} ? ( $_ => $params{$_} ) : ();
    } qw(
        name
        dbh
        dsn
        username
        password
        attributes
        post_connect
        auto_refresh
        ping_interval
    );

    my $source = Fey::DBIManager::Source->new( %source_params );
    my $schema;
    if ($params{cache_file} && -f $params{cache_file}) {
        $schema = retrieve($params{cache_file});
    }
    else {
        $schema = Fey::Loader->new( dbh => $source->dbh )->make_schema;
    }
    return if ref($schema) ne 'Fey::Schema';

    my $updated;
    if ($params{fk_relations}) {
        ++$updated;
        for my $relation ( @{ $params{fk_relations} } ) {
            my $source_table  = $relation->{source_table};
            my $source_column = $relation->{source_column};
            my $target_table  = $relation->{target_table};
            my $target_column = $relation->{target_column};

            my $fk = Fey::FK->new(
                source_columns => $schema->table($source_table)->column($source_column),
                target_columns => $schema->table($target_table)->column($target_column),
            );
            $schema->add_foreign_key($fk);
        }
    }

    #
    # Add foreign key if it is needed or remove it
    #
    #my $fk;
    #
    #$fk = Fey::FK->new(
    #    source_columns => $schema->table('src_table')->column('col_id'),
    #    target_columns => $schema->table('dest_table')->column('col_id'),
    #);
    #$schema->add_foreign_key($fk);

    if ($params{cache_file}) {
        if (!-e $params{cache_file} || $updated) {
            my $dirname = dirname($params{cache_file});
            make_path($dirname) unless -e $dirname;
            store($schema, $params{cache_file});
        }
    }

    has_schema $schema;

    __PACKAGE__->DBIManager->add_source($source);

    return 1;
}

sub _load_tables {
    my @tables = @_;

    $_->load for @tables;

    return 1;
}

1;

__END__
=pod

=encoding utf-8

=head1 NAME

TinyBlog::Schema

=head1 VERSION

version 0.0.1

=head1 AUTHOR

Keedi Kim - 김도형 <keedi@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Keedi Kim.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

