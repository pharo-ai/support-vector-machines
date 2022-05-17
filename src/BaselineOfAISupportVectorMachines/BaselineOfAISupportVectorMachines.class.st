"
I am a baseline
"
Class {
	#name : #BaselineOfAISupportVectorMachines,
	#superclass : #BaselineOf,
	#category : #BaselineOfAISupportVectorMachines
}

{ #category : #baselines }
BaselineOfAISupportVectorMachines >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Packages"
		spec package: 'AI-SupportVectorMachines'.

		spec
			package: 'AI-SupportVectorMachines-Tests'
			with: [ spec requires: #( 'AI-SupportVectorMachines' ) ] ].

	spec
		group: 'Core' with: #( 'AI-SupportVectorMachines' );
		group: 'Tests' with: #( 'AI-SupportVectorMachines-Tests' ).

	spec group: 'default' with: #( 'Core' 'Tests' )
]
