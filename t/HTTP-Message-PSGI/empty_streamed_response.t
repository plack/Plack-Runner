use strict;
use warnings;
use Test::More;
use HTTP::Message::PSGI;
use HTTP::Request;
use HTTP::Response;
use Plack::Util;

my $app = sub {
    sub {
        my $cb = shift;
        $cb->([
            200,
            [],
            Plack::Util::inline_object(getline => sub {}, close => sub {})
        ]);
    };
};

my $env = req_to_psgi(HTTP::Request->new(POST => "http://localhost/post", [ ], 'hello'));

my $response = HTTP::Response->from_psgi($app->($env));

is($response->content, '', 'undef response body converted to empty string');

done_testing;

