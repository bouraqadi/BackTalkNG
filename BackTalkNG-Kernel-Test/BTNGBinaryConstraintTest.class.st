Class {
	#name : #BTNGBinaryConstraintTest,
	#superclass : #TestCase,
	#instVars : [
		'variable1',
		'variable2',
		'constraint'
	],
	#category : #'BackTalkNG-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
BTNGBinaryConstraintTest >> setUp [
	variable1 := BTNGVariable 
				label: 'v1'
				from: 0
				to: 10.
	variable2 := BTNGVariable 
				label: 'v2'
				from: 2
				to: 12.
	constraint := BTNGEqualityConstraint on: variable1 and: variable2
]

{ #category : #running }
BTNGBinaryConstraintTest >> testDomainWipedOut [
	self deny: constraint domainWipedOut.
	variable1 valuesToExplore: #().
	self assert: constraint domainWipedOut.
	variable1 reset.
	variable2 valuesToExplore: #().
	self assert: constraint domainWipedOut.
	
]

{ #category : #running }
BTNGBinaryConstraintTest >> testPrinting [
	self assert: (constraint printString = 'BTNGEqualityConstraint (v1 = nil, v2 = nil)' 
		or: [constraint printString = 'BTNGEqualityConstraint (v2 = nil, v1 = nil)'])
]

{ #category : #running }
BTNGBinaryConstraintTest >> testReferencesAfterVariableRemoval [
	| expectedConstraints expectedVariables newVariable |
	newVariable := BTNGVariable 
				label: 'x'
				from: 1
				to: 2.
	constraint variableA: newVariable.
	expectedConstraints := Set with: constraint.
	expectedVariables := Set with: variable2 with: newVariable.
	self assert: variable1 constraints isEmpty.
	self assert: variable2 constraints equals: expectedConstraints.
	self assert: constraint variables equals: expectedVariables
]

{ #category : #running }
BTNGBinaryConstraintTest >> testReferencesOnFromVariables [
	| expectedConstraints expectedVariables |
	expectedConstraints := {  constraint} asSet.
	expectedVariables := {  variable1. variable2} asSet.
	self assert: variable1 constraints equals: expectedConstraints.
	self assert: variable2 constraints equals: expectedConstraints.
	self assert: constraint variables equals: expectedVariables
]

{ #category : #running }
BTNGBinaryConstraintTest >> testSatisfaction [
	variable1 currentValue: 5.
	variable2 currentValue: 5.
	self assert: constraint isSatisfied.
	variable1 valuesToExplore: #().
	self deny: constraint isSatisfied.
	variable1 reset.
	variable1 currentValue: 5.
	variable2 valuesToExplore: #().
	self deny: constraint isSatisfied.

]
