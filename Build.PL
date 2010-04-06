
use strict;
use warnings;

use Module::Build 0.3601;

my %module_build_args = (
                       'dist_abstract' => 'prepend lines at the top of your perl files',
                       'script_files' => [],
                       'license' => 'perl',
                       'build_requires' => {
                                             'Test::More' => '0',
                                             'English' => '0',
                                             'File::Find' => '0',
                                             'File::Temp' => '0',
                                             'Path::Class' => '0',
                                             'Dist::Zilla::Tester' => '0',
                                             'Module::Build' => '0.3601'
                                           },
                       'dist_name' => 'Dist-Zilla-Plugin-Prepender',
                       'dist_author' => [
                                          'Jerome Quelin'
                                        ],
                       'module_name' => 'Dist::Zilla::Plugin::Prepender',
                       'requires' => {
                                       'MooseX::Has::Sugar' => '0',
                                       'perl' => '5.008',
                                       'Dist::Zilla::Role::FileMunger' => '0',
                                       'Moose' => '0'
                                     },
                       'configure_requires' => {
                                                 'Module::Build' => '0.3601'
                                               },
                       'dist_version' => '1.100960'
                     );


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;