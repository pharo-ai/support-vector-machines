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
		'lagrangianMultiplier',
		'supportVectorsCollection'
	],
	#category : #'AI-SupportVectorMachines'
}

{ #category : #accessing }
AISupportVectorMachines >> bias [
	^ bias 
]

{ #category : #accessing }
AISupportVectorMachines >> bias: anInteger [ 
	bias := anInteger
]

{ #category : #accessing }
AISupportVectorMachines >> biasDualX: inputMatrix y: output [

	"b = 1/Nsv * Σ (y_j - w * x_j) 
	
	where j is number of support vectors"

	| supportVectorsSum |
	supportVectorsSum := inputMatrix
		                     with: output
		                     collect: [ :x :y | y - (weights * x) ].
	bias := supportVectorsSum average "(bias :=) instead of (^)"


	"supportVectorsSum := supportVectorsCollection with: output collect: [ :x :y | y - (weights * x)].
	bias := supportVectorsSum average ""(bias :=) instead of (^)"""
]

{ #category : #api }
AISupportVectorMachines >> decisionBoundary2: inputMatrix [

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

	| dot |
	1 to: inputMatrix size do: [ :x1 | 
		1 to: inputMatrix size do: [ :x2 | 
			dot := x1 * x2.
			
			supportVectorsCollection add: dot

	 ] ].

	
]

{ #category : #api }
AISupportVectorMachines >> decisionBoundary: inputMatrix [

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

	weights := inputMatrix collect: [ :row | 
		        (lagrangianMultiplier * row) sum + bias ]
]

{ #category : #api }
AISupportVectorMachines >> fitX: inputMatrix y: outputVector [

	self initializeWeightsOfSize: (inputMatrix anyOne size).

	numberOfIterations := 0.
	

	self lagrangianMultiplier: 1.
]

{ #category : #api }
AISupportVectorMachines >> hypothesisFunction: inputMatrix [

	| constraints |
	constraints := inputMatrix collect: [ :e | (weights * e) sum + bias ].

	
]

{ #category : #accessing }
AISupportVectorMachines >> initializeWeightsOfSize: anInteger [

	bias := 0.
	weights := (1 to: anInteger) collect: [ :each | 0 ]
	
]

{ #category : #accessing }
AISupportVectorMachines >> kkt2Y: output [

^ lagrangianMultiplier * output 
]

{ #category : #accessing }
AISupportVectorMachines >> lagrangianMultiplier [

	"take the derivative wrt a and set it equal to zero"
	
	

	
]

{ #category : #accessing }
AISupportVectorMachines >> lagrangianMultiplier: anUndefinedObject [ 
	lagrangianMultiplier := anUndefinedObject  
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
	prediction := self hypothesisFunction: inputMatrix.

	^ prediction asOrderedCollection collect: [ :each | 
		  each > 0 
			  ifTrue: [ 1 ]
			  ifFalse: [ -1 ] ]
]

{ #category : #api }
AISupportVectorMachines >> signX: inputMatrix y: output [

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

	"1 to: inputMatrix size do: [ :x1 | 
		1 to: inputMatrix size do: [ :x2 | 
			sign := lagrangianMultiplier  * x1 * x2 ] ]"
	
	"| w |
	w := self weightsDualX: inputMatrix y: output ."
	
	^ inputMatrix collect: [:row |
		(weights * row) sum + bias ] "weights instead of w"
]

{ #category : #accessing }
AISupportVectorMachines >> supportVectorsCollection [

	supportVectorsCollection := Dictionary new.
	^ supportVectorsCollection
]

{ #category : #api }
AISupportVectorMachines >> supportVectorsX: inputMatrix y:output [

 output * self decisionBoundary2: inputMatrix 

		
]

{ #category : #accessing }
AISupportVectorMachines >> weights [
	^ weights 
]

{ #category : #accessing }
AISupportVectorMachines >> weightsDualX: inputMatrix y: output [

	weights := inputMatrix with: output collect: [:rowIn :rowOut|
		(lagrangianMultiplier * rowOut * rowIn) sum ]
]
