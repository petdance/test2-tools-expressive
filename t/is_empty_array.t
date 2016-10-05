#!perl -T

use strict;
use warnings;

use Test2::Bundle::Extended;
plan 3;

use Test2::Tools::Expressive;

use Test2::API qw( intercept );

imported_ok( 'is_empty_array' );

subtest 'PASS: simple pass, no name' => sub {
    plan 1;

    my $LINE = __LINE__ + 1;
    my $events = intercept { is_empty_array( [] ) };

    is(
        $events,
        array {
            event Ok => sub {
                call pass => 1;
                call effective_pass => 1;

                prop file => __FILE__;
                prop line => $LINE;
            };
            end();
        },
        'is_empty_array without a name'
    );
};


subtest 'PASS: simple pass, with name' => sub {
    plan 1;

    my $LINE = __LINE__ + 1;
    my $events = intercept { is_empty_array( [], 'Is this thing empty?' ) };
    is(
        $events,
        array {
            event Ok => sub {
                call name => 'Is this thing empty?';
                call pass => 1;
                call effective_pass => 1;

                prop file => __FILE__;
                prop line => $LINE;
            };
            end();
        },
        'is_empty_array with a name'
    );
};

done_testing();
