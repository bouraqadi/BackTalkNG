Class {
	#name : #BTNGAllDifferentsBinaryConstraintTest,
	#superclass : #BTNGAbstractBinaryConstraintTest,
	#category : #'BackTalkNG-Constraints-Test'
}

{ #category : #'setUp-tearDown' }
BTNGAllDifferentsBinaryConstraintTest >> constraintClass [
	^ BTNGAllDifferentsBinaryConstraint
]

{ #category : #running }
BTNGAllDifferentsBinaryConstraintTest >> testArcConsistencyWithFullDomains [
	| expectedReducedDomain |
	constraint enforceArcConsistency.
	expectedReducedDomain := (0 to: 10) asSet.
	self assert: variable1 valuesToExplore asSet equals: expectedReducedDomain.
	self assert: variable2 valuesToExplore asSet equals: expectedReducedDomain.
	self assert: constraint isConsistent 
]

{ #category : #running }
BTNGAllDifferentsBinaryConstraintTest >> testArcConsistencyWithSingletonDomainForVar1 [
	| fullDomain expectedDomain1 expectedDomain2 |
	fullDomain := (0 to: 10) asSet.
	fullDomain do: [:value|
		variable1 reset.
		variable2 reset.
		expectedDomain1 := Set with: value.
		variable1 valuesToExplore: expectedDomain1.
		constraint enforceArcConsistency.
		self assert: variable1 valuesToExplore asSet equals: expectedDomain1.
		expectedDomain2 := fullDomain copyWithout: value.
		self assert: variable2 valuesToExplore asSet equals: expectedDomain2.
		self assert: constraint isConsistent ]

]

{ #category : #running }
BTNGAllDifferentsBinaryConstraintTest >> testArcConsistencyWithSingletonDomainForVar2 [
	| fullDomain expectedDomain1 expectedDomain2 |
	fullDomain := (0 to: 10) asSet.
	fullDomain do: [:value|
		variable1 reset.
		variable2 reset.
		expectedDomain2 := Set with: value.
		variable2 valuesToExplore: expectedDomain2.
		constraint enforceArcConsistency.
		expectedDomain1 := fullDomain copyWithout: value.
		self assert: variable1 valuesToExplore asSet equals: expectedDomain1.
		self assert: variable2 valuesToExplore asSet equals: expectedDomain2.
		self assert: constraint isConsistent ].

]
