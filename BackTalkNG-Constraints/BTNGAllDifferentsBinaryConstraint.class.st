Class {
	#name : #BTNGAllDifferentsBinaryConstraint,
	#superclass : #BTNGBinaryConstraint,
	#category : #'BackTalkNG-Constraints'
}

{ #category : #filtering }
BTNGAllDifferentsBinaryConstraint >> enforceArcConsistency [
	(self valuesToExploreA size > 1 and: [self valuesToExploreB size > 1]) 
		ifTrue: [^ self].
	self valuesToExploreA isEmpty 
		ifTrue: [^ self variableB valuesToExplore: #()].
	self valuesToExploreB isEmpty 
		ifTrue: [^ self variableA valuesToExplore: #()].
	self variableB 
		filterToReject: [:value | (self valuesToExploreA copyWithout: value) isEmpty].
	self variableA 
		filterToReject: [:value | (self valuesToExploreB copyWithout: value) isEmpty]
]

{ #category : #testing }
BTNGAllDifferentsBinaryConstraint >> isConsistent [
	^ (self valuesToExploreA 
		noneSatisfy: [:value | (self valuesToExploreB copyWithout: value) isEmpty]) 
			and: 
				[self valuesToExploreB 
					noneSatisfy: [:value | (self valuesToExploreA copyWithout: value) isEmpty]]
]
