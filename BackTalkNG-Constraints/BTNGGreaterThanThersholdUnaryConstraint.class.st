Class {
	#name : #BTNGGreaterThanThersholdUnaryConstraint,
	#superclass : #BTNGCompareToValueUnaryConstraint,
	#category : #'BackTalkNG-Constraints'
}

{ #category : #testing }
BTNGGreaterThanThersholdUnaryConstraint >> consistencyFor: value [ 
	^value > self valueForComparison
]
