Class {
	#name : #BTNGContext,
	#superclass : #Object,
	#instVars : [
		'valuesToExploreDict',
		'currentVariable',
		'currentValuesDict'
	],
	#category : #'BackTalkNG-Kernel'
}

{ #category : #'instance-creation' }
BTNGContext class >> fromSolver: solver [ 
	^(self new) fromSolver: solver
]

{ #category : #accessing }
BTNGContext >> currentValueFor: aBTNGVariable [ 
	^ self currentValuesDict at: aBTNGVariable ifAbsent: [nil]
]

{ #category : #accessing }
BTNGContext >> currentValuesDict [
	^currentValuesDict
]

{ #category : #accessing }
BTNGContext >> currentValuesDict: anObject [
	currentValuesDict := anObject
]

{ #category : #accessing }
BTNGContext >> currentVariable [
	^currentVariable
]

{ #category : #accessing }
BTNGContext >> currentVariable: anObject [
	currentVariable := anObject
]

{ #category : #initialize }
BTNGContext >> fromSolver: solver [ 
	self
		valuesToExploreDict: (Dictionary new: solver variables size);
		
		currentValuesDict: (Dictionary new: solver variables size).
	solver variables
		do: [:var | 
			self valuesToExploreDict at: var put: var valuesToExplore copy.
			var isInstantiated
				ifTrue: [self currentValuesDict at: var put: var currentValue]].
	self currentVariable: solver currentVariable
]

{ #category : #restoring }
BTNGContext >> restoreInSolver: aSolver [ 
	self valuesToExploreDict
		keysAndValuesDo: [:variable :storedValuesToExplore | variable valuesToExplore: storedValuesToExplore].
	self currentValuesDict
		keysAndValuesDo: [:variable :storedValue | variable currentValue: storedValue].
	aSolver currentVariable: self currentVariable
]

{ #category : #accessing }
BTNGContext >> valuesToExploreDict [
	^valuesToExploreDict
]

{ #category : #accessing }
BTNGContext >> valuesToExploreDict: anObject [
	valuesToExploreDict := anObject
]

{ #category : #accessing }
BTNGContext >> valuesToExploreFor: aBTNGVariable [ 
	^self valuesToExploreDict at: aBTNGVariable
]
