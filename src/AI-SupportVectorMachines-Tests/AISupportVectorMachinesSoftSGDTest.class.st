"
An AISupportVectorMachinesSoftSGDTest is a test class for testing the behavior of AISupportVectorMachinesSoftSGD
"
Class {
	#name : #AISupportVectorMachinesSoftSGDTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-SupportVectorMachines-Tests'
}

{ #category : #running }
AISupportVectorMachinesSoftSGDTest >> setUp [
	super setUp.
	
	model := AISupportVectorMachinesSoftSGD new
]

{ #category : #test }
AISupportVectorMachinesSoftSGDTest >> testCalculateCostGradientXY [

	| x y w res |
	x := #( #( 1 2 3 ) #( 4 5 6 ) #( 7 8 9 ) ).
	y := #( -1 1 1 ).
	w := #( 3 2 1 ).
	model weights: w.
	model regularizationStrenght: 10000.
	res := model calculateCostGradientX: x y: y.
	self assert: res asArray equals: {(10009/3). (20006/3). 10001} asArray
]

{ #category : #test }
AISupportVectorMachinesSoftSGDTest >> testCalculateDistancesForXY [

	| x y w res |
	x := #( #( 1 2 3 ) #( 4 5 6 ) #( 7 8 9 ) ).
	y := #( 10 11 12 ).
	w := #( 13 14 15 ).
	model weights: w.
	res := model calculateDistancesForX: x y: y.
	self assert: res equals: #( -859 -2331 -4055 )
]

{ #category : #test }
AISupportVectorMachinesSoftSGDTest >> testCalculateDistancesForXYForLittleNumbers [

	| x y w res |
	x := #( #( 1 2 3 ) #( 4 5 6 ) #( 7 8 9 ) ).
	y := #( 0 1 2 ).
	w := #( 3 2 1 ).
	model weights: w.
	res := model calculateDistancesForX: x y: y.
	self assert: res equals: #( 1 -27 -91 )
]

{ #category : #test }
AISupportVectorMachinesSoftSGDTest >> testComputeCostXY [

	| x y w res |
	x := #( #( 1 2 3 ) #( 4 5 6 ) #( 7 8 9 ) ).
	y := #( 0 1 2 ).
	w := #( 3 2 1 ).
	
	model weights: w.
	model regularizationStrenght: 10000.
	res := model computeCostX: x y: y.
	self assert: res equals: 10021/3 "3340.333333333333"
]

{ #category : #test }
AISupportVectorMachinesSoftSGDTest >> testFitXY [

	| x y res |
	x := #( #( 1 0 0 ) #( 1 1 1 ) #( 1 3 3 ) #( 1 4 4 ) ).
	y := #( 1 1 -1 -1 ).

	model regularizationStrenght: 10000.
	model learningRate: 1e-6.
	model maxEpochs: 5000.

	res := model fitX: x y: y.
	

	model weights
		with: #( 2.03034695 -0.5100166 -0.5100166 )
		do: [ :real :expected | self assert: real closeTo: expected ]
]

{ #category : #test }
AISupportVectorMachinesSoftSGDTest >> testPredict [

	| expectedOutput x testInput y actualOutput |
	x := #( #( 1 0 0 ) #( 1 1 1 ) #( 1 3 3 ) #( 1 4 4 ) ).
	y := #( 1 1 -1 -1 ).

	testInput := #( #( 1 -1 -1 ) #( 1 5 5 ) #( 1 6 6 ) #( 1 7 7 ) ).
	expectedOutput := #( 1 -1 -1 -1 ).
	model regularizationStrenght: 10000.
	model learningRate: 1e-6.
	model maxEpochs: 5000.
	model fitX: x y: y.

	actualOutput := model predict: testInput.

	actualOutput
		with: expectedOutput
		do: [ :actual :expected | self assert: actual equals: expected ]
]
