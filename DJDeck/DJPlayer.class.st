"
I am DJPlayer, a single-file audio player modelled on a turntable.

I subclass TpSampler and replace its reader with a DJCueReader so the
read position can be cued to an arbitrary sample offset, not just reset
to zero. This lets me drop the needle anywhere in a track.

I expose turntable controls:

**- speed:**  a playback multiplier (1.0 = normal, negative = reverse).
          Pause by setting it to 0.
**- cue:**    a start offset in samples; on trigger, playback begins there.

I read sample-rate metadata from a DJAudioFileInfo (DJAudio-Formats), so
cue points can be given in seconds via #cueAtSeconds: and converted to
samples internally.

### Collaborators:
- DJCueReader / DJCueResetter : seekable read index built on Phausto.
- DJAudioFileInfo :sample rate and duration for seconds<->samples.
- Phausto (TpSampler, PhBox) : the DSP graph.
"
Class {
	#name : 'DJPlayer',
	#superclass : 'TpSampler',
	#instVars : [
		'speed',
		'fileInfo',
		'lengthInframes',
		'fileRate',
		'cue',
		'lengthInFrames'
	],
	#category : 'DJDeck',
	#package : 'DJDeck'
}

{ #category : 'converting' }
DJPlayer >> asBox [

	| reader sp output sampler partNumber step  engineRate readerIndx |
	partNumber := self index asBox min: self numberOfSamples asBox.
	engineRate := 48000 asBox.



	step := 1 asBox + (self speed asBox / 100 asBox) * fileRate
	        / engineRate.

	reader := PhInterpolateRaiseModulo new
		          trig: 1 asBox;
		          step: step;
		          length: fileInfo lengthInSamples asBox.
	"we need the reader left output"
	readerIndx := reader asBox connectTo: Wire new asBox , Cut new asBox.

	sp := BoxAPI uniqueInstance
		      boxSoundFile: filesURL
		      numChannels: self numChannels asBox
		      part: partNumber
		      readIndex: readerIndx asBox.

	output := Cut new asBox , Cut new asBox , Cut new asBox
	          , Wire new asBox.
	sampler := sp connectTo: output asBox.
	^ (sampler asBox * self uLevel) asBox
]

{ #category : 'accessing' }
DJPlayer >> cue [ 
^ cue
]

{ #category : 'accessing' }
DJPlayer >> cue: aSampleOffset [

	cue := aSampleOffset 
]

{ #category : 'helpers' }
DJPlayer >> cueAtSeconds: aNumber [ 
    fileInfo ifNil: [ ^ self inform: 'No fileInfo set' ].
    self cue: (aNumber * fileInfo sampleRate) rounded

]

{ #category : 'accessing' }
DJPlayer >> fileInfo [ 
^ fileInfo
]

{ #category : 'accessing' }
DJPlayer >> fileInfo: aDJAudioFileInfo [ 
    fileInfo := aDJAudioFileInfo
]

{ #category : 'accessing' }
DJPlayer >> fileRate [

	^ fileRate
]

{ #category : 'initialization' }
DJPlayer >> initialize [ 
super initialize.
	cue := 0.
	lengthInFrames := 11963520.
	speed := PhHSlider new
		         label: self coypuLabel , 'Speed'
		         init: 0
		         min: -8
		         max: 8
		         step: 0.001.
	index := 0 asConst

]

{ #category : 'accessing' }
DJPlayer >> lengthInFrames [

	^ lengthInFrames
]

{ #category : 'accessing' }
DJPlayer >> pathToFile: anAudioFilePath [

	super pathToFile: anAudioFilePath.
	fileInfo := DJWavAudioFormat new readInfoFrom:
		            self pathToFile asFileReference.
	lengthInframes := fileInfo numberOfSamples.
	fileRate := fileInfo sampleRate
]

{ #category : 'accessing' }
DJPlayer >> speed [ 
^ speed
]
