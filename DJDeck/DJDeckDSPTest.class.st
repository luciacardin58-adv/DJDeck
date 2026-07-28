Class {
	#name : 'DJDeckDSPTest',
	#superclass : 'TestCase',
	#instVars : [
		'deckDsp'
	],
	#category : 'DJDeck-Tests',
	#package : 'DJDeck',
	#tag : 'Tests'
}

{ #category : 'running' }
DJDeckDSPTest >> setUp [

	super setUp.
	deckDsp := DJDeckDsp onDeck: #A fromFilePath:  FileLocator imageDirectory asAbsolute pathString , '/TurboSamples/blip/LAZ_R900.wav'
]

{ #category : 'tests' }
DJDeckDSPTest >> testPrefix [

self assert: deckDsp prefix equals: 'DeckA'
]
