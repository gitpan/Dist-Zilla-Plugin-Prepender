
use strict;
use warnings;

use Module::Build 0.3601;

my %module_build_args = (
                       'dist_abstract' => 'prepend lines at the top of your perl files',
                       'dist_author' => [
                                          'Jerome Quelin'
                                        ],
                       'dist_name' => 'Dist-Zilla-Plugin-Prepender',
                       'script_files' => [],
                       'module_name' => 'Dist::Zilla::Plugin::Prepender',
                       'requires' => {
                                       'Test::More' => 0,
                                       'perl' => '5.008',
                                       'MooseX::Has::Sugar' => 0,
                                       'MooseX::Types::Moose' => 0,
                                       'Dist::Zilla::Role::FileMunger' => 0,
                                       'English' => 0,
                                       'File::Find' => 0,
                                       'Dist::Zilla' => 0,
                                       'File::Spec::Functions' => 0,
                                       'Moose' => 0
                                     },
                       'license' => 'perl'
                     );


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
