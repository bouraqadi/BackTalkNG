Class {
	#name : #BTNGAbstractBinaryConstraintTest,
	#superclass : #BTNGAbstractUnaryConstraintTest,
	#instVars : [
		'variable2'
	],
	#category : #'BackTalkNG-Constraints-Test'
}

{ #category : #'setUp-tearDown' }
BTNGAbstractBinaryConstraintTest >> createConstraint [
	^self constraintClass on: variable1 and: variable2
]

{ #category : #'setUp-tearDown' }
BTNGAbstractBinaryConstraintTest >> setUp [
	self setUpVariable2.
	super setUp.

]

{ #category : #'setUp-tearDown' }
BTNGAbstractBinaryConstraintTest >> setUpVariable2 [
	variable2 := BTNGVariable label: 'V2' from: 0 to: 10
]
