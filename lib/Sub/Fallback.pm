package Sub::Fallback;

$VERSION = '0.02';
@EXPORT_OK = qw(fallback);

use strict;
use vars qw($Debug $stack_frames);
use base qw(Exporter);
use Carp qw(carp croak);

$stack_frames = 0;

sub fallback {
    my $fallback = shift || 0;
    my $sec = shift;
    croak 'usage: fallback(stack frame, [sec])'
      if $sec && $sec !~ /\d/;
           
    while (caller($stack_frames)) { $stack_frames++ }    
    my $sub = (caller(--$stack_frames - $fallback))[3];
       
    sleep $sec if $sec;
    carp "falling back to $sub" if $Debug;       
    goto &$sub;
} 

1;
__END__

=head1 NAME

Sub::Fallback - Fall back to subs in stack

=head1 SYNOPSIS

 use Sub::Fallback qw(fallback);
 
 # do NOT use this code
 
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
     fallback(0) if $i == 20;    # falls back to init()
     fallback(1,1);              # falls back to increase() in 1 sec
 }

=head1 FUNCTIONS

=head2 fallback

Falls back to previously executed subs in stack frame.

 fallback(stack frame, [sec]);
 
Unlike perl's C<caller>, C<fallback()> takes an absolute integer as 
level indicator. 0 does always refer to the first stack frame.
C<fallback(0)> will thus fall back to the first sub within the stack. 
A sleep interval (sec) before falling back may be provided.

=head1 EXPORT

C<fallback()> is exportable.

=head1 CAVEATS

Speed may become an issue since a counter has to be incremented to
keep count of stack frames.

=head1 SEE ALSO

L<perlfunc/caller>

=cut
