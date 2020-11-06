Class {
	#name : #BTNGCSP,
	#superclass : #Object,
	#instVars : [
		'label',
		'variables'
	],
	#category : #'BackTalkNG-Kernel'
}

{ #category : #'instance creation' }
BTNGCSP class >> label: aString variables: aCollection [
	^self new
		label: aString variables: aCollection;
		yourself
]

{ #category : #accessing }
BTNGCSP >> addVariable: aVariable [
	self variables add: aVariable
]

{ #category : #accessing }
BTNGCSP >> constraints [
	| constraints |
	constraints := IdentitySet new.
	self variables do: [:var|
		constraints addAll: var constraints].
	^constraints
]

{ #category : #testing }
BTNGCSP >> domainWipedOut [
	^self variables anySatisfy: [:var| var domainWipedOut]
]

{ #category : #accessing }
BTNGCSP >> instantiatedConstraints [
	^ self constraints select: [:ct | ct isInstantiated]
]

{ #category : #accessing }
BTNGCSP >> label [
	^label
]

{ #category : #accessing }
BTNGCSP >> label: anObject [
	label := anObject
]

{ #category : #'initialize-release' }
BTNGCSP >> label: aString variables: aCollection [
	self label: aString.
	self variables: aCollection asSet
]

{ #category : #accessing }
BTNGCSP >> removeVariable: aVariable [
	self variables remove: aVariable ifAbsent: []
]

{ #category : #'initialize-release' }
BTNGCSP >> reset [
	self variables do: [:var| var reset]
]

{ #category : #accessing }
BTNGCSP >> variables [
	^variables
]

{ #category : #accessing }
BTNGCSP >> variables: aCollection [
	variables := aCollection asIdentitySet 
]
