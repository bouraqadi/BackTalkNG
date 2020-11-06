Class {
	#name : #BTNGVariableTest,
	#superclass : #TestCase,
	#instVars : [
		'variable'
	],
	#category : #'BackTalkNG-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
BTNGVariableTest >> setUp [
	variable := BTNGVariable 
				label: 'x'
				from: 1
				to: 3
]

{ #category : #running }
BTNGVariableTest >> testConnectionBetweenValuesToExploreAndCurrentValue [
	variable currentValue: 2.
	variable valuesToExplore: #().
	self assert: variable valuesToExplore isEmpty.
	self assert: variable currentValue isNil.
	
]

{ #category : #running }
BTNGVariableTest >> testDomainChange [
	| expectedDomain expectedSingletonDomain |
	expectedDomain := (1 to: 5) asSet.
	variable
		valuesToExplore: #(0).
	variable domain: expectedDomain.
	self deny: variable domain == expectedDomain.
	self assert: variable domain asSet = expectedDomain.
	self assert: variable valuesToExplore asSet = expectedDomain.
	self deny: variable domain == variable valuesToExplore.
	expectedSingletonDomain := Set with: 1.
	variable domain: expectedSingletonDomain.
	self assert: variable valuesToExplore asSet = expectedSingletonDomain.
]

{ #category : #running }
BTNGVariableTest >> testFilterToReject [
	variable filterToReject: [:value | value even].
	self assert: variable valuesToExplore asSet = #(1 3 ) asSet
]

{ #category : #running }
BTNGVariableTest >> testFilterToSelect [
	variable filterToSelect: [:value | value even].
	self assert: variable valuesToExplore asSet = #(2 ) asSet
]

{ #category : #running }
BTNGVariableTest >> testInitialDomain [
	| expectedDomain |
	expectedDomain := Set with: 1 with: 2 with: 3.
	self assert: variable domain asSet = expectedDomain.
	self assert: variable valuesToExplore asSet = expectedDomain.
	self deny: variable domain == variable valuesToExplore.

]

{ #category : #running }
BTNGVariableTest >> testNextValue [
	| expectedCurrentValue expectedValuesToExplore |
	expectedValuesToExplore := variable domain.
	self deny: variable isInstantiated.
	self assert: variable valuesToExplore = variable domain.
	4
		timesRepeat: [expectedCurrentValue := variable nextValue.
			expectedCurrentValue 
				ifNil: [self deny: variable isInstantiated ]
				ifNotNil: [self assert: variable isInstantiated].
			self assert: variable currentValue = expectedCurrentValue.
			self assert: variable valuesToExplore asSet = expectedValuesToExplore asSet.
			expectedValuesToExplore := expectedValuesToExplore copyWithout: expectedCurrentValue.
			]
]

{ #category : #running }
BTNGVariableTest >> testPrinting [
	self assert: variable printString = (variable label , ' = nil {1. 2. 3}').
	variable currentValue: 10.
	self assert: variable printString = (variable label , ' = 10 {1. 2. 3}').
	variable domain: {Object new}.
	self assert: variable printString = (variable label , ' = 10 {an Object}').
]

{ #category : #running }
BTNGVariableTest >> testUnicityOfDomainElements [
	| expectedDomain |
	expectedDomain := (1 to: 3) asSet.
	variable domain: {1. 2. 3. 2. 3}.
	self assert: variable domain size = expectedDomain size.
	self assert: variable domain asSet = expectedDomain
]

{ #category : #running }
BTNGVariableTest >> testValuesToExploreWriting [
	| providedDomain |
	providedDomain := Set with: 4 with: 5.
	variable valuesToExplore: providedDomain.
	self assert: variable valuesToExplore asSet = providedDomain.
	self deny: variable valuesToExplore asSet == providedDomain
]
