# 
# This file is part of Dist-Zilla-Plugin-Prepender
# 
# This software is copyright (c) 2009 by Jerome Quelin.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 
use 5.008;
use strict;
use warnings;

package Dist::Zilla::Plugin::Prepender;
our $VERSION = '1.093190';


# ABSTRACT: prepend lines at the top of your perl files

use Moose;
use MooseX::Has::Sugar;
use MooseX::Types::Moose qw{ ArrayRef };

with 'Dist::Zilla::Role::FileMunger';


# -- attributes

# accept some arguments multiple times.
sub mvp_multivalue_args { qw{ line } }

has copyright => ( ro, default => 0 );
has _lines => (
    ro, lazy, auto_deref,
    isa        => ArrayRef,
    init_arg   => 'line',
    default    => sub { [] },
);


# -- public methods

sub munge_file {
    my ($self, $file) = @_;

    return $self->_munge_perl($file) if $file->name    =~ /\.(?:pm|pl)$/i;
    return $self->_munge_perl($file) if $file->content =~ /^#!(?:.*)perl(?:$|\s)/;
    return;
}

# -- private methods

#
# $self->_munge_perl($file);
#
# munge content of perl $file: add stuff at the top of the file
#
sub _munge_perl {
    my ($self, $file) = @_;
    my @prepend;
    my @lines = split /\n/, $file->content;

    # add copyright information if requested
    if ( $self->copyright ) {
        my @copyright = (
            '',
            "This file is part of " . $self->zilla->name,
            '',
            split(/\n/, $self->zilla->license->notice),
            '',
        );
        push @prepend, map { "# $_" } @copyright;
    }

    # add hand-written lines to prepend
    push @prepend, $self->_lines;

    # insertion point depends if there's a shebang line
    my $id = ( $lines[0] =~ /^#!(?:.*)perl(?:$|\s)/ ) ? 1 : 0;
    splice @lines, $id, 0, @prepend;
    $file->content(join "\n", @lines);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;



=pod

=head1 NAME

Dist::Zilla::Plugin::Prepender - prepend lines at the top of your perl files

=head1 VERSION

version 1.093190

=head1 SYNOPSIS

In your F<dist.ini>:

    [Prepender]
    copyright = 1
    line = use strict;
    line = use warnings;

=head1 DESCRIPTION

This plugin will prepend the specified lines in each Perl module or
program within the distribution. For scripts having a shebang line,
lines will be inserted just after it.

This is useful to enforce a set of pragmas to your files (since pragmas
are lexical, they will be active for the whole file), or to add some
copyright comments, as the fsf recommends.

The module accepts the following options in its F<dist.ini> section:

=over 4

=item * copyright - whether to insert a boilerplate copyright comment.
defaults to false.

=item * line - anything you want to add. may be specified multiple
times. no default.

=back

=begin Pod::Coverage

multivalue_args
munge_file


=end Pod::Coverage

=head1 SEE ALSO

You can look for information on this module at:

=over 4

=item * Search CPAN

L<http://search.cpan.org/dist/Dist-Zilla-Plugin-Prepender>

=item * See open / report bugs

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dist-Zilla-Plugin-Prepender>

=item * Mailing-list (same as L<Dist::Zilla>)

L<http://www.listbox.com/subscribe/?list_id=139292>

=item * Git repository

L<http://github.com/jquelin/dist-zilla-plugin-prepender.git>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Dist-Zilla-Plugin-Prepender>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Dist-Zilla-Plugin-Prepender>

=back

=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__