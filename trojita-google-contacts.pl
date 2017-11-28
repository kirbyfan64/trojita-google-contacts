#!/usr/bin/env perl

open my $fc, '-|', 'goobook dump_contacts' or die $!;
open my $fo, '>', "@{[$ENV{'HOME'}]}/.abook/addressbook" or die $!;

my $name;
my $n = 0;

while (<$fc>) {
  s/ns[0-9]://g;

  $name = $1 if /<title>([^<]+)/;
  print $fo "[@{[$n++]}]\nname=@{[$name||$1]}\nemail=$1\n\n" if /<email address="([^"]+)/;
  $name=undef if /<\/entry>/;
}

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$year += 1900;
$mon += 1;

printf "Sync complete at %d-%02d-%02d %02d:%02d:%02d\n", $year, $mon, $mday, $hour, $min, $sec;
