Class {
	#name : #BTNGUnaryConstraint,
	#superclass : #BTNGConstraint,
	#instVars : [
		'variable'
	],
	#category : #'BackTalkNG-Kernel'
}

{ #category : #'instance creation' }
BTNGUnaryConstraint class >> on: var [
	^ self new variable: var;
		 yourself
]

{ #category : #testing }
BTNGUnaryConstraint >> domainWipedOut [
	^self variable domainWipedOut
]

{ #category : #testing }
BTNGUnaryConstraint >> isInstantiated [
	"A constraint is instantiated when all the variables are instantiated"
	^variable isInstantiated
]

{ #category : #accessing }
BTNGUnaryConstraint >> valuesToExplore [
	^ self variable valuesToExplore
]

{ #category : #accessing }
BTNGUnaryConstraint >> variable [
	^ variable
]

{ #category : #accessing }
BTNGUnaryConstraint >> variable: anObject [ 
	self variable
		ifNotNil: [self variable removeConstraint: self].
	variable := anObject.
	self variable addConstraint: self
]

{ #category : #accessing }
BTNGUnaryConstraint >> variables [
	^ Set with: self variable 
]
