#!/usr/bin/env perl

use HTTP::Tiny;

use v5.10;

my $http = HTTP::Tiny->new;
my $exitcode = 0;

my %sources = (
  'assets/ractive.js' => 'http://cdn.ractivejs.org/latest/ractive.js'
);

while ( my ($file, $source) = each %sources ) {
  my $response = $http->mirror($source, $file);
  if ($response->{success}) {
    say "$file " . (($response->{status} eq '304') ? "not changed" : "updated: $response->{headers}{'last-modified'}");
  } else {
    say "Error fetching $source: ! $response->{status}: $response->{reason}";
    $exitcode = 1;
  }
}

if ($exitcode) {
  say "Please see the above output for errors";
  exit $exitcode;
}
