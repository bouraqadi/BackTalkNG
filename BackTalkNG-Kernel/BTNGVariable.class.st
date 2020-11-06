Class {
	#name : #BTNGVariable,
	#superclass : #Object,
	#instVars : [
		'constraints',
		'label',
		'domain',
		'valuesToExplore',
		'currentValue'
	],
	#category : #'BackTalkNG-Kernel'
}

{ #category : #'instance creation' }
BTNGVariable class >> label: aString domain: aCollection [ 
	^self new
		label: aString domain: aCollection;
		yourself
]

{ #category : #'instance creation' }
BTNGVariable class >> label: aString from: lowerBound to: upperBound [ 
	^self
		label: aString
		domain: (lowerBound to: upperBound)

]

{ #category : #constrainting }
BTNGVariable >> addConstraint: aBTNGConstraint [ 
	self constraints add: aBTNGConstraint
]

{ #category : #accessing }
BTNGVariable >> constraints [
	^ constraints
]

{ #category : #accessing }
BTNGVariable >> constraints: aCollection [
	constraints := aCollection asSet
]

{ #category : #accessing }
BTNGVariable >> currentValue [
	^currentValue
]

{ #category : #enumerating }
BTNGVariable >> currentValue: newValue [ 
	currentValue := newValue
]

{ #category : #accessing }
BTNGVariable >> domain [
	^ domain
]

{ #category : #accessing }
BTNGVariable >> domain: aCollection [ 
	domain := aCollection asSet copy.
	self valuesToExplore: aCollection
]

{ #category : #testing }
BTNGVariable >> domainWipedOut [
	^ self valuesToExplore isEmpty
]

{ #category : #filtering }
BTNGVariable >> filterToReject: aBlock [ 
	| newReducedDomain |
	newReducedDomain := self valuesToExplore reject: aBlock.
	self valuesToExplore: newReducedDomain
]

{ #category : #filtering }
BTNGVariable >> filterToSelect: aBlock [ 
	| newReducedDomain |
	newReducedDomain := self valuesToExplore select: aBlock.
	self valuesToExplore: newReducedDomain
]

{ #category : #initialize }
BTNGVariable >> initialize [
	super initialize.
	self constraints: Set new.
	self valuesToExplore: Set new
]

{ #category : #testing }
BTNGVariable >> isInstantiated [
	^ self currentValue notNil
]

{ #category : #accessing }
BTNGVariable >> label [
	^ label
]

{ #category : #accessing }
BTNGVariable >> label: aByteString [ 
	label := aByteString 
]

{ #category : #initialize }
BTNGVariable >> label: aString domain: aCollection [ 
	self label: aString.
	self domain: aCollection
]

{ #category : #enumerating }
BTNGVariable >> nextValue [
	| nextValue |
	self currentValue
		ifNotNil: [valuesToExplore remove: self currentValue].
	nextValue := self valuesToExplore
		ifEmpty: [ nil ]
		ifNotEmpty: [self valuesToExplore anyOne].
	self currentValue: nextValue.
	^ nextValue
]

{ #category : #printing }
BTNGVariable >> printLabelAndCurrentValueOn: aStream [ 
	aStream
		nextPutAll: self label;
		nextPutAll: ' = '.
	self currentValue printOn: aStream
]

{ #category : #printing }
BTNGVariable >> printOn: aStream [ 
	self printLabelAndCurrentValueOn: aStream.
	self printValuesToExploreOn: aStream
]

{ #category : #printing }
BTNGVariable >> printValue: each on: aStream [ 
	each printOn: aStream
]

{ #category : #printing }
BTNGVariable >> printValuesToExploreOn: aStream [ 
	| valuesArray |
	aStream nextPutAll: ' {'.
	valuesArray := self valuesToExplore asArray.
	valuesArray do: 
			[:each | 
			self printValue: each on: aStream.
			each == valuesArray last ifFalse: [aStream nextPutAll: '. ']].
	aStream nextPut: $}
]

{ #category : #constrainting }
BTNGVariable >> removeConstraint: aBTNGConstraint [ 
	self constraints remove: aBTNGConstraint ifAbsent: []
]

{ #category : #initialize }
BTNGVariable >> reset [
	self valuesToExplore: self domain.
	self resetCurrentValue
]

{ #category : #enumerating }
BTNGVariable >> resetCurrentValue [
	self currentValue: nil
]

{ #category : #accessing }
BTNGVariable >> valuesToExplore [
	^valuesToExplore copy
]

{ #category : #filtering }
BTNGVariable >> valuesToExplore: aCollection [ 
	valuesToExplore := aCollection asSet copy.
	valuesToExplore ifEmpty: [self resetCurrentValue]
]
