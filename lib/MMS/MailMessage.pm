package MMS::MailMessage;

use warnings;
use strict;


=head1 NAME

MMS::MailMessage - A class representing an MMS (or picture) message.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

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

=item headerdatetime STRING

Returns the time and date the MMS was sent (?) when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.

=item headerfrom STRING

Returns the sending email address the MMS was sent from when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.

=item headerto STRING

Returns the recieving email address the MMS was sent to when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.

=item headersubject STRING

Returns the MMS subject when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.

=item headertext STRING

Returns the MMS bodytext when invoked with no supplied parameter.  When supplied with a paramater it sets the object property to the supplied parameter.

=item attachments ARRAYREF

Returns an array reference to the array of MMS message attachments.  When supplied with a parameter it sets the object property to the supplied parameter.

=item addattachment MIME::Entity

Adds the supplied MIME::Entity attachment to the attachment stack for the message.  This method is mainly used by the MMS::MailParser class to add attatchments while parsing.

=item isvalid

Returns true or false depending if the headerdatetime, headerfrom and headerto fields are all populated or not.

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

  $self->{fields} = [	"headerfrom",
			"headerto",
			"headertext",
			"headerdatetime",
			"headersubject",
			"attachments"];

  foreach my $field (@{$self->{fields}}) {
    $self->{$field} = undef;
  }
  $self->{attachments} = [];

  return $self;
}

sub headerdatetime {

  my $self = shift;

  if (@_) { $self->{headerdatetime} = shift }
  return $self->{headerdatetime};

}

sub headerfrom {

  my $self = shift;

  if (@_) { $self->{headerfrom} = shift }
  return $self->{headerfrom};

}

sub headerto {

  my $self = shift;

  if (@_) { $self->{headerto} = shift }
  return $self->{headerto};

}

sub headertext {

  my $self = shift;

  if (@_) { $self->{headertext} = shift }
  return $self->{headertext};

}

sub headersubject {

  my $self = shift;

  if (@_) { $self->{headersubject} = shift }
  return $self->{headersubject};

}

sub attachments {

  my $self = shift;

  if (@_) { $self->{attachments} = shift }
  return $self->{attachments};

}

sub addattachment {

  my $self = shift;
  my $attachment = shift;

  unless (defined $attachment) {
    return 0;
  }

  push @{$self->{attachments}}, $attachment;

  return 1;

}

sub isvalid {

  my $self = shift;

  unless ($self->headerfrom) {
    return 0;
  }
  unless ($self->headerto) {
    return 0;
  }
  unless ($self->headerdatetime) {
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



1; # End of MMS::MailMessage
