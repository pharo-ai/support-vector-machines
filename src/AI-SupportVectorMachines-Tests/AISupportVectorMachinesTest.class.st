"
An AISupportVectorMachinesTest is a test class for testing the behavior of AISupportVectorMachines
"
Class {
	#name : #AISupportVectorMachinesTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-SupportVectorMachines-Tests'
}

{ #category : #running }
AISupportVectorMachinesTest >> setUp [
	super setUp.
	
	model := self supportVectorMachines.
]

{ #category : #tests }
AISupportVectorMachinesTest >> supportVectorMachines [

	^ AISupportVectorMachines new
]

{ #category : #tests }
AISupportVectorMachinesTest >> testDecisionFunction [

	
]

{ #category : #tests }
AISupportVectorMachinesTest >> testFitEmptyOutputValues [

	| input output |
	input := #( #( 5 ) #( 3 ) ).
	output := #(  ).

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AISupportVectorMachinesTest >> testFitXY [

	| input output |
	
	input := #( #( 1 ) #( 2 ) #( 3 ) #( -1 ) #( -2 ) #( -3 ) ).
	
	output :=
	model learningRate: 0.1.
	model numberOfIterations: 1000.
		
		
		

	model fitX: input y: output.
]

{ #category : #tests }
AISupportVectorMachinesTest >> testInconsistentFitInputOnType [

	| input output |
	input := #( #( 'number' ) #( 3 ) #( 1 ) ).
	output := #( 1 3 1 ).

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AISupportVectorMachinesTest >> testInconsistentFitOnDimension [

	| input output |
	input := #( #( 2 ) #( 3 ) ).
	output := #( #( 1 ) ).

	self should: [ model fitX: input y: output ] raise: Error
]

{ #category : #tests }
AISupportVectorMachinesTest >> testInitializeWeightsOfSize [

	model  := AISupportVectorMachines new.

	model initializeWeightsOfSize: 2.
	 self assert: model weights equals: #(0 0).
]

{ #category : #tests }
AISupportVectorMachinesTest >> testPredictionWithNonFittedModel [

	| input output |
	input := #( #( 2 ) #( 3 ) #( 1 ) ).

	self should: [ output := model predict: input ] raise: Error
]
