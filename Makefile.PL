use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'MMS::MailMessage',
    AUTHOR              => 'Rob Lee <robl@robl.co.uk>',
    VERSION_FROM        => 'lib/MMS/MailMessage.pm',
    ABSTRACT_FROM       => 'lib/MMS/MailMessage.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'MMS-MailMessage-*' },
);
