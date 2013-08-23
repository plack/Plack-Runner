requires 'perl', '5.008001';

requires 'File::ShareDir', '1.00';
requires 'HTTP::Body', '1.06';
requires 'HTTP::Message', '5.814';
requires 'Hash::MultiValue', '0.05';
requires 'Pod::Usage', '1.36';
requires 'Stream::Buffered', '0.02';
requires 'Test::TCP', '2.00';
requires 'Try::Tiny';
requires 'URI', '1.59';
requires 'parent';
requires 'HTTP::Tiny', 0.034;

on test => sub {
    requires 'Test::More', '0.88';
    requires 'Test::Requires';
    suggests 'LWP::UserAgent', '5.814';
};
