Class {
	#name : 'DJCueReaderTest',
	#superclass : 'TestCase',
	#category : 'DJDeck-Tests',
	#package : 'DJDeck',
	#tag : 'Tests'
}

{ #category : 'tests' }
DJCueReaderTest >> testAsBoxBuilds [ 
    | box |
    box := (DJCueReader new cue: 500; speed: 1.5 asBox; yourself) asBox.
    self assert: (box isKindOf: PhBox)

]

{ #category : 'tests' }
DJCueReaderTest >> testDefaultsCueZeroSpeedOne [ 
    | reader |
    reader := DJCueReader new.
    self assert: reader cue equals: 0.
    self assert: reader speed equals: 1 asBox
]
