package Upload::Application;

use strict;
use File::MMagic;
use OpenFrame::Application;
use base qw (OpenFrame::Application);

our $epoints = { done => ['file1'] };

sub default {
  my $self = shift;
  my $session = shift;
  my $request = shift;
  my $config = shift;

  $self->{message} = "";
}

sub done {
  my $self = shift;
  my $session = shift;
  my $request = shift;
  my $config = shift;

  my $message;
  my $mm = File::MMagic->new();

  if ($request->arguments->{file1}) {
    my $fh = $request->arguments->{file1};
    my $file = (join '', <$fh>);
    if ($mm->checktype_contents($file) eq 'image/jpeg') {
      open(OUT, "> htdocs/first.jpg");
      print OUT $file;
      close OUT;
    } else {
      $message .= "file1 not JPEG. ";
    }
  }

  if ($request->arguments->{file2}) {
    my $fh = $request->arguments->{file2};
    my $file = (join '', <$fh>);
    if ($mm->checktype_contents($file) eq 'image/jpeg') {
      open(OUT, "> htdocs/second.jpg");
      print OUT $file;
      close OUT;
    } else {
      $message .= "file2 not JPEG. ";
    }
  }

  $self->{message} = $message;
}

1;

__END__

=head1 NAME

Upload::Application - A module containing the Upload logic

=head1 DESCRIPTION

C<Upload::Application> is part of the simple Upload web
application. The module contains all the logic and presentation for
Upload.

Note that the application only has two entry points: the default()
and done() subroutines.

The default() entry point is given itself, the session, an abstract
request, and per-application configuration. Note how the done()
entrypoint reads file handles in the arguments.

This code is small and clean as the output is generated by
C<Upload::Generator> later on in the slot process. Any messages are
passed in C<$self>.

=head1 AUTHOR

Leon Brocard <leon@fotango.com>

=head1 COPYRIGHT

Copyright (C) 2001, Fotango Ltd.

This module is free software; you can redistribute it or modify it
under the same terms as Perl itself.
