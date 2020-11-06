Class {
	#name : #BTNGForwardCheckingSolver,
	#superclass : #BTNGSolver,
	#category : #'BackTalkNG-Solvers'
}

{ #category : #solving }
BTNGForwardCheckingSolver >> propagateInstantiationFor: constraint [
	^ constraint enforceArcConsistency 
]
