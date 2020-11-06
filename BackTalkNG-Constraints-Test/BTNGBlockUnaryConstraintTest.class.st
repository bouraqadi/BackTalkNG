Class {
	#name : #BTNGBlockUnaryConstraintTest,
	#superclass : #BTNGAbstractUnaryConstraintTest,
	#category : #'BackTalkNG-Constraints-Test'
}

{ #category : #'setUp-tearDown' }
BTNGBlockUnaryConstraintTest >> constraintClass [
	^BTNGBlockUnaryConstraint 
]

{ #category : #'setUp-tearDown' }
BTNGBlockUnaryConstraintTest >> createConstraint [
	^ self constraintClass
		on: variable1
		block: [:value | value > 5]
]

{ #category : #running }
BTNGBlockUnaryConstraintTest >> testArcConsistency [
	constraint enforceArcConsistency.
	self assert: variable1 valuesToExplore asSet = (6 to: 10) asSet.
	self assert: constraint isConsistent
]
