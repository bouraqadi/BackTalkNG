Class {
	#name : #BTNGCSPTest,
	#superclass : #BTNGBinaryConstraintTest,
	#instVars : [
		'csp',
		'variable3',
		'variable4',
		'constraint2'
	],
	#category : #'BackTalkNG-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
BTNGCSPTest >> setUp [
	super setUp.
	variable3 := BTNGVariable 
				label: 'v3'
				from: 5
				to: 8.
	variable4 := BTNGVariable 
				label: 'v4'
				from: 3
				to: 6.
	constraint2 := BTNGEqualityConstraint on: variable3 and: variable4.
	csp := BTNGCSP label: 'cspTest'
				variables: {  variable1. variable2}
]

{ #category : #running }
BTNGCSPTest >> testInitialization [
	| expectedVariables expectedConstraints |
	expectedVariables := IdentitySet with: variable1 with: variable2.
	self assert: csp variables asIdentitySet = expectedVariables.
	expectedConstraints := IdentitySet with: constraint.
	self assert: csp constraints = expectedConstraints.
]

{ #category : #running }
BTNGCSPTest >> testUnicityOfVariablesOnMultipleAdditions [
	| expectedVariables |
	csp variables add: variable2.
	csp addVariable: variable2.
	expectedVariables := IdentitySet with: variable1 with: variable2.
	self assert: csp variables size = expectedVariables size.
	self assert: csp variables asIdentitySet = expectedVariables
]

{ #category : #running }
BTNGCSPTest >> testUnicityOfVariablesOnSettingTheWholeCollection [
	| expectedVariables |
	csp variables: {variable2. variable1. variable2. variable2. variable1}.
	expectedVariables := IdentitySet with: variable1 with: variable2.
	self assert: csp variables size = expectedVariables size.
	self assert: csp variables asIdentitySet = expectedVariables
]

{ #category : #running }
BTNGCSPTest >> testVariableAddition [
	| expectedVariables expectedConstraints |
	csp addVariable: variable3.
	csp variables add: variable4.
	expectedVariables := IdentitySet 
				with: variable1
				with: variable2
				with: variable3
				with: variable4.
	self assert: csp variables asIdentitySet = expectedVariables.
	expectedConstraints := IdentitySet with: constraint with: constraint2.
	self assert: csp constraints = expectedConstraints
]

{ #category : #running }
BTNGCSPTest >> testVariableRemoval [
	| expectedVariables expectedConstraints |
	csp removeVariable: variable2.
	expectedVariables := IdentitySet 
				with: variable1.
	self assert: csp variables asIdentitySet = expectedVariables.
	expectedConstraints := IdentitySet with: constraint.
	self assert: csp constraints = expectedConstraints.
	self shouldnt: [csp removeVariable: variable2] raise: Exception
]
