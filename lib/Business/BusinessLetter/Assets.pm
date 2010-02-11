package Business::BusinessLetter::Assets;

use strict;
use warnings;

sub rtf_template {

    return <<'_END_';
{\rtf1\ansi\deff0

{\fonttbl
{\f0 Times New Roman;}
}

{\pard\li5760
[% from %]
\line
\par}

[% IF date %]
{\pard\li5760
[% date %]
\line
\par}
[% END %]

{\pard
[% to %]
\line
\par}

{\pard
[% salutation %]
\line
\par}

[% body %]

{\pard
[% closing %]
\line
\par}

}
_END_
}

1;
