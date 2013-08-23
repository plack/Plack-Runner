# NAME

Plack::Runner - plackup core

# SYNOPSIS

    # Your bootstrap script
    use Plack::Runner;
    my $app = sub { ... };

    my $runner = Plack::Runner->new;
    $runner->parse_options(@ARGV);
    $runner->run($app);

# DESCRIPTION

Plack::Runner is the core of [plackup](http://search.cpan.org/perldoc?plackup) runner script. You can create
your own frontend to run your application or framework, munge command
line options and pass that to `run` method of this class.

`run` method does exactly the same thing as the [plackup](http://search.cpan.org/perldoc?plackup) script
does, but one notable addition is that you can pass a PSGI application
code reference directly to the method, rather than via `.psgi`
file path or with `-e` switch. This would be useful if you want to
make an installable PSGI application.

Also, when `-h` or `--help` switch is passed, the usage text is
automatically extracted from your own script using [Pod::Usage](http://search.cpan.org/perldoc?Pod::Usage).

# NOTES

Do not directly call this module from your `.psgi`, since that makes
your PSGI application unnecessarily depend on [plackup](http://search.cpan.org/perldoc?plackup) and won't run
other backends like [Plack::Handler::Apache2](http://search.cpan.org/perldoc?Plack::Handler::Apache2) or mod\_psgi.

If you _really_ want to make your `.psgi` runnable as a standalone
script, you can do this:

    my $app = sub { ... };

    unless (caller) {
        require Plack::Runner;
        my $runner = Plack::Runner->new;
        $runner->parse_options(@ARGV);
        return $runner->run($app);
    }

    return $app;

__WARNING__: this section used to recommend `if (__FILE__ eq $0)` but
it's known to be broken since Plack 0.9971, since `$0` is now
_always_ set to the .psgi file path even when you run it from
plackup.

# SEE ALSO

[plackup](http://search.cpan.org/perldoc?plackup)

# AUTHOR

Tatsuhiko Miyagawa

# COPYRIGHT

The following copyright notice applies to all the files provided in
this distribution, including binary files, unless explicitly noted
otherwise.

Copyright 2009-2013 Tatsuhiko Miyagawa

# CORE DEVELOPERS

Tatsuhiko Miyagawa (miyagawa)

Tokuhiro Matsuno (tokuhirom)

Jesse Luehrs (doy)

Tomas Doran (bobtfish)

Graham Knop (haarg)

# CONTRIBUTORS

Yuval Kogman (nothingmuch)

Kazuhiro Osawa (Yappo)

Kazuho Oku

Florian Ragwitz (rafl)

Chia-liang Kao (clkao)

Masahiro Honma (hiratara)

Daisuke Murase (typester)

John Beppu

Matt S Trout (mst)

Shawn M Moore (Sartak)

Stevan Little

Hans Dieter Pearcey (confound)

mala

Mark Stosberg

Aaron Trevena

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
