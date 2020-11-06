Class {
	#name : #BTNGBlockBinaryConstraint,
	#superclass : #BTNGBinaryConstraint,
	#instVars : [
		'binaryBooleanBlock'
	],
	#category : #'BackTalkNG-Constraints'
}

{ #category : #'instance creation' }
BTNGBlockBinaryConstraint class >> on: variable1 and: variable2 block: binaryBlock [ 
	^ (self on: variable1 and: variable2) binaryBooleanBlock: binaryBlock;
		 yourself
]

{ #category : #accessing }
BTNGBlockBinaryConstraint >> binaryBooleanBlock [
	^binaryBooleanBlock
]

{ #category : #accessing }
BTNGBlockBinaryConstraint >> binaryBooleanBlock: anObject [
	binaryBooleanBlock := anObject
]

{ #category : #filtering }
BTNGBlockBinaryConstraint >> enforceArcConsistency [
	| previousSizeA sizeA previousSizeB sizeB |
	sizeA := self valuesToExploreA size.
	sizeB := self valuesToExploreB size.
	
	[self variableA filterToSelect: 
			[:a | 
			self valuesToExploreB 
				anySatisfy: [:b | self binaryBooleanBlock value: a value: b]].
	self variableB filterToSelect: 
			[:b | 
			self valuesToExploreA 
				anySatisfy: [:a | self binaryBooleanBlock value: a value: b]].
	previousSizeA := sizeA.
	sizeA := self valuesToExploreA size.
	previousSizeB := sizeB.
	sizeB := self valuesToExploreB size] 
			doWhileFalse: [previousSizeA = sizeA and: [previousSizeB = sizeB]]
]

{ #category : #testing }
BTNGBlockBinaryConstraint >> isConsistent [
	^ (self valuesToExploreA allSatisfy: 
			[:a | 
			self valuesToExploreB 
				anySatisfy: [:b | self binaryBooleanBlock value: a value: b]]) 
		and: 
			[self valuesToExploreB allSatisfy: 
					[:b | 
					self valuesToExploreA 
						anySatisfy: [:a | self binaryBooleanBlock value: a value: b]]]
]
