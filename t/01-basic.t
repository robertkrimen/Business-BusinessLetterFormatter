use strict;
use warnings;

use Test::Most;

plan qw/no_plan/;

use Business::BusinessLetter;

my $body;
$body = <<_END_;
1st line

2nd line
_END_

is( Business::BusinessLetter::format_rtf_body( $body ), <<_END_ );
_END_

1;
