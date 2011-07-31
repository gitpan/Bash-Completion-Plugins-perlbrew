## no critic (RequireUseStrict)
package Bash::Completion::Plugins::perlbrew;
BEGIN {
  $Bash::Completion::Plugins::perlbrew::VERSION = '0.04';
}

## use critic (RequireUseStrict)
use strict;
use warnings;
use feature 'switch';
use parent 'Bash::Completion::Plugin';

use Bash::Completion::Utils qw(command_in_path);

my @perlbrew_commands = qw/
init    install list use           switch    mirror    off
version help    env  install-cpanm available uninstall self-upgrade
alias
/;

my @perlbrew_options = qw/
 -h --help -f --force -j -n --notest -q --quiet -v --verbose --as -D -U -A
/;

sub should_activate {
    return [ grep { command_in_path($_) } qw/perlbrew/ ];
}

sub complete {
    my ( $self, $r ) = @_;

    my $word = $r->word;

    if($word =~ /^-/) {
        $r->candidates(grep { /^\Q$word\E/ } @perlbrew_options);
    } else {
        my @args = $r->args;
        shift @args; # get rid of 'perlbrew'
        shift @args until @args == 0 || $args[0] !~ /^-/;

        my $command = $args[0] // '';

        given($command) {
            when($command eq $word) {
                $r->candidates(grep { /^\Q$word\E/ }
                    ( @perlbrew_commands, @perlbrew_options ));
            }
            when(qr/^switch|env|use|uninstall|alias$/) {
                my @perls = split /\n/, qx(perlbrew list);
                @perls = map { /^\*?\s*(?<name>\S+)/; $+{'name'} } @perls;
                $r->candidates(grep { /^\Q$word\E/ } @perls);
            }
            when('install') {
                my @perls = split /\n/, qx(perlbrew available);
                @perls = map { /^i?\s*(?<name>.*)/; $+{'name'}  } @perls;
                $r->candidates(grep { /^\Q$word\E/ } @perls);
            }
            default {
                # all other commands (including unrecognized ones) get
                # no completions
                $r->candidates();
            }
        }
    }
}

1;



=pod

=head1 NAME

Bash::Completion::Plugins::perlbrew - Bash completion for perlbrew

=head1 VERSION

version 0.04

=head1 DESCRIPTION

L<Bash::Completion> support for L<perlbrew|App::perlbrew>.  Completes perlbrew
options as well as installed perlbrew versions.

=head1 SEE ALSO

L<Bash::Completion>, L<Bash::Completion::Plugin>, L<App::perlbrew>

=begin comment

=over

=item should_activate

=item complete

=back

=end comment

=head1 AUTHOR

Rob Hoelz <rob@hoelz.ro>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Rob Hoelz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
http://github.com/hoelzro/bash-completion-plugins-perlbrew/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=cut


__END__

# ABSTRACT: Bash completion for perlbrew

