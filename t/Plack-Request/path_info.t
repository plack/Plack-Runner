use strict;
use Test::More;
use Plack::Test;
use Plack::Request;
use HTTP::Request::Common;

my $path_app = sub {
    my $req = Plack::Request->new(shift);
    my $res = $req->new_response(200);
    $res->content_type('text/plain');
    $res->content($req->path_info);
    return $res->finalize;
};

my $app = sub {
    my $wrapped = shift;
    return sub {
        my $env = shift;
        if ($env->{PATH_INFO} =~ s{^/foo}{}) {
            $env->{SCRIPT_NAME} .= '/foo';
        }
        $wrapped->($env);
    }
}->($path_app);

test_psgi app => $app, client => sub {
    my $cb = shift;

    my $res = $cb->(GET "http://localhost/foo");
    is $res->content, '';

    $res = $cb->(GET "http://localhost/foo/bar");
    is $res->content, '/bar';

    $res = $cb->(GET "http://localhost/xxx/yyy");
    is $res->content, '/xxx/yyy';
};

done_testing;
