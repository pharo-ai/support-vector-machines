"
I implement the hard margin of Support Vector Machines. I'll be refactored to strategy pattern for the next mergin (soft margin)
"
Class {
	#name : #AISupportVectorMachines,
	#superclass : #Object,
	#instVars : [
		'weights',
		'learningRate',
		'bias',
		'numberOfIterations',
		'lagrangianMultiplier'
	],
	#category : #'AI-SupportVectorMachines'
}

{ #category : #accessing }
AISupportVectorMachines >> bias [
	^ bias 
]

{ #category : #api }
AISupportVectorMachines >> decisionFunction: inputMatrix [
	"h(x) = sign(Σ α_i * y_i * <x_i.x> + b)
	
	i: stands for each training example
	y_i: is just a label (1 or -1). It's a scalar 
	α_i: dual variable --> Lagrangian multiplier -->  It's a scalar
	x_i: feature vector corresponding to the ith training example. It's a vector cause we have multiple features
	<x_i.x>: scalar product
	
	---------------------------------------------------------------------
	
	sign(<w.z> + b) = sign(∑ α_i * y * <x.z> + b)
	
	If this function returns 1, then test instance z is classified
as positive; otherwise, it is classified as negative.
	
	
	"
	
	| sum |
	sum := inputMatrix collect: [ :row |(lagrangianMultiplier*row) sum + bias ].
	^ sum
]

{ #category : #api }
AISupportVectorMachines >> fitX: inputMatrix y: outputVector [

	self initializeWeightsOfSize: (inputMatrix anyOne size).

	numberOfIterations := 0.
]

{ #category : #accessing }
AISupportVectorMachines >> initializeWeightsOfSize: anInteger [

	bias := 0.
	weights := (1 to: anInteger) collect: [ :each | 0 ]
	
]

{ #category : #accessing }
AISupportVectorMachines >> lagrangianMultiplier [

	"take the derivative wrt a and set it equal to zero"

	
]

{ #category : #accessing }
AISupportVectorMachines >> learningRate [
	^ learningRate
]

{ #category : #accessing }
AISupportVectorMachines >> learningRate: aNumber [ 
	learningRate := aNumber
]

{ #category : #accessing }
AISupportVectorMachines >> numberOfIterations: anInteger [
	numberOfIterations := anInteger 
]

{ #category : #api }
AISupportVectorMachines >> predict: inputMatrix [

	| prediction |
	prediction := self decisionFunction: inputMatrix.

	^ prediction collect: [ :each | 
		  each > 0
			  ifTrue: [ 1 ]
			  ifFalse: [ -1 ] ]
]

{ #category : #accessing }
AISupportVectorMachines >> weights [
	^ weights 
]

{ #category : #accessing }
AISupportVectorMachines >> weightsDualX: inputMatrix y: output [


	^ lagrangianMultiplier*output*inputMatrix 
]
