#! /usr/local/bin/perl

package Recursion;

use strict;
use warnings; 
no warnings 'recursion';
use Sub::Fallback qw(fallback);

$Sub::Fallback::DEBUG = 1;

my $i;

init();

sub init {
    $i = 0;
    increase();
}

sub increase {
    print ++$i,"\n";
    loop();
}
    
sub loop { 
    fallback(0)       if $i == 20;
    fallback(1,1);
}
