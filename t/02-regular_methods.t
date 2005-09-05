#!perl -T

use Test::More tests => 20;
use MMS::MailMessage;

my $message = new MMS::MailMessage;

is($message->header_datetime("Somedate"),'Somedate');
is($message->header_subject("Subject"),'Subject');
is($message->header_from("From"),'From');
is($message->header_to("To"),'To');
is($message->header_text("Text"),'Text');

is($message->header_datetime,"Somedate");
is($message->header_subject,"Subject");
is($message->header_from,"From");
is($message->header_to,"To");
is($message->header_text,"Text");

# Depricated methods

is($message->headerdatetime("Somedate"),'Somedate');
is($message->headersubject("Subject"),'Subject');
is($message->headerfrom("From"),'From');
is($message->headerto("To"),'To');
is($message->headertext("Text"),'Text');

is($message->headerdatetime,"Somedate");
is($message->headersubject,"Subject");
is($message->headerfrom,"From");
is($message->headerto,"To");
is($message->headertext,"Text");
