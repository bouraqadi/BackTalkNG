Class {
	#name : #BTNGGreaterThanThersholdUnaryConstraintTest,
	#superclass : #BTNGAbstractUnaryConstraintTest,
	#category : #'BackTalkNG-Constraints-Test'
}

{ #category : #'setUp-tearDown' }
BTNGGreaterThanThersholdUnaryConstraintTest >> constraintClass [
	^BTNGGreaterThanThersholdUnaryConstraint
]

{ #category : #running }
BTNGGreaterThanThersholdUnaryConstraintTest >> testAllDomainValuesValid [
	constraint valueForComparison: -1.
	constraint enforceArcConsistency.
	self assert: variable1 valuesToExplore asSet = variable1 domain asSet.
	self assert: constraint isConsistent
]

{ #category : #running }
BTNGGreaterThanThersholdUnaryConstraintTest >> testDomainWipedOut [
	self deny: constraint domainWipedOut.
	variable1 valuesToExplore: #().
	self assert: constraint domainWipedOut.
]

{ #category : #running }
BTNGGreaterThanThersholdUnaryConstraintTest >> testNoDomainValueIsValid [
	constraint valueForComparison: 12.
	constraint enforceArcConsistency.
	self assert: variable1 domainWipedOut.
	self assert: constraint isConsistent
]

{ #category : #running }
BTNGGreaterThanThersholdUnaryConstraintTest >> testPrinting [
	self assert: constraint printString = (self constraintClass name, ' (V1 = nil)').
	variable1 currentValue: 12.
	self assert: constraint printString = (self constraintClass name, ' (V1 = 12)').
	
]

{ #category : #running }
BTNGGreaterThanThersholdUnaryConstraintTest >> testSomeDomainValuesAreValid [
	constraint valueForComparison: 5.
	constraint enforceArcConsistency.
	self assert: variable1 valuesToExplore asSet = (6 to: 10) asSet.
	self assert: constraint isConsistent
]
