Class {
	#name : #BTNGSolverTest,
	#superclass : #BTNGCSPTest,
	#instVars : [
		'solver'
	],
	#category : #'BackTalkNG-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
BTNGSolverTest >> setUp [
	super setUp.
	csp addVariable: variable3.
	csp addVariable: variable4.
	solver := BTNGSolverForTest on: csp.
	solver reset
]

{ #category : #running }
BTNGSolverTest >> testAllSolutions [
	| solutions value1 value2 value3 value4 |
	solutions := solver allSolutions.
	self assert: solver explorationFinished.
	"18 == (2 to: 10) size * (5 to: 6) size."
	self assert: solutions asSet size = 18.
	solutions
		do: [:solution | 
			value1 := solution at: variable1.
			value2 := solution at: variable2.
			self assert: value1 = value2.
			value3 := solution at: variable3.
			value4 := solution at: variable4.
			self assert: value3 = value4]
]

{ #category : #running }
BTNGSolverTest >> testAllSolutionsOnATrivialCSP [
	| expectedSolution solutions |
	variable1 domain: #(3 ).
	variable2 domain: #(3 ).
	variable3 domain: #(6 ).
	variable4 domain: #(6 ).
	expectedSolution := Dictionary newFrom: {variable1 -> 3. variable2 -> 3. variable3 -> 6. variable4 -> 6}.
	solutions := solver allSolutions.
	self assert: solutions size = 1.
	self assert: solutions anyOne = expectedSolution
]

{ #category : #running }
BTNGSolverTest >> testCspWithoutConstraint [
	| allVariables expectedNumberOfSolutions |
	allVariables := {variable1. variable2. variable3. variable4}.
	allVariables do: [:var|
		var domain: #(1 2).
		var constraints do: [:constraintOnVar| var removeConstraint: constraintOnVar]].
	expectedNumberOfSolutions := 16.
	self assert: solver allSolutions size = expectedNumberOfSolutions
]

{ #category : #running }
BTNGSolverTest >> testCspWithoutSolutionWithEmptyDomains [
	| solution |
	csp variables
		do: [:var | var domain: Set new].
	solution := solver firstSolution.
	self assert: solution isNil.
	self deny: solver solutionFound.
	self assert: solver explorationFinished
]

{ #category : #running }
BTNGSolverTest >> testCspWithoutSolutionWithoutAnyEmptyDomain [
	| solution |
	variable1 domain: #(1 2 3).	
	variable2 domain: #(4 5 6).	
	variable3 domain: #(1 2 3).	
	variable4 domain: #(4 5 6).	
	solution := solver firstSolution.
	self assert: solution isNil.
	self deny: solver solutionFound.
	self assert: solver explorationFinished
]

{ #category : #running }
BTNGSolverTest >> testDomainWipedOutIfAllVariablesAreInstantiatedAndAllValuesExploredInCurrentVariable [
	self deny: solver domainWipedOut.
	variable1 currentValue: 1.
	variable2 currentValue: 2.
	variable3 currentValue: 3.
	variable4 currentValue: 4.
	solver currentVariable: variable1.
	solver variables
		do: [:var | self assert: var isInstantiated].
	variable1 valuesToExplore: #().
	solver backTrackFlag: true.
	self assert: solver domainWipedOut
]

{ #category : #running }
BTNGSolverTest >> testDomainWipedOutOnVariableDomainWipedOut [
	self deny: solver domainWipedOut.
	csp variables atRandom valuesToExplore:  #().
	self assert: solver domainWipedOut
]

{ #category : #running }
BTNGSolverTest >> testExplorationFinishedIfVariableWithEmptyDomain [
	self deny: solver explorationFinished.
	variable1 domain: Set new.
	self assert: solver explorationFinished
]

{ #category : #running }
BTNGSolverTest >> testExplorationFinishedOnFirstChosenVariableWipedOut [
	self deny: solver explorationFinished.
	solver firstChosenVariable: variable1.
	solver currentVariable: variable1.
	variable1 valuesToExplore: Set new.
	self assert: solver explorationFinished
]

{ #category : #running }
BTNGSolverTest >> testFirstSolution [
	| solution value1 value2 value3 value4 |
	3 timesRepeat: [solution := solver firstSolution.
	self assert: solver solutionFound.
	value1 := solution at: variable1.
	value2 := solution at: variable2.
	self assert: value1 = value2.
	value3 := solution at: variable3.
	value4 := solution at: variable4.
	self assert: value3 = value4]
]

{ #category : #running }
BTNGSolverTest >> testFirstSolutionOnATrivialCSP [
	| expectedSolution solution |
	variable1 domain: #(3 ).
	variable2 domain: #(3 ).
	variable3 domain: #(6 ).
	variable4 domain: #(6 ).
	solution := solver firstSolution.
	self deny: solution isNil.
	self assert: solver solutionFound.
	expectedSolution := Dictionary newFrom: {variable1 -> 3. variable2 -> 3. variable3 -> 6. variable4 -> 6}.
	self assert: solver solution = expectedSolution
]

{ #category : #running }
BTNGSolverTest >> testReset [
	csp variables do: [:var | 
		var currentValue: 2.
		var valuesToExplore: #(1 ).
		solver currentVariable: var.
		solver saveContext].
	self assert: solver contexts size = csp variables size.
	solver reset.
	csp variables do: 
			[:var | 
			self assert: var currentValue == nil.
			self assert: var domain asSet = var valuesToExplore asSet].
	self assert: solver contexts isEmpty
]

{ #category : #running }
BTNGSolverTest >> testRestoreContext [
	| variable1ReducedDomains variable3ReducedDomains reducedDomain1 reducedDomain3 expectedReducedDomain1 expectedReducedDomain3 currentVars currentVariable expectedCurrentVar variable1CurrentValues |
	self assert: solver contexts isEmpty.
	variable1ReducedDomains := #(#(1 2 3 ) #(2 3 ) #(4 5 ) ).
	variable3ReducedDomains := #(#(0 9 7 ) #(5 6 7 ) #(3 2 ) ).
	variable1CurrentValues := #(1 2 3).
	currentVars := {  variable1. variable2. variable3}.
	variable2 currentValue: 2.
	self assert: variable2 isInstantiated.
	1 to: 3
		do: 
			[:index | 
			reducedDomain1 := variable1ReducedDomains at: index.
			variable1 valuesToExplore: reducedDomain1.
			variable1 currentValue: (variable1CurrentValues at: index). 
			reducedDomain3 := variable3ReducedDomains at: index.
			variable3 valuesToExplore: reducedDomain3.
			currentVariable := currentVars at: index.
			solver currentVariable: currentVariable.
			solver saveContext].
	self assert: solver contexts asSet size = 3.
	solver contexts copy with: (1 to: 3)
		do: 
			[:restoredContext :index | 
			expectedReducedDomain1 := variable1ReducedDomains at: index.
			expectedReducedDomain3 := variable3ReducedDomains at: index.
			solver restoreContext: restoredContext.
			self deny: (solver contexts includes: restoredContext).
			self assert: variable1 currentValue = (variable1CurrentValues at: index).
			self 
				assert: variable1 valuesToExplore asSet = expectedReducedDomain1 asSet.
			self 
				assert: variable3 valuesToExplore asSet = expectedReducedDomain3 asSet.
			expectedCurrentVar := currentVars at: index.
			self assert: solver currentVariable == expectedCurrentVar]
]

{ #category : #running }
BTNGSolverTest >> testSaveContext [
	| variable1ReducedDomains variable3ReducedDomains reducedDomain1 reducedDomain3 savedContext expectedReducedDomain1 expectedReducedDomain3 currentVars variable1CurrentValues |
	self assert: solver contexts isEmpty.
	variable1ReducedDomains := #(#(1 2 3 ) #(2 3 ) #(4 5 ) ).
	variable3ReducedDomains := #(#(0 9 7 ) #(5 6 7 ) #(3 2 ) ).
	variable1CurrentValues := #(1 2 3).
	currentVars := {  variable1. variable2. variable3}.
	variable2 currentValue: 2.
	self assert: variable2 isInstantiated.
	1 to: 3
		do: 
			[:index | 
			reducedDomain1 := variable1ReducedDomains at: index.
			variable1 valuesToExplore: reducedDomain1.
			variable1 currentValue: (variable1CurrentValues at: index). 
			reducedDomain3 := variable3ReducedDomains at: index.
			variable3 valuesToExplore: reducedDomain3.
			solver currentVariable: (currentVars at: index).
			solver saveContext].
	self assert: solver contexts asSet size = 3.
	1 to: 3
		do: 
			[:index | 
			expectedReducedDomain1 := variable1ReducedDomains at: index.
			expectedReducedDomain3 := variable3ReducedDomains at: index.
			savedContext := solver contexts at: index.
			self assert: savedContext valuesToExploreDict keys = solver variables asSet.
			self assert: (savedContext currentValueFor: variable1)  
						= (variable1CurrentValues at: index).
			self assert: (savedContext valuesToExploreFor: variable1) asSet 
						= expectedReducedDomain1 asSet.
			self assert: (savedContext valuesToExploreFor: variable3) asSet 
						= expectedReducedDomain3 asSet.
			self assert: savedContext currentVariable == (currentVars at: index)]
]

{ #category : #running }
BTNGSolverTest >> testSolutionFound [
	| expectedSolution |
	variable1 currentValue: 3.
	variable2 currentValue: 3.
	variable3 currentValue: 6.
	variable4 currentValue: 6.
	self assert: solver solutionFound.
	expectedSolution := Dictionary newFrom: {variable1->3. variable2->3. variable3->6. variable4->6}.
	self assert: solver solution = expectedSolution.
	
]

{ #category : #running }
BTNGSolverTest >> testSolutionFoundOnATrivialCSP [ 
	| expectedSolution |
	variable1 domain: #(3 ).
	variable2 domain: #(3 ).
	variable3 domain: #(6 ).
	variable4 domain: #(6 ).
	solver firstSolution.
	self assert: solver solutionFound.
	expectedSolution := Dictionary newFrom: {variable1 -> 3. variable2 -> 3. variable3 -> 6. variable4 -> 6}.
	self assert: solver solution = expectedSolution
]
