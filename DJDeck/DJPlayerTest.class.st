Class {
	#name : 'DJPlayerTest',
	#superclass : 'TestCase',
	#category : 'DJDeck-Tests',
	#package : 'DJDeck',
	#tag : 'Tests'
}

{ #category : 'tests' }
DJPlayerTest >> testCueAtSecondsConvertsToSamples [ 
    | player |
    player := DJPlayer new
        fileInfo: (DJAudioFileInfo new sampleRate: 44100; yourself).
    player cueAtSeconds: 2.
    self assert: player cue equals: 88200
]

{ #category : 'tests' }
DJPlayerTest >> testCueAtSecondsWithoutFileInfoRaises [ 
    self should: [ DJPlayer new cueAtSeconds: 2 ] raise: Error
]
