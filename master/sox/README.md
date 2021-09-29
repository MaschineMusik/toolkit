# Sox

http://sox.sourceforge.net/sox.html

http://sox.sourceforge.net/Docs/Documentation

## Compand

From http://manpages.ubuntu.com/manpages/bionic/man1/sox.1.html

    compand attack1,decay1{,attack2,decay2}
            [soft-knee-dB:]in-dB1[,out-dB1]{,in-dB2,out-dB2}
            [gain [initial-volume-dB [delay]]]

       Compand (compress or expand) the dynamic range of the audio.

       The  attack  and  decay  parameters  (in seconds) determine the time over which the
       instantaneous level of the input  signal  is  averaged  to  determine  its  volume;
       attacks  refer  to  increases  in  volume  and decays refer to decreases.  For most
       situations, the attack time (response  to  the  music  getting  louder)  should  be
       shorter  than the decay time because the human ear is more sensitive to sudden loud
       music than sudden soft music.  Where more than one pair of attack/decay  parameters
       are  specified,  each input channel is companded separately and the number of pairs
       must agree with the number of input channels.  Typical values are 0.3,0.8 seconds.

       The second parameter is a list of  points  on  the  compander's  transfer  function
       specified  in  dB  relative  to  the  maximum possible signal amplitude.  The input
       values must be in a strictly increasing order but the transfer  function  does  not
       have  to be monotonically rising.  If omitted, the value of out-dB1 defaults to the
       same value as in-dB1; levels below in-dB1 are not  companded  (but  may  have  gain
       applied  to  them).  The point 0,0 is assumed but may be overridden (by 0,out-dBn).
       If the list is preceded by a soft-knee-dB value, then the points at where  adjacent
       line  segments  on  the transfer function meet will be rounded by the amount given.
       Typical values for the transfer function are 6:-70,-60,-20.

       The third (optional) parameter is an additional gain in dB to  be  applied  at  all
       points on the transfer function and allows easy adjustment of the overall gain.

       The  fourth (optional) parameter is an initial level to be assumed for each channel
       when companding starts.  This permits the user to supply a nominal level initially,
       so  that,  for  example,  a very large gain is not applied to initial signal levels
       before the companding action has begun to operate: it is  quite  probable  that  in
       such  an  event,  the  output  would  be  severely clipped while the compander gain
       properly adjusts itself.  A typical value (for audio which is initially  quiet)  is
       -90 dB.

       The fifth (optional) parameter is a delay in seconds.  The input signal is analysed
       immediately to control the compander, but it is delayed before  being  fed  to  the
       volume  adjuster.  Specifying a delay approximately equal to the attack/decay times
       allows the compander to  effectively  operate  in  a  `predictive'  rather  than  a
       reactive mode.  A typical value is 0.2 seconds.

                                       *        *        *

       The  following  example  might be used to make a piece of music with both quiet and
       loud passages suitable for listening to in a noisy environment  such  as  a  moving
       vehicle:

          sox asz.wav asz-car.wav compand 0.3,1 6:-70,-60,-20 -5 -90 0.2

       The  transfer  function (`6:-70,...') says that very soft sounds (below -70dB) will
       remain unchanged.  This will  stop  the  compander  from  boosting  the  volume  on
       `silent' passages such as between movements.  However, sounds in the range -60dB to
       0dB (maximum volume) will be boosted so that the 60dB dynamic range of the original
       music  will  be  compressed 3-to-1 into a 20dB range, which is wide enough to enjoy
       the music but narrow enough to get around the road noise.   The  `6:'  selects  6dB
       soft-knee  companding.   The  -5  (dB) output gain is needed to avoid clipping (the
       number is inexact, and was derived by  experimentation).   The  -90  (dB)  for  the
       initial  volume  will  work  fine for a clip that starts with near silence, and the
       delay of 0.2 (seconds) has the effect of causing the compander to react a bit  more
       quickly to sudden volume changes.

       In the next example, compand is being used as a noise-gate for when the noise is at
       a lower level than the signal:

          play infile compand .1,.2 -inf,-50.1,-inf,-50,-50 0 -90 .1

       Here is another noise-gate, this time for when the noise is at a higher level  than
       the signal (making it, in some ways, similar to squelch):

          play infile compand .1,.1 -45.1,-45,-inf,0,-inf 45 -90 .1
          
       This effect supports the --plot global option (for the transfer function).

       See also mcompand for a multiple-band companding effect.

