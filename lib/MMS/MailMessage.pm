package MMS::MailMessage;

use warnings;
use strict;


=head1 NAME

MMS::MailMessage - A class representing an MMS (or picture) message.

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

This class is used by MMS::MailParser to provide an itermediate data storage class after the MMS has been parsed but before it has been through the second stage of parsing (the provider parser).

=head1 METHODS

The following are the top-level methods of the MMS::MailMessage class.

=head2 Constructor

=over

=item new()

Return a new MMS::MailMessage object.

=back

=head2 Regular Methods

=over

=item header_datetime STRING

Returns the time and date the MMS was sent (?) when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.

=item header_from STRING

Returns the sending email address the MMS was sent from when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.

=item header_to STRING

Returns the recieving email address the MMS was sent to when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.

=item header_subject STRING

Returns the MMS subject when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.

=item header_text STRING

Returns the MMS bodytext when invoked with no supplied parameter.  When supplied with a paramater it sets the object property to the supplied parameter.

=item attachments ARRAYREF

Returns an array reference to the array of MMS message attachments.  When supplied with a parameter it sets the object property to the supplied parameter.

=item add_attachment MIME::Entity

Adds the supplied MIME::Entity attachment to the attachment stack for the message.  This method is mainly used by the MMS::MailParser class to add attatchments while parsing.

=item is_valid

Returns true or false depending if the header_datetime, header_from and header_to fields are all populated or not.

=back

=head2 Deprecated Methods

Methods listed here are maintained for backwards compatibility and should not be used in new code as they may be removed in future versions.

=over

=item headerdatetime

Equivalent to header_datetime

=item headerfrom

Equivalent to header_from

=item headerto

Equivalent to header_to

=item headersubject

Equivalent to header_subject

=item headertext

Equivalent to header_text

=item addattachment

Equivalent to add_attachment

=item isvalid

Equivalent to is_valid

=back

=head1 AUTHOR

Rob Lee, C<< <robl@robl.co.uk> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-mms-mailmessage@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MMS-MailMessage>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 NOTES

To quote the perl artistic license ('perldoc perlartistic') :

10. THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
    WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES
    OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=head1 ACKNOWLEDGEMENTS

As per usual this module is sprinkled with a little Deb magic.

=head1 COPYRIGHT & LICENSE

Copyright 2005 Rob Lee, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

sub new {
  my $type = shift;
  my $self = {};
  bless $self, $type;

  $self->{fields} = [	"header_from",
			"header_to",
			"header_text",
			"header_datetime",
			"header_subject",
			"attachments"];

  foreach my $field (@{$self->{fields}}) {
    $self->{$field} = undef;
  }
  $self->{attachments} = [];

  return $self;
}

sub header_datetime {

  my $self = shift;

  if (@_) { $self->{header_datetime} = shift }
  return $self->{header_datetime};

}

sub header_from {

  my $self = shift;

  if (@_) { $self->{header_from} = shift }
  return $self->{header_from};

}

sub header_to {

  my $self = shift;

  if (@_) { $self->{header_to} = shift }
  return $self->{header_to};

}

sub header_text {

  my $self = shift;

  if (@_) { $self->{header_text} = shift }
  return $self->{header_text};

}

sub header_subject {

  my $self = shift;

  if (@_) { $self->{header_subject} = shift }
  return $self->{header_subject};

}

sub attachments {

  my $self = shift;

  if (@_) { $self->{attachments} = shift }
  return $self->{attachments};

}

sub add_attachment {

  my $self = shift;
  my $attachment = shift;

  unless (defined $attachment) {
    return 0;
  }

  push @{$self->{attachments}}, $attachment;

  return 1;

}

sub is_valid {

  my $self = shift;

  unless ($self->header_from) {
    return 0;
  }
  unless ($self->header_to) {
    return 0;
  }
  unless ($self->header_datetime) {
    return 0;
  }

  return 1;

}

sub _clonedata {

  my $self = shift;
  my $message = shift;

  foreach my $field (@{$self->{fields}}) {
    $self->{$field} = $message->{$field};
  }
 
}

sub DESTROY {

  my $self = shift;

  foreach my $attach (@{$self->{attachments}}) {
    $attach->bodyhandle->purge;
  }

}

# Deprecated Methods ############
# 

sub headerdatetime {
  header_datetime(@_);
}
sub headerfrom {
  header_from(@_);
}
sub headerto {
  header_to(@_);
}
sub headersubject {
  header_subject(@_);
}
sub headertext {
  header_text(@_);
}
sub addattachment {
  add_attachment(@_);
}
sub isvalid {
  is_valid(@_);
}

1; # End of MMS::MailMessage
