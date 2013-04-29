package Test::More::Hooks;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.02";
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
__END__

=encoding utf-8

=head1 NAME

Test::More::Hooks - It provides before/after hooks of subtest.

=head1 SYNOPSIS

    use Test::More;
    use Test::More::Hooks;

    subtest "some context" => sub {
        my $subject;
        before { $subject = Foo->new; };
        after  { undef $subject; };

        subtest "given some argument" => sub {
            my $actual = $subject->foo(1,2,3);
            is $actual, 10;
        };
    };

=head1 DESCRIPTION

Test::More::Hooks is ...

=head1 LICENSE

Copyright (C) ainame.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ainame E<lt>ainame954@facebook.comE<gt>

=cut

