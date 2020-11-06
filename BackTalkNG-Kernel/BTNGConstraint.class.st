Class {
	#name : #BTNGConstraint,
	#superclass : #Object,
	#category : #'BackTalkNG-Kernel'
}

{ #category : #testing }
BTNGConstraint >> domainWipedOut [
	^ self variables anySatisfy: [:var| var domainWipedOut]
	
]

{ #category : #filtering }
BTNGConstraint >> enforceArcConsistency [
	self subclassResponsibility 
]

{ #category : #filtering }
BTNGConstraint >> filter [
	"A filter is a procedure used to remove some impossible affectations from the variables' domains"
	self enforceArcConsistency 
]

{ #category : #testing }
BTNGConstraint >> isConsistent [
	"A constraint is consistent when it is satisfied by the current variables' values"

	^ self subclassResponsibility
]

{ #category : #testing }
BTNGConstraint >> isInstantiated [
	self subclassResponsibility 
]

{ #category : #testing }
BTNGConstraint >> isNotConsistent [
	^ self isConsistent not
]

{ #category : #testing }
BTNGConstraint >> isSatisfied [
	"A constraint is satisfied when it is both instantiated and consistent"

	^ self isInstantiated and: [self isConsistent]
]

{ #category : #printing }
BTNGConstraint >> printAllVariablesOn: aStream [ 
	| varArray |
	aStream nextPutAll: ' ('.
	varArray := self variables asArray.
	varArray do: 
			[:var | 
			self printVariable: var on: aStream.
			var == varArray last ifFalse: [aStream nextPutAll: ', ']].
	aStream nextPut: $)
]

{ #category : #printing }
BTNGConstraint >> printDescriptionOn: aStream [
	aStream nextPutAll: self className
]

{ #category : #printing }
BTNGConstraint >> printOn: aStream [ 
	self printDescriptionOn: aStream.
	self printAllVariablesOn: aStream
]

{ #category : #printing }
BTNGConstraint >> printVariable: var on: aStream [ 
	var printLabelAndCurrentValueOn: aStream
]

{ #category : #accessing }
BTNGConstraint >> variables [ 
	^self subclassResponsibility 
]
