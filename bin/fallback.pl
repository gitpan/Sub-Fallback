#!/usr/bin/perl

package Recursion;

use strict;
use warnings; 
no warnings 'recursion';

use Sub::Fallback qw(fallback);

$Sub::Fallback::Debug = 1;

our $i;

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
    fallback(0) if $i == 20;
    fallback(1,1);
}
