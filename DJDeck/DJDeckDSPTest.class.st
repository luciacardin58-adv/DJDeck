Class {
	#name : 'DJDeckDSPTest',
	#superclass : 'TestCase',
	#instVars : [
		'deckDsp',
		'otherDeck'
	],
	#category : 'DJDeck-Tests',
	#package : 'DJDeck',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
DJDeckDSPTest >> expectedParameters [
	"The full address surface of one deck. A forgotten label: send shows up
	 here before it shows up as two decks fighting over one knob."

	^ #( 'Speed' 'ULevel' 'LowLevel' 'LowFreq' 'HighLevel' 'HighFreq'
	     'MidLfx' 'MidFx' 'MidB' 'LowPassFrequency' 'LowPassQ'
	     'HiPassFrequency' 'HiPassQ' )
]

{ #category : 'running' }
DJDeckDSPTest >> setUp [

	super setUp.
	deckDsp := DJDeck onDeck: #A fromFilePath:  FileLocator imageDirectory asAbsolute pathString , '/TurboSamples/blip/LAZ_R900.wav'
]

{ #category : 'running' }
DJDeckDSPTest >> tearDown [

	deckDsp ifNotNil: [ deckDsp dsp ifNotNil: [ :each | each destroy ] ].
	otherDeck ifNotNil: [ otherDeck dsp ifNotNil: [ :each | each destroy ] ].
	super tearDown
]

{ #category : 'tests' }
DJDeckDSPTest >> testDeckParametersDoNotCollide [

	| a b |
	a := (DJDeck onDeck: #A fromFilePath: self testFilePath) dsp.
	b := (DJDeck onDeck: #B fromFilePath: self testFilePath) dsp.
	a init.
	b init.
	self assert: (a allParameters intersection: b allParameters) isEmpty.
	self
		assert: (a allParameters collect: [ :each | each allButFirst: 5 ]) asSet
		equals: (b allParameters collect: [ :each | each allButFirst: 5 ]) asSet
]

{ #category : 'tests' }
DJDeckDSPTest >> testPrefix [

self assert: deckDsp prefix equals: 'DeckA'
]

{ #category : 'as yet unclassified' }
DJDeckDSPTest >> testUnknownDeckIdRaises [

	self
		should: [ DJDeck onDeck: #C fromFilePath: self samplePath ]
		raise: Error
]
