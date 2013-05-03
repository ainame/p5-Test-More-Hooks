# NAME

Test::More::Hooks - It provides before/after hooks of subtest.

# SYNOPSIS

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

# DESCRIPTION

Test::More::Hooks is simply testing module. This provides only before/after hooks
for Test::More::subtest based test cases.

# LICENSE

Copyright (C) ainame.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ainame <ainame954@facebook.com>
