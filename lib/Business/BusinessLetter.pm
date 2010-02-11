package Business::BusinessLetter;

use strict;
use warnings;

use Any::Moose;

use Business::BusinessLetter::Assets;
use RTF::Writer();
use Template;
use DateTimeX::Easy;

my $template = Template->new({
    BLOCKS => {
        rtf => Business::BusinessLetter::Assets->rtf_template,
    }
});
    
sub format_rtf_field ($) {
    my $field = shift;
    $field = '' unless defined $field;
    s/^\s*//, s/\s*$// for $field;
    return RTF::Writer::rtfesc( $field );
}

sub format_rtf_body ($) {
    my $field = format_rtf_field shift;
    my @paragraphs = split m/(?:\s*\\line\s*)+/, $field;
    return join "\n\n", map { "{\\pard\n$_\\line\n\\par}" } @paragraphs;
}

sub render {
    my $self = shift;
    my %given = @_;

    my %context;
    for (qw/ from to salutation closing /) {
        $context{$_} = format_rtf_field $given{$_};
    }

    $context{$_} = format_rtf_body $given{$_} for qw/ body /;

    my $date = $given{date};
    my $date_format = "%B %d, %Y";
    if ( ref $date eq 'ARRAY' ) {
        $date = $date->[0];
        $date_format = $date->[1] if $date->[1];
    }
    if ( !defined $date || $date =~ m/^\s*today\s*$/  ) {
        $date = 'today' unless defined $date;
        s/^\s*//, s/\s*$// for $date;
        my $parsed_date = DateTimeX::Easy->parse( $date );
        $date = $parsed_date->strftime( $date_format ) if $parsed_date;
    }
    $date = format_rtf_field $date;
    $context{date} = $date;

#        from => rtfesc $sections[0],
#        date => rtfesc $sections[1],
#        to => rtfesc $sections[2],
#        salutation => rtfesc $sections[3],
#        body => rtfesc $sections[4],
#        closing => rtfesc $sections[5],

    my $output;
    $template->process( 'rtf', { %context }, \$output ) or die $template->error;
    return $output;
}

1;
