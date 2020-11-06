Class {
	#name : #BTNGGreaterThanThresholdUnaryConstraint,
	#superclass : #BTNGCompareToValueUnaryConstraint,
	#category : #'BackTalkNG-Constraints'
}

{ #category : #testing }
BTNGGreaterThanThresholdUnaryConstraint >> consistencyFor: value [ 
	^value > self valueForComparison
]
