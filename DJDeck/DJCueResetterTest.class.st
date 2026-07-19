Class {
	#name : 'DJCueResetterTest',
	#superclass : 'TestCase',
	#category : 'DJDeck-Tests',
	#package : 'DJDeck',
	#tag : 'Tests'
}

{ #category : 'tests' }
DJCueResetterTest >> testAsBoxBuilds [ 
    | box |
    box := (DJCueResetter new cue: 1000 asBox) asBox.
    self assert: (box isKindOf: PhBox)
]

{ #category : 'tests' }
DJCueResetterTest >> testDefaultCueIsZero [ 
    self assert: DJCueResetter new cue  equals: 0 
]
