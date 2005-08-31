#!perl -T

use Test::More tests => 10;
use MMS::MailMessage;

my $message = new MMS::MailMessage;

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

