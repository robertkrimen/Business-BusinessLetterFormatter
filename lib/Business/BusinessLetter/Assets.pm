package Business::BusinessLetter::Assets;

use strict;
use warnings;

sub rtf_template {

    return <<'_END_';
[% SWITCH( style ) %]
[% CASE 'full' %]
[% CASE [ 'modified', 'indented' ] %]
[% SET indentation = "\\li5760" %]
[% END %]
[% CLEAR -%]
{\rtf1\ansi\deff0

{\fonttbl
{\f0 Times New Roman;}
}

{\pard[% indentation %]
[% from %]
\line
\par}

[% IF date %]
{\pard[% indentation %]
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

{\pard[% indentation %]
[% closing %]
\line
\par}

}
_END_
}

1;
