Class {
	#name : #BTNGAbstractUnaryConstraintTest,
	#superclass : #TestCase,
	#instVars : [
		'variable1',
		'constraint'
	],
	#category : #'BackTalkNG-Constraints-Test'
}

{ #category : #'setUp-tearDown' }
BTNGAbstractUnaryConstraintTest >> constraintClass [
	^self subclassResponsibility 
]

{ #category : #'setUp-tearDown' }
BTNGAbstractUnaryConstraintTest >> createConstraint [
	^self constraintClass on: variable1
]

{ #category : #'setUp-tearDown' }
BTNGAbstractUnaryConstraintTest >> setUp [
	super setUp.
	self setUpVariable1.
	self setUpConstraint
]

{ #category : #'setUp-tearDown' }
BTNGAbstractUnaryConstraintTest >> setUpConstraint [
	constraint := self createConstraint 
]

{ #category : #'setUp-tearDown' }
BTNGAbstractUnaryConstraintTest >> setUpVariable1 [
	variable1 := BTNGVariable label: 'V1' from: 0 to: 10
]
