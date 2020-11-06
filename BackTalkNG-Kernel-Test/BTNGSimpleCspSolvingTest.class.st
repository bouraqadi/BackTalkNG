Class {
	#name : #BTNGSimpleCspSolvingTest,
	#superclass : #TestCase,
	#instVars : [
		'variable1',
		'variable2',
		'variable3',
		'constraint1',
		'constraint2',
		'solver',
		'csp'
	],
	#category : #'BackTalkNG-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
BTNGSimpleCspSolvingTest >> setUp [
	super setUp.
	variable1 := BTNGVariable label: 'V1' domain: #(1 2 ).
	variable2 := BTNGVariable label: 'V2' domain: #(2 3 ).
	variable3 := BTNGVariable label: 'V3' domain: #(1 2 ).
	constraint1 := BTNGEqualityConstraint on: variable1 and: variable2.
	constraint2 := BTNGEqualityConstraint on: variable2 and: variable3.
	csp := BTNGCSP label: 'Equality of 3 integer variables CSP' variables: {variable1. variable2. variable3}.
	solver := BTNGSolverForTest on: csp
]

{ #category : #running }
BTNGSimpleCspSolvingTest >> testAllSolutions [
	self assert: solver allSolutions size equals: 1
]

{ #category : #running }
BTNGSimpleCspSolvingTest >> testChangeCurrentVariableAfterSuccessiveForwardStep [
	| expectedVariable |
	{variable1. variable2. variable3} do: [:var| var domain: #(1 2 3)].
	BTNGEqualityConstraint on: variable1 and: variable3.
	solver currentVariable: variable1.
	variable1 currentValue: 2.
	solver saveContext.
	solver propagateInstantiationOfCurrentVariable.
	self deny: variable2 domainWipedOut.
	solver stepForward.
	self deny: solver currentVariable identicalTo: variable1.
	expectedVariable := solver currentVariable == variable2
		ifTrue: [variable3]
		ifFalse: [variable2].  
	solver stepForward.
	self assert: solver currentVariable identicalTo: expectedVariable

]

{ #category : #running }
BTNGSimpleCspSolvingTest >> testDecomposedSearchSolution [
	| expectedSolution |
	self deny: solver solutionFound.
	self deny: solver explorationFinished.
	self deny: solver domainWipedOut.
	solver currentVariable: variable1.
	variable1 currentValue: 1.
	solver saveContext.
	solver propagateInstantiationOfCurrentVariable.
	self assert: variable2 domainWipedOut.
	self assert: variable2 valuesToExplore isEmpty.
	solver stepBackward.
	self assert: variable2 valuesToExplore asSet equals: variable2 domain asSet.
	variable1 nextValue.
	self deny: csp domainWipedOut.
	self assert: variable1 valuesToExplore asSet equals: #(2) asSet.
	solver saveContext.
	solver propagateInstantiationOfCurrentVariable.
	self assert: variable2 valuesToExplore asArray equals: #(2 ).
	solver currentVariable: variable2.
	variable2 nextValue.
	self assert: variable2 currentValue equals: 2.
	self assert: variable2 valuesToExplore asArray equals: #(2 ).
	solver saveContext.
	solver propagateInstantiationOfCurrentVariable.
	self assert: variable3 valuesToExplore asArray equals: #(2).
	variable3 nextValue.
	self assert: variable3 currentValue equals: 2.
	solver currentVariable: variable3.
	solver saveContext.
	solver propagateInstantiationOfCurrentVariable.
	self assert: solver solutionFound.
	expectedSolution := Dictionary newFrom: {variable1 -> 2. variable2 -> 2. variable3 -> 2}.
	self assert: solver solution equals: expectedSolution
]

{ #category : #running }
BTNGSimpleCspSolvingTest >> testExploreNextValueOfCurrentVariableAfterBacktracking [
	solver currentVariable: variable1.
	variable1 currentValue: 1.
	solver saveContext.
	solver propagateInstantiationOfCurrentVariable.
	self assert: variable2 domainWipedOut.
	self assert: variable2 valuesToExplore isEmpty.
	solver stepBackward.
	solver stepForward.
	self assert: solver currentVariable identicalTo: variable1.
	self assert: variable1 currentValue equals: 2
]

{ #category : #running }
BTNGSimpleCspSolvingTest >> testFirstSolution [
	| expectedSolution |
	solver firstSolution.
	expectedSolution := Dictionary newFrom: {variable1 -> 2. variable2 -> 2. variable3 -> 2}.
	self assert: solver solution equals: expectedSolution
]
