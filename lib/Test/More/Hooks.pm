package Test::More::Hooks;

use strict;
use warnings;
use Carp qw(croak);
use Test::Builder::Module;
our @ISA    = qw(Test::Builder::Module);
our @EXPORT = qw(subtest before after);

our $Level = 0;
our $BEFORE = {};
our $AFTER  = {};

BEGIN {
    croak "Test::More::Hooks must be loaded after Test::More."
        unless exists $INC{'Test/More.pm'};
}

sub subtest {
    my ($name, $subtests) = @_;
    $BEFORE->{$Level}->() if 'CODE' eq ref $BEFORE->{$Level};
    $Level += 1;

    my $tb = Test::More::Hooks->builder;
    my $result = $tb->subtest(@_);

    $Level -= 1;
    $AFTER->{$Level}->() if 'CODE' eq ref $AFTER->{$Level};
    return $result;
}

sub before (&) {
    my $block = shift;
    $BEFORE->{$Level} = $block;
}

sub after (&) {
    my $block = shift;
    $AFTER->{$Level} = $block;
}

1;
