#!/usr/bin/env perl

use strict;
use warnings;

use Asset::Pack qw(find_and_pack);

my $ms = find_and_pack('assets', 'DB::CRUD::Asset');
foreach my $cat ('ok', 'unchanged', 'fail') {
  my @items = @{$ms->{$cat}};
  foreach my $m (@items) {
    print "$cat $m->{module} <- $m->{file}\n";
  }
  if ($cat eq 'fail' and @items) {
    print "FAILURE: One or more files failed to update:\n";
    exit(1);
  }
}

__END__

=head1 NAME package_assets.pl

=head1 USAGE

This script is intended to be run from the root of the repository as follows:

    bin/package_assets.pl

=head1 NOTES

This script packs javascript and CSS assets
