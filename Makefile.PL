
use strict;
use warnings;

use 5.008001;

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
install_share dist => "share";


my %WriteMakefileArgs = (
  "ABSTRACT" => "plackup core",
  "AUTHOR" => "Tatsuhiko Miyagawa",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.03"
  },
  "DISTNAME" => "Plack-Runner",
  "EXE_FILES" => [
    "script/plackup"
  ],
  "LICENSE" => "perl",
  "NAME" => "Plack::Runner",
  "PREREQ_PM" => {
    "File::ShareDir" => "1.00",
    "HTTP::Body" => "1.06",
    "HTTP::Message" => "5.814",
    "HTTP::Tiny" => "0.034",
    "Hash::MultiValue" => "0.05",
    "Pod::Usage" => "1.36",
    "Stream::Buffered" => "0.02",
    "Test::TCP" => "2.00",
    "Try::Tiny" => 0,
    "URI" => "1.59",
    "parent" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.88",
    "Test::Requires" => 0
  },
  "VERSION" => "1.0029",
  "test" => {
    "TESTS" => "t/*.t t/HTTP-Message-PSGI/*.t t/Plack-Loader/*.t t/Plack-Request/*.t t/Plack-Response/*.t t/Plack-Runner/*.t t/Plack-Test/*.t t/Plack-Util/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

{
package
MY;
use File::ShareDir::Install qw(postamble);
}


