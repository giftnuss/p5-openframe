package OpenFrame::Response;

use strict;
use Class::MethodMaker
           new_with_init => 'new',
           new_hash_init => 'hash_init',
           get_set       => [ qw/message mimetype code cookies last_modified/ ];

use Exporter;
use OpenFrame::Cookietin;
use URI;

our $VERSION = 2.12;

sub init {
  my($self, %params) = @_;
  $params{cookies} ||= OpenFrame::Cookietin->new();
  hash_init($self, %params);
}

__END__

=head1 NAME

OpenFrame::Response - An abstract response class

=head1 SYNOPSIS

  use OpenFrame;
  use OpenFrame::Constants;
  my $r = OpenFrame::Response->new();
  $r->message("<html><body>Hello world!</body></html>");
  $r->mimetype('text/html');
  $r->code(ofOK);
  $r->last_modified($machine_time);
  $r->cookies(OpenFrame::Cookietin->new());

=head1 DESCRIPTION

C<OpenFrame::Response> represents responses inside
OpenFrame. Responses represent some kind of response following a
request for information.

This module abstracts the way clients can respond with data from
OpenFrame.

=head1 METHODS

=head2 new()

This method creates a new C<OpenFrame::Response> object. It
takes no parameters.

=head2 cookies()

This method gets and sets the C<OpenFrame::Cookietin> that is
associated with this response.

  my $cookietin = $r->cookies();
  $r->cookies(OpenFrame::Cookietin->new());

=head2 message()

This method gets and sets the message string associated with this response.

  my $message = $r->message();
  $r->message("<html><body>Hello world!</body></html>");

=head2 code()

This method gets and sets the message code associated with this
response. The following message codes are exported when you use
C<OpenFrame::Constants>: ofOK, ofERROR, ofREDIRECT, ofDECLINED.

  my $code = $r->code();
  $r->code(ofOK);

=head2 mimetype()

This method gets and sets the MIME type associated with this response.

  my $type = $r->mimetype();
  $r->mimetype('text/html');

=head2 last_modified()

This method gets and sets the last modified time of the data
associated with this response.

  my $type = $r->last_modified();
  my $time = (stat($file))[9];
  $r->last_modified($time);

=head1 AUTHOR

James Duncan <jduncan@fotango.com>

=cut

1;
