# $Id: Fallback.pm,v 0.01 2004/01/21 14:27:14 sts Exp $

package Sub::Fallback;

use 5.006;
use base qw(Exporter);
use strict;
use warnings;
no warnings 'recursion';

our $VERSION = '0.01';

our @EXPORT_OK = qw(fallback);

our ($Debug, $stack_frames);

$stack_frames = 0;

sub carp {
    require Carp;
    &Carp::carp;
}

sub croak {
    require Carp;
    &Carp::croak;
}

sub fallback {
    my $fallback = $_[0] || 0;
    my $sec = $_[1];
    croak q~usage: fallback (stack frame, [sec])~
      if $sec && $sec !~ /\d/;
      
    while (caller($stack_frames)) { $stack_frames++ }
    
    my $sub = (caller(--$stack_frames - $fallback))[3];
    
    sleep $sec if $sec;
    carp qq~falling back to $sub~ if $Debug; 
    
    goto &{$sub};
} 

1;
__END__

=head1 NAME

Sub::Fallback - fall back to subs in stack frame.

=head1 SYNOPSIS

 use Sub::Fallback q(fallback);
 
 # do NOT use this code
 
 sub init {
     $i = 0;
     increase();
 }

 sub increase {
     print ++$i,"\n";
     loop();
 }
    
 sub loop { 
     fallback(0) if $i == 20;    # falls back to init()
     fallback(1, 1);             # falls back to increase() in 1 sec
 }

=head1 FUNCTIONS

=head2 fallback

Falls back to previously executed subs in stack frame.

 fallback (stack frame, [sec]);
 
Unlike perl's caller, C<fallback()> takes an absolute integer as 
level indicator. 0 does always refer to the first stack frame.
C<fallback(0)> will thus fall back to the first executed sub. A 
sleep interval (sec) before falling back may be provided.

=head1 EXPORT

C<fallback()> is exportable.

=head1 CAVEATS

Speed may become an issue since a counter has to be incremented to
keep count of stack frames.

=cut
