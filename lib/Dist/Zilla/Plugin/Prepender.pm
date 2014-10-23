# 
# This file is part of Dist-Zilla-Plugin-Prepender
# 
# This software is copyright (c) 2009 by Jerome Quelin.
# 
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
# 
package Dist::Zilla::Plugin::Prepender;
our $VERSION = '0.2.0';

# ABSTRACT: prepend lines at the top of your perl files

use strict;
use warnings;

use Moose;
with 'Dist::Zilla::Role::FileMunger';


# -- attributes

# accept some arguments multiple times.
sub multivalue_args { qw{ line } }

has copyright => (
    is => 'ro',
    default => 0,
);
has _lines => (
    is         => 'ro',
    isa        => 'ArrayRef',
    lazy       => 1,
    auto_deref => 1,
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

version 0.2.0

=begin Pod::Coverage

multivalue_args
munge_file

=end Pod::Coverage

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

=head1 BUGS

Please report any bugs or feature request to
C<< <bug-dist-zilla-plugin-prepender@rt.cpan.org> >>, or through the web interface
at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dist-Zilla-Plugin-Prepender>.

=head1 AUTHOR

  Jerome Quelin

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Jerome Quelin.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 



__END__