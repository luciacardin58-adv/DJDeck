"
I am DJCueReader. I read an audio buffer at a given speed, starting from
a cue point.

I subclass PhReaderWithSpeed, which builds a speed-driven accumulator
(a phasor) that resets to 0 on trigger. I keep the same speed behaviour
but swap in a DJCueResetter, so on trigger my read position restarts at
a settable sample offset (cue) instead of the file start. This is what
lets the needle drop anywhere in a track.

Speed is inherited unchanged: 1 = normal, 0 = hold position,
negative = read backward.

Collaborators:
**- DJCueResetter :** resets my accumulator to my cue value on trigger.
**- DJPlayer :** sets my cue, speed, and trigger, and reads my output as
  its read index.
**- Phausto :** (PhReaderWithSpeed, PhBox, Wire) — the DSP primitives.
"
Class {
	#name : 'DJCueReader',
	#superclass : 'Object',
	#category : 'DJDeck',
	#package : 'DJDeck'
}
