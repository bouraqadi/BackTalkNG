Class {
	#name : #BTNGSolver,
	#superclass : #Object,
	#instVars : [
		'csp',
		'firstChosenVariable',
		'currentVariable',
		'contexts',
		'backTrackFlag'
	],
	#category : #'BackTalkNG-Kernel'
}

{ #category : #'instance creation' }
BTNGSolver class >> on: constraintSatisfactionProblem [
	^self new
		csp: constraintSatisfactionProblem;
		yourself
]

{ #category : #solving }
BTNGSolver >> allSolutions [
	"compute and store solutions while available"
	| allSolutions |
	self reset.
	allSolutions := Set new.
	[self explorationFinished]
		whileFalse: [self exploreCspStep.
				self solutionFound
					ifTrue: [allSolutions add: self solution.
						self stepBackward].
	].
	^ allSolutions
]

{ #category : #accessing }
BTNGSolver >> backTrackFlag [
	^backTrackFlag
]

{ #category : #accessing }
BTNGSolver >> backTrackFlag: anObject [
	backTrackFlag := anObject
]

{ #category : #solving }
BTNGSolver >> chooseAPreviousContext [
	^self contexts last
]

{ #category : #solving }
BTNGSolver >> chooseAVariable [
	| nonInstantiatedVars |
	self backTrackFlag ifTrue: [^self currentVariable].
	nonInstantiatedVars := self variables
				reject: [:var | var isInstantiated].
	^ nonInstantiatedVars anyOne
]

{ #category : #solving }
BTNGSolver >> chooseVariableAndValue [
	"chooses a variable to instantiate and a value for this variable.
	Then performs the instantiation and triggers constraint propagation"
	self currentVariable: self chooseAVariable.
	self currentVariable nextValue
]

{ #category : #accessing }
BTNGSolver >> contexts [
	^contexts
]

{ #category : #accessing }
BTNGSolver >> contexts: anObject [
	contexts := anObject
]

{ #category : #accessing }
BTNGSolver >> csp [
	^csp
]

{ #category : #accessing }
BTNGSolver >> csp: anObject [
	csp := anObject
]

{ #category : #accessing }
BTNGSolver >> currentVariable [
	^currentVariable
]

{ #category : #accessing }
BTNGSolver >> currentVariable: aBTNGVariable [ 
	currentVariable := aBTNGVariable.
	self firstChosenVariable ifNil: [self firstChosenVariable: aBTNGVariable]
]

{ #category : #testing }
BTNGSolver >> domainWipedOut [
	self currentVariable
		ifNotNil: [(self backTrackFlag)
				and: [self currentVariable valuesToExplore
						ifEmpty: [^ true]]].
	^ self variables
		anySatisfy: [:v | v domainWipedOut]
]

{ #category : #testing }
BTNGSolver >> explorationFinished [
	self firstChosenVariable
		ifNil: [^ self variables
				anySatisfy: [:var | var domain isEmpty]].
	^self firstChosenVariable == self currentVariable and: [self firstChosenVariable valuesToExplore isEmpty]
]

{ #category : #solving }
BTNGSolver >> exploreCspStep [
	"goes forward until failure occurs, which triggers a backtracking"
	[self domainWipedOut]
		whileFalse: [self stepForward.
			self solutionFound ifTrue: [^self]].
	self stepBackward
]

{ #category : #accessing }
BTNGSolver >> firstChosenVariable [
	^firstChosenVariable
]

{ #category : #accessing }
BTNGSolver >> firstChosenVariable: anObject [
	firstChosenVariable := anObject
]

{ #category : #solving }
BTNGSolver >> firstSolution [
	"goes forward until a solution is found or exploration is finished"

	self reset.
	[self solutionFound | self explorationFinished] 
		whileFalse: [self exploreCspStep].
	^ self solution
]

{ #category : #'initialize-release' }
BTNGSolver >> initialize [
	self reset
]

{ #category : #printing }
BTNGSolver >> printOn: aStream [ 
	| i |
	aStream cr; nextPutAll: '-----Solver-----'.
	i := 0.
	self csp constraints
		do: [:ct | 
			aStream cr; nextPutAll: '----Ct ' , (i := i + 1) printString , '----'; cr.
			ct printOn: aStream]
]

{ #category : #solving }
BTNGSolver >> propagateInstantiationFor: constraint [
	^ constraint filter
]

{ #category : #solving }
BTNGSolver >> propagateInstantiationOfCurrentVariable [
	self currentVariable currentValue ifNotNil: [
		self currentVariable valuesToExplore: {self currentVariable currentValue}].
	self sortedConstraintsForPropagation do: [:constraint|
			self propagateInstantiationFor: constraint.
			constraint domainWipedOut ifTrue: [^self]]
]

{ #category : #'initialize-release' }
BTNGSolver >> reset [
	self csp ifNotNil: [self csp reset].
	self contexts: OrderedCollection new.
	self currentVariable: nil.
	self firstChosenVariable: nil.
	self backTrackFlag: false
]

{ #category : #'contexts-management' }
BTNGSolver >> restoreContext: aContext [ 
	self contexts remove: aContext.
	aContext restoreInSolver: self.

]

{ #category : #'contexts-management' }
BTNGSolver >> saveContext [
	self contexts
		add: (BTNGContext fromSolver: self)
]

{ #category : #accessing }
BTNGSolver >> solution [
	| solution |
	self solutionFound ifFalse: [^nil].
	solution := Dictionary new.
	self variables do: [:var|
		solution at: var put: var currentValue].
	^solution
]

{ #category : #testing }
BTNGSolver >> solutionFound [
	| allVarsAreInstantiated |
	allVarsAreInstantiated := self variables allSatisfy: [:var| var isInstantiated].
	allVarsAreInstantiated ifFalse: [^false].
	^ self csp constraints
		allSatisfy: [:ct | ct isSatisfied]
]

{ #category : #solving }
BTNGSolver >> sortedConstraintsForPropagation [
	"Answers a collection with current variable constraints sorted in the order that quickly detects domains wipedouts. By default no sorting is performed."
	^currentVariable constraints
]

{ #category : #solving }
BTNGSolver >> stepBackward [
	"chooses a previously saved state of the problem and restores it"
	| context |
	self contexts
		ifEmpty: [^ self].
	context := self chooseAPreviousContext.
	self restoreContext: context.
	self backTrackFlag: true
]

{ #category : #solving }
BTNGSolver >> stepForward [
	"saves the state of the problem and chooses an instantiation to enforce"
	self chooseVariableAndValue.
	self saveContext.
	self propagateInstantiationOfCurrentVariable.
	self backTrackFlag: false
]

{ #category : #accessing }
BTNGSolver >> variables [
	^self csp variables
]
