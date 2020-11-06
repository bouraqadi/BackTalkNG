Class {
	#name : #BTNGEqualityConstraint,
	#superclass : #BTNGBinaryConstraint,
	#category : #'BackTalkNG-Constraints'
}

{ #category : #filtering }
BTNGEqualityConstraint >> enforceArcConsistency [
	| intersection |
	intersection := self valuesToExploreA intersection: self valuesToExploreB.
	self variableA valuesToExplore: intersection.
	self variableB valuesToExplore: intersection
]

{ #category : #testing }
BTNGEqualityConstraint >> isConsistent [
	^ variableA currentValue = variableB currentValue
]
