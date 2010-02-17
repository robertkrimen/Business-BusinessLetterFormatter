#!/usr/bin/env perl

use strict;
use warnings;

use Plack::Builder;
use Plack::Request;
use Business::BusinessLetter;
use Template;

my $template = Template->new( INCLUDE_PATH => './root/tt' );

my $app = sub {
    my ($env) = @_;
    my $request = Plack::Request->new( $env );

    my $response = $request->new_response( 200 );
    $response->content_type( 'text/html' );
    my $output;

    if ( $request->path =~ m/^\/rtf\/?/ ) {
        $output = Business::BusinessLetter->render(
            ( map { $_ => $request->parameters->{$_} }
                qw/ from date to salutation body closing style / )
        );
        $response->content_type( 'text/rtf' );
        $response->headers->header( 'Content-Disposition' => 'attachment; filename=letter.rtf' );
    }
    else {
        $template->process( 'index.tt.html', {}, \$output ) or die $template->error;
    }
    $response->body( $output );
    return $response->finalize;
};

builder {
    enable 'Plack::Middleware::Static',
        path => qr{^/(images|js|css)/}, root => './root/';
    $app;
};
