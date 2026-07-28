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
	deckDsp := DJDeckDsp onDeck: #A fromFilePath: 'dummyTestPath'
]

{ #category : 'tests' }
DJDeckDSPTest >> testPrefix [

self assert: deckDsp prefix equals: 'DeckA'
]
