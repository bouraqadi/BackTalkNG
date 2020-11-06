Class {
	#name : #BTNGCompareToValueUnaryConstraint,
	#superclass : #BTNGUnaryConstraint,
	#instVars : [
		'valueForComparison'
	],
	#category : #'BackTalkNG-Constraints'
}

{ #category : #testing }
BTNGCompareToValueUnaryConstraint >> consistencyFor: value [
	self subclassResponsibility 
]

{ #category : #filtering }
BTNGCompareToValueUnaryConstraint >> enforceArcConsistency [
	self variable filterToSelect: [:value | self consistencyFor: value]
]

{ #category : #testing }
BTNGCompareToValueUnaryConstraint >> isConsistent [
	^ self valuesToExplore allSatisfy: [:value | self consistencyFor: value]
]

{ #category : #accessing }
BTNGCompareToValueUnaryConstraint >> valueForComparison [
	^valueForComparison
]

{ #category : #accessing }
BTNGCompareToValueUnaryConstraint >> valueForComparison: anObject [
	valueForComparison := anObject
]
