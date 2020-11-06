Class {
	#name : #BTNGBinaryConstraint,
	#superclass : #BTNGConstraint,
	#instVars : [
		'variableA',
		'variableB'
	],
	#category : #'BackTalkNG-Kernel'
}

{ #category : #'instance creation' }
BTNGBinaryConstraint class >> on: var1 and: var2 [
	^self new
		variableA: var1;
		variableB: var2;
		yourself
]

{ #category : #testing }
BTNGBinaryConstraint >> domainWipedOut [
	^self variableA domainWipedOut or: [self variableB domainWipedOut]
]

{ #category : #testing }
BTNGBinaryConstraint >> isInstantiated [
	"A constraint is instantiated when all the variables are instantiated"
	| isInstantiated |
	isInstantiated := {variableA. variableB}
				allSatisfy: [:x | x isInstantiated].
	^ isInstantiated
]

{ #category : #accessing }
BTNGBinaryConstraint >> valuesToExploreA [
	^ self variableA valuesToExplore
]

{ #category : #accessing }
BTNGBinaryConstraint >> valuesToExploreB [
	^ self variableB valuesToExplore
]

{ #category : #accessing }
BTNGBinaryConstraint >> variableA [
	^variableA
]

{ #category : #accessing }
BTNGBinaryConstraint >> variableA: anObject [
	self variableA ifNotNil: [self variableA removeConstraint: self].
	variableA := anObject.
	self variableA addConstraint: self
]

{ #category : #accessing }
BTNGBinaryConstraint >> variableB [
	^variableB
]

{ #category : #accessing }
BTNGBinaryConstraint >> variableB: anObject [
	self variableB ifNotNil: [self variableB removeConstraint: self].
	variableB := anObject.
	self variableB addConstraint: self
]

{ #category : #accessing }
BTNGBinaryConstraint >> variables [
	^Set with: self variableA with: self variableB
]
