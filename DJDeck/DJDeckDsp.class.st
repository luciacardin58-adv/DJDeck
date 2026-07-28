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
		'deckName',
		'lowShelf',
		'highShelf',
		'midPeak'
	],
	#category : 'DJDeck-DSP',
	#package : 'DJDeck',
	#tag : 'DSP'
}

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

{ #category : 'accessing' }
DJDeckDsp >> lowShelf [ 
^ lowShelf 
]

{ #category : 'accessing' }
DJDeckDsp >> midPeak [ 

^ midPeak
]
