#!/usr/bin/perl
use strict;
use AnyEvent::FriendFeed::Realtime;

my($user, $remote_key, $method) = @ARGV;
my $done = AnyEvent->condvar;

my $client = AnyEvent::FriendFeed::Realtime->new(
    username   => $user,
    remote_key => $remote_key,
    method     => $method || "home",
    on_entry   => sub {
        my $entry = shift;
        warn "$entry->{user}{name}: $entry->{title}\n";
    },
    on_error   => sub {
        warn "ERROR: $_[0]";
        $done->send;
    },
);

$done->recv;
