
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Module::Build' => '0.3601'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Bash completion for perlbrew',
  'dist_author' => [
    'Rob Hoelz <rob@hoelz.ro>'
  ],
  'dist_name' => 'Bash-Completion-Plugins-perlbrew',
  'dist_version' => '0.04',
  'license' => 'perl',
  'module_name' => 'Bash::Completion::Plugins::perlbrew',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'Bash::Completion' => '0.001',
    'perl' => '5.10.0'
  },
  'script_files' => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
