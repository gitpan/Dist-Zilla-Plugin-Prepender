
use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  module_name   => 'Dist::Zilla::Plugin::Prepender',
  license       => 'perl',
  dist_abstract => "prepend\ lines\ at\ the\ top\ of\ your\ perl\ files",
  dist_name     => "Dist\-Zilla\-Plugin\-Prepender",
  dist_author   => [
"Jerome\ Quelin",
  ],
  requires      => {
    "MooseX::Has::Sugar" => '0',
    "MooseX::Types::Moose" => '0',
    "English" => '0',
    "ExtUtils::MakeMaker" => '0',
    "perl" => '5.008',
    "Test::More" => '0',
    "Dist::Zilla::Role::FileMunger" => '0',
    "File::Find" => '0',
    "Dist::Zilla" => '0',
    "File::Spec::Functions" => '0',
    "Moose" => '0',
  },
  script_files => [ qw() ],
);

$build->create_build_script;
