"
I implement the soft margin of Support Vector Machines with Stochastic Gradient Descent.
"
Class {
	#name : #AISupportVectorMachinesSoftSGD,
	#superclass : #Object,
	#instVars : [
		'weights',
		'regularizationStrenght',
		'maxEpochs',
		'learningRate'
	],
	#category : #'AI-SupportVectorMachines'
}

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> calculateCostGradientX: inputMatrix y: outputVector [

	| distance dw di numberOfRows output input |
	numberOfRows := inputMatrix size.

	outputVector isCollection
		ifTrue: [ output := outputVector.
			input := inputMatrix ]
		ifFalse: [ output := outputVector asOrderedCollection.
			input := Array with: inputMatrix ].

	distance := self calculateDistancesForX: input y: output.

	dw := OrderedCollection new: weights size withAll: 0.

	distance doWithIndex: [ :d :ind | 
		di := d <= 0
			ifTrue: [ weights ]
			ifFalse: [ weights - (regularizationStrenght * (input at: ind) * (output at: ind)) ].
		dw := dw + di ].
	dw := dw / output size.

	^ dw
]

{ #category : #'as yet unclassified' }
AISupportVectorMachinesSoftSGD >> calculateDistancesForX: inputMatrix y: outputVector [

	| xDotWeights |
	xDotWeights := inputMatrix collect: [ :row | (row * weights) sum ].
	^ 1 - (outputVector * xDotWeights)
]

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> computeCostX: inputMatrix y: outputVector [

	| numberOfRows distances hingeLoss cost |
	numberOfRows := inputMatrix size.

	distances := self calculateDistancesForX: inputMatrix y: outputVector.

	distances := distances collect: [ :each | each max: 0 ].

	hingeLoss := regularizationStrenght * distances average.

	cost := weights squared sum / 2 + hingeLoss.
	^ cost
]

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> learningRate: aNumber [ 
	learningRate := aNumber  
]

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> maxEpochs: aNumber [ 
	maxEpochs := aNumber  
]

{ #category : #'as yet unclassified' }
AISupportVectorMachinesSoftSGD >> predict: inputMatrix [

	| prediction |
	prediction := self signFunction: inputMatrix.

	^ prediction asOrderedCollection collect: [ :each | 
		  each > 0 
			  ifTrue: [ 1 ]
			  ifFalse: [ -1 ] ]
]

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> regularizationStrenght: aNumber [ 
	regularizationStrenght := aNumber 
]

{ #category : #'as yet unclassified' }
AISupportVectorMachinesSoftSGD >> sgdWithStoppageCriterionX: inputMatrix y: outputVector [

	| ascent nth prev_cost cost cost_threshold weightsAllAlong |
	weightsAllAlong := OrderedCollection new.
	nth := 0.
	prev_cost := Float infinity.
	cost_threshold := 0.01.
	weights := OrderedCollection new: inputMatrix shape1 withAll: 0.
	1 to: maxEpochs do: [ :epoch |
		inputMatrix shuffled.
		outputVector shuffled.
		inputMatrix doWithIndex: [ :x :ind | 
			ascent := self calculateCostGradientX: x y: (outputVector at: ind).
			weights := weights - (learningRate * ascent) ].
			(epoch = (2 ** nth) or: [ epoch = (maxEpochs - 1) ]) ifTrue: [ 
				cost := self computeCostX: inputMatrix y: outputVector.
				(prev_cost - cost) abs < (cost_threshold * prev_cost) ifTrue: [  weightsAllAlong add: weights].
				prev_cost := cost.
				nth := nth + 1 
				] 
	].

^ weightsAllAlong 
]

{ #category : #'as yet unclassified' }
AISupportVectorMachinesSoftSGD >> sgdX: inputMatrix y: outputVector [

	| ascent |
	
	weights := OrderedCollection new: inputMatrix shape1 withAll: 0.
	1 to: maxEpochs do: [ :epoch |
		inputMatrix shuffled.
		outputVector shuffled.
		inputMatrix doWithIndex: [ :x :ind | 
			ascent := self calculateCostGradientX: x y: (outputVector at: ind).
			weights := weights - (learningRate * ascent) ] ]
]

{ #category : #'as yet unclassified' }
AISupportVectorMachinesSoftSGD >> signFunction: inputMatrix [

	| constraints |
	constraints := inputMatrix collect: [ :e | (weights * e) sum].
	

]

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> weights [
	^weights  
]

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> weights: aCollection [ 
	weights := aCollection 
]
