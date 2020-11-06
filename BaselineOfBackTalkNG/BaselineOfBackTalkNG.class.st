Class {
	#name : #BaselineOfBackTalkNG,
	#superclass : #BaselineOf,
	#category : #BaselineOfBackTalkNG
}

{ #category : #baselines }
BaselineOfBackTalkNG >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: 'BackTalkNG-Kernel';
			package: 'BackTalkNG-Solvers' with: [
				spec requires: #'BackTalkNG-Kernel'];
			package: 'BackTalkNG-Constraints' with: [
				spec requires: #'BackTalkNG-Kernel'];
			package: 'BackTalkNG-Solvers-Test' with: [
				spec requires: #'BackTalkNG-Solvers'];
			package: 'BackTalkNG-Constraints-Test' with: [
				spec requires: #'BackTalkNG-Constraints'].
	]
]
