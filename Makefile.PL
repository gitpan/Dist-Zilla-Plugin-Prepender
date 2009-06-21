
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-Prepender',
  NAME      => 'Dist::Zilla::Plugin::Prepender',
  AUTHOR    => 'Jerome\ Quelin',
  ABSTRACT  => 'prepend\ lines\ at\ the\ top\ of\ your\ perl\ files',
  VERSION   => '0.2.0',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Test::More" => '0',
    "File::Find::Rule" => '0',
    "Dist::Zilla" => '0',
    "Moose" => '0',
  },
);
