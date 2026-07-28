Class {
	#name : 'DJPlayerTest',
	#superclass : 'TestCase',
	#instVars : [
		'player'
	],
	#category : 'DJDeck-Tests',
	#package : 'DJDeck',
	#tag : 'Tests'
}

{ #category : 'running' }
DJPlayerTest >> setUp [

	super setUp.

	player := DJPlayer new pathToFile:  FileLocator imageDirectory asAbsolute pathString
			           , '/TurboSamples/blip/LAZ_R900.wav'
]

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

{ #category : 'tests' }
DJPlayerTest >> testDJPlayerAsDsp [

	self deny: player stereo asDsp isNull.
]
