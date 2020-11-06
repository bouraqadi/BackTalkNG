Class {
	#name : #BTNGEqualityBinaryConstraintTest,
	#superclass : #BTNGAbstractBinaryConstraintTest,
	#category : #'BackTalkNG-Constraints-Test'
}

{ #category : #'setUp-tearDown' }
BTNGEqualityBinaryConstraintTest >> constraintClass [
	^BTNGEqualityConstraint 
]

{ #category : #running }
BTNGEqualityBinaryConstraintTest >> testArcConsistencyWithDifferentOverlappingDomains [
	| expectedReducedDomain |
	variable1
		domain: (3 to: 12).
	variable2
		domain: (0 to: 7).
	constraint enforceArcConsistency.
	expectedReducedDomain := (3 to: 7) asSet.
	self assert: variable1 valuesToExplore asSet = expectedReducedDomain.
	self assert: variable2 valuesToExplore asSet = expectedReducedDomain.
	self assert: constraint isConsistent	
]

{ #category : #running }
BTNGEqualityBinaryConstraintTest >> testArcConsistencyWithSameDomains [
	| expectedReducedDomain |
	constraint enforceArcConsistency.
	expectedReducedDomain := (0 to: 10) asSet.
	self assert: variable1 valuesToExplore asSet = expectedReducedDomain.
	self assert: variable2 valuesToExplore asSet = expectedReducedDomain.
	self assert: constraint isConsistent
]
