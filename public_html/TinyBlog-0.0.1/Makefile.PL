
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Catalyst based application",
  "AUTHOR" => "Keedi Kim - \352\271\200\353\217\204\355\230\225 <keedi\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Catalyst::Test" => 0,
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "TinyBlog",
  "EXE_FILES" => [
    "bin/update-module.pl",
    "bin/dump-mysql.pl"
  ],
  "LICENSE" => "perl",
  "NAME" => "TinyBlog",
  "PREREQ_PM" => {
    "App::mkfeyorm" => 0,
    "Catalyst" => 0,
    "Catalyst::Controller" => 0,
    "Catalyst::Plugin::Authentication" => 0,
    "Catalyst::Plugin::Authorization::Roles" => 0,
    "Catalyst::Plugin::ConfigLoader" => 0,
    "Catalyst::Plugin::Session" => 0,
    "Catalyst::Plugin::Session::State::Cookie" => 0,
    "Catalyst::Plugin::Session::Store::FastMmap" => 0,
    "Catalyst::Plugin::StackTrace" => 0,
    "Catalyst::Plugin::Static::Simple" => 0,
    "Catalyst::Runtime" => "5.80",
    "Const::Fast" => 0,
    "Fey::DBIManager::Source" => 0,
    "Fey::Loader" => 0,
    "Fey::ORM::Schema" => 0,
    "Fey::ORM::Table" => 0,
    "File::Basename" => 0,
    "File::Path" => 0,
    "File::Slurp" => 0,
    "Getopt::Long::Descriptive" => 0,
    "Moose" => 0,
    "MooseX::SemiAffordanceAccessor" => 0,
    "MooseX::StrictConstructor" => 0,
    "Storable" => 0,
    "autodie" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.0.1",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



