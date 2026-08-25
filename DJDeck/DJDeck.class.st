"
I represent one DJ deck's audio signal chain: a player nested inside an EQ (low and high shelving), nested inside a filter (highpass). Signal flows player -> EQ -> filter.

I must be assigned to a deck and initialized from a path to a sound file. Neither is optional — a deck identity gives my parameters their scope, and a path gives me something to play.

Usage:
    DJDeckDsp deck: #a fromPath: '/path/to/track.wav'
"
Class {
	#name : 'DJDeck',
	#superclass : 'Object',
	#instVars : [
		'deckId',
		'lowShelf',
		'highShelf',
		'midPeak',
		'lowCut',
		'highCut',
		'player',
		'filePath',
		'dsp',
		'channelGain',
		'crossfadeGain',
		'isPlaying'
	],
	#category : 'DJDeck-DSP',
	#package : 'DJDeck',
	#tag : 'DSP'
}

{ #category : 'instance creation' }
DJDeck class >> new [ 
^ self error: 'Use DJDeckDsp deck: #A fromFilePath: aPath'
]

{ #category : 'instance creation' }
DJDeck class >> onDeck: aSymbol fromFilePath: aPath [

	(#( #A #B ) includes: aSymbol) ifFalse: [
		^ self error: 'onDeck: must be #A or #B, got ' , aSymbol printString ].
	^ self basicNew
		  onDeck: aSymbol fromFilePath: aPath;
		  yourself
]

{ #category : 'applying' }
DJDeck >> applyGain [

	dsp ifNil: [ ^ self ].
	dsp
		setValue: channelGain * crossfadeGain
		parameter: self prefix , 'ULevel'
]

{ #category : 'playing' }
DJDeck >> buildDsp [

	dsp := player => lowShelf => highShelf => midPeak => highCut => lowCut
		       asDspWithName: self prefix
]

{ #category : 'accessing' }
DJDeck >> channelGain: aNumber [

	channelGain := aNumber.
	self applyGain
]

{ #category : 'accessing' }
DJDeck >> crossfadeGain: aNumber [

	crossfadeGain := aNumber.
	self applyGain
]

{ #category : 'deleting' }
DJDeck >> destroy [

	dsp ifNotNil: [ dsp destroy ]
]

{ #category : 'accessing' }
DJDeck >> dsp [ 
^ dsp
]

{ #category : 'accessing' }
DJDeck >> highCut [ 

^ highCut 
]

{ #category : 'accessing' }
DJDeck >> highShelf [ 

^ highShelf
]

{ #category : 'initialization' }
DJDeck >> initialize [

	super initialize.
	isPlaying := false.
	channelGain := 1.
	crossfadeGain := 1
]

{ #category : 'initialization' }
DJDeck >> initializeEQs [

	lowShelf := PhLowShelf new label: self prefix , 'Low'.
	highShelf := PhHighShelf new label: self prefix , 'High'.
	midPeak := PhPeakEq new label: self prefix , 'Mid'
]

{ #category : 'initialization' }
DJDeck >> initializeFilters [

	lowCut := PhResonLp new label: self prefix , 'HiPass'.
	highCut := PhResonHp new label: self prefix , 'LowPass'.
	'LowPass'
]

{ #category : 'initialization' }
DJDeck >> initializePlayer [

player := DJPlayer new pathToFile: filePath ; label: self prefix 
]

{ #category : 'accessing' }
DJDeck >> lowCut [ 
^ lowCut 
]

{ #category : 'accessing' }
DJDeck >> lowShelf [ 
^ lowShelf 
]

{ #category : 'accessing' }
DJDeck >> midPeak [ 

^ midPeak
]

{ #category : 'instance creation' }
DJDeck >> onDeck: aSymbol fromFilePath: aFilePath [

	deckId := aSymbol.
	filePath := aFilePath.
	self initializePlayer.
	self initializeEQs.
	self initializeFilters.
  self buildDsp.
  self dsp init.
]

{ #category : 'playing' }
DJDeck >> pause [ 
dsp stop.
]

{ #category : 'playing' }
DJDeck >> play [ 
dsp start
]

{ #category : 'accessing' }
DJDeck >> prefix [ 

^ 'Deck' , deckId asString
]
