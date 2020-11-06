Class {
	#name : #BTNGGreaterThanThresholdUnaryConstraintTest,
	#superclass : #BTNGAbstractUnaryConstraintTest,
	#category : #'BackTalkNG-Constraints-Test'
}

{ #category : #'setUp-tearDown' }
BTNGGreaterThanThresholdUnaryConstraintTest >> constraintClass [
	^BTNGGreaterThanThresholdUnaryConstraint
]

{ #category : #running }
BTNGGreaterThanThresholdUnaryConstraintTest >> testAllDomainValuesValid [
	constraint valueForComparison: -1.
	constraint enforceArcConsistency.
	self assert: variable1 valuesToExplore asSet equals: variable1 domain asSet.
	self assert: constraint isConsistent
]

{ #category : #running }
BTNGGreaterThanThresholdUnaryConstraintTest >> testDomainWipedOut [
	self deny: constraint domainWipedOut.
	variable1 valuesToExplore: #().
	self assert: constraint domainWipedOut.
]

{ #category : #running }
BTNGGreaterThanThresholdUnaryConstraintTest >> testNoDomainValueIsValid [
	constraint valueForComparison: 12.
	constraint enforceArcConsistency.
	self assert: variable1 domainWipedOut.
	self assert: constraint isConsistent
]

{ #category : #running }
BTNGGreaterThanThresholdUnaryConstraintTest >> testPrinting [
	self assert: constraint printString equals: (self constraintClass name, ' (V1 = nil)').
	variable1 currentValue: 12.
	self assert: constraint printString equals: (self constraintClass name, ' (V1 = 12)').
	
]

{ #category : #running }
BTNGGreaterThanThresholdUnaryConstraintTest >> testSomeDomainValuesAreValid [
	constraint valueForComparison: 5.
	constraint enforceArcConsistency.
	self assert: variable1 valuesToExplore asSet equals: (6 to: 10) asSet.
	self assert: constraint isConsistent
]
