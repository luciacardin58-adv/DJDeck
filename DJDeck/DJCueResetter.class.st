"
I am DJCueResetter. I reset a reader's read position to a cue point.

I subclass PhResetter, which forces its accumulator back to 0 when
triggered. I override that so the reset target is a settable sample
offset (cue) instead of zero: on trigger, I emit my cue value, letting
a reader restart from an arbitrary position rather than the file start.

I do this by feeding my cue as input1 of the one-sample select2 that
PhResetter uses, in place of the hardwired 0.

Collaborators:
**- DJCueReader:** feeds me its trigger and reads my output as its
  reset position.
**- Phausto **(PhResetter, PhBox, AREnv, BoxAPI) — the DSP primitives.
"
Class {
	#name : 'DJCueResetter',
	#superclass : 'PhResetter',
	#instVars : [
		'cue'
	],
	#category : 'DJDeck',
	#package : 'DJDeck'
}

{ #category : 'converting' }
DJCueResetter >> asBox [ 
    | oneSampleTrig samp |
    samp := (1 / 48000) asFloat asBox.
    oneSampleTrig := (AREnv new
        attack: samp;
        release: samp;
        trigger: self trigger asBox) asBox.
    ^ BoxAPI uniqueInstance
        boxSelect2Aux: oneSampleTrig
        input0: Wire new asBox
        input1: self cue asBox
]

{ #category : 'accessing' }
DJCueResetter >> cue [ 
^ cue
]

{ #category : 'accessing' }
DJCueResetter >> cue: aSampleOffset [ 
    cue := aSampleOffset asBox
]

{ #category : 'initialization' }
DJCueResetter >> initialize [ 
    super initialize.
    cue := 0 asBox

]
