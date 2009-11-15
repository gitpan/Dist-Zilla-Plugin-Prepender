
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-Prepender',
  NAME      => 'Dist::Zilla::Plugin::Prepender',
  AUTHOR    => "Jerome\ Quelin",
  ABSTRACT  => "prepend\ lines\ at\ the\ top\ of\ your\ perl\ files",
  VERSION   => '1.093190',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Test::More" => '0',
    "perl" => '5.008',
    "MooseX::Has::Sugar" => '0',
    "MooseX::Types::Moose" => '0',
    "Dist::Zilla::Role::FileMunger" => '0',
    "English" => '0',
    "File::Find" => '0',
    "Dist::Zilla" => '0',
    "File::Spec::Functions" => '0',
    "Moose" => '0',
  },
  test => {TESTS => 't/*.t'}
);

