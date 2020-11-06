Class {
	#name : #BTNGBlockUnaryConstraint,
	#superclass : #BTNGUnaryConstraint,
	#instVars : [
		'unaryBooleanBlock'
	],
	#category : #'BackTalkNG-Constraints'
}

{ #category : #'instance creation' }
BTNGBlockUnaryConstraint class >> on: aBTNGVariable block: unaryBlock [
	^self new
		variable: aBTNGVariable;
		unaryBooleanBlock: unaryBlock;
		yourself
]

{ #category : #filtering }
BTNGBlockUnaryConstraint >> enforceArcConsistency [
	self variable 
		filterToSelect: [:value | self unaryBooleanBlock value: value]
]

{ #category : #testing }
BTNGBlockUnaryConstraint >> isConsistent [
	^ self valuesToExplore 
		allSatisfy: [:value | self unaryBooleanBlock value: value]
]

{ #category : #accessing }
BTNGBlockUnaryConstraint >> unaryBooleanBlock [
	^unaryBooleanBlock
]

{ #category : #accessing }
BTNGBlockUnaryConstraint >> unaryBooleanBlock: anObject [
	unaryBooleanBlock := anObject
]
