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

	^ AISupportVectorMachinesQP new
]

{ #category : #tests }
AISupportVectorMachinesTest >> testCorrectFitXY [

	| input output |
	
	input := #( #( 1 1 ) #( 1 0 ) #( 2 1 ) #( 5 3 ) ).

	output := #( 1 1 -1 -1 )
]

{ #category : #tests }
AISupportVectorMachinesTest >> testDecisionFunction [

	
]

{ #category : #tests }
AISupportVectorMachinesTest >> testFitEmptyInputMatrix [

	"It should be better to raise the exception at the initialization of the LinearModel"

	| input output |
	input := #(  ).
	output := #( #( 1 ) ).
	
	self should: [ model fitX: input y: output ] raise: Error
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

	| input output actualOutput testInput testOutput |
	self skip.
	input := #( #( 0 0 ) #( 1 1 ) #( 3 3 ) #( 4 4 ) ).
	output := #( 1 1 -1 -1 ).

	model learningRate: 0.1.
	model numberOfIterations: 1000.

	"training"
	model fitX: input y: output.

	testInput := #( #( -1 -1 ) #( 5 5 ) ).
	testOutput := #( 1 -1 ).

	"testing"
	actualOutput := model predict: testInput.

	self assert: actualOutput equals: testOutput
]

{ #category : #tests }
AISupportVectorMachinesTest >> testInitializeWeightsOfSize [

	model  := AISupportVectorMachines new.

	model initializeWeightsOfSize: 2.
	 self assert: model weights equals: #(0 0).
]

{ #category : #test }
AISupportVectorMachinesTest >> testPXY [

	| input output pResult pxMethod |
	
	input := #( #( 0 0 ) #( 1 1 ) #( 3 3 ) #( 4 4 ) ).
	output := #( 1 1 -1 -1 ).


	pResult := #( #( 0 0 ) #( 1 1 ) #( -3 -3 ) #( -4 -4 ) )
		           asOrderedCollection.

	pxMethod := model pX: input y: output.
	self assert: pxMethod equals: pResult.
		self skip.
]

{ #category : #tests }
AISupportVectorMachinesTest >> testPredictionWithNonFittedModel [

	| input output |
	input := #( #( 2 ) #( 3 ) #( 1 ) ).

	self should: [ output := model predict: input ] raise: Error
]

{ #category : #tests }
AISupportVectorMachinesTest >> testdecisionBoundary [

	<expectedError>
	| input output expectedWeights |
	self skip.
	self assert: false.
	input := #( #( 0 0 ) #( 1 1 ) #( 3 3 ) #( 4 4 ) ).
	output := #( 1 1 -1 -1 ).

	model lagrangianMultiplier: 1.
	model bias: 0.

	model weightsDualX: input y: output. "sets weights"

	expectedWeights := #( 0 2 6 8 ).

	model decisionBoundary: input.

	self assert: model weights equals: expectedWeights
]
