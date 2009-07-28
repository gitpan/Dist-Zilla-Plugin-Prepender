
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-Prepender',
  NAME      => 'Dist::Zilla::Plugin::Prepender',
  AUTHOR    => 'Jerome\ Quelin',
  ABSTRACT  => 'prepend\ lines\ at\ the\ top\ of\ your\ perl\ files',
  VERSION   => '0.2.1',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "File::Find::Rule" => '0',
    "Test::More" => '0',
    "Dist::Zilla::Role::FileMunger" => '0',
    "Dist::Zilla" => '0',
    "File::Spec::Functions" => '0',
    "Moose" => '0',
  },
);
