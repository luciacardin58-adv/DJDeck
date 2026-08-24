"
I represent one DJ deck's audio signal chain: a player nested inside an EQ (low and high shelving), nested inside a filter (highpass). Signal flows player -> EQ -> filter.

I must be assigned to a deck and initialized from a path to a sound file. Neither is optional — a deck identity gives my parameters their scope, and a path gives me something to play.

Usage:
    DJDeckDsp deck: #a fromPath: '/path/to/track.wav'
"
Class {
	#name : 'DJDeckDsp',
	#superclass : 'Object',
	#instVars : [
		'deckId',
		'lowShelf',
		'highShelf',
		'midPeak',
		'lowCut',
		'highCut',
		'player',
		'filePath'
	],
	#category : 'DJDeck-DSP',
	#package : 'DJDeck',
	#tag : 'DSP'
}

{ #category : 'instance creation' }
DJDeckDsp class >> new [ 
^ self error: 'Use DJDeckDsp deck: #A fromFilePath: aPath'
]

{ #category : 'instance creation' }
DJDeckDsp class >> onDeck: aSymbol fromFilePath: aPath [

	(#( #A #B ) includes: aSymbol) ifFalse: [
		^ self error: 'deck: must be #A or #B, got ' , aSymbol printString ].
	^ self basicNew
		  onDeck: aSymbol fromFilePath: aPath
]

{ #category : 'accessing' }
DJDeckDsp >> highCut [ 

^ highCut 
]

{ #category : 'accessing' }
DJDeckDsp >> highShelf [ 

^ highShelf
]

{ #category : 'initialization' }
DJDeckDsp >> initializeEQs [

	lowShelf := PhLowShelf new.
	highShelf := PhHighShelf new.
	midPeak := PhPeakEq new.
]

{ #category : 'initialization' }
DJDeckDsp >> initializeFilters [

	lowCut := PhResonLp new.
	highCut := PhResonHp new.
]

{ #category : 'initialization' }
DJDeckDsp >> initializePlayer [

player := DJPlayer new pathToFile: filePath ; label: self prefix 
]

{ #category : 'accessing' }
DJDeckDsp >> lowCut [ 
^ lowCut 
]

{ #category : 'accessing' }
DJDeckDsp >> lowShelf [ 
^ lowShelf 
]

{ #category : 'accessing' }
DJDeckDsp >> midPeak [ 

^ midPeak
]

{ #category : 'instance creation' }
DJDeckDsp >> onDeck: aSymbol fromFilePath: aFilePath [

	deckId := aSymbol.
	filePath := aFilePath.
	self initializePlayer.
	self initializeEQs .
	self initializeFilters .

	^ player => lowShelf => highShelf => midPeak => highCut => lowCut
		  asDspWithName: self prefix
]

{ #category : 'accessing' }
DJDeckDsp >> prefix [ 

^ 'Deck' , deckId asString
]
