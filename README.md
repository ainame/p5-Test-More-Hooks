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

    subtest "other context" => sub {
        subtest "given some argument" => sub {
            my $subject;
            before { $subject = Foo->new; };
            after  { undef $subject; };

            subtest "foo argument" => sub {
                my $actual = $subject->foo(1,2,3);
                is $actual, 10;
			};
			
            subtest "bar argument" => sub {
                my $actual = $subject->foo(4,5,6);
                is $actual, 20;
			};
        };
    };

# DESCRIPTION

Test::More::Hooks is the only provider of before/after hooks.
When you want to use setup/teardown process in Test::More base tests,
you should insert 'use Test::More::Hooks' after 'use Test::More;'.
You will be able to use before/after hooks for each next nested subtests.
You can use Test::More::subtest as usual, but some registered hooks called
before execute subtest's coderef and after.

I think the best perl testing framework is Test::Class. But, my almost
colleagues wrote Test::More::subtest based tests. Then, I write this moudle to
use setup/teardown process in Test::More::subtest.

# LICENSE

Copyright (C) ainame.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ainame <ainame954@facebook.com>
