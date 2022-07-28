Class {
	#name : #AISupportVectorMachinesSoftSGD,
	#superclass : #Object,
	#instVars : [
		'weights',
		'regularizationStrenght'
	],
	#category : #'AI-SupportVectorMachines'
}

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> calculateCostGradientX: inputMatrix y: outputVector [

	| distance dw di numberOfRows |
	numberOfRows := inputMatrix size.
	distance := self calculateDistancesForX: (inputMatrix asArray) y: (outputVector asArray).

	dw := (OrderedCollection new: outputVector size withAll: 0) asArray.
	
	distance doWithIndex: [ :d :ind | d < 0
		ifTrue: [ di := weights ] 
		ifFalse: [di :=  weights - (regularizationStrenght * (inputMatrix at: ind ) * (outputVector at: ind )) ].
		dw := dw + di].
		dw := dw / outputVector size.
	^ dw



"	1 to: distance size do: [ :i |
		1halt.
		[
		distance collect: [ :each | each < 0
				      ifTrue: [ di := weights ]
				      ifFalse: [ weights - (regularizationStrenght * (inputMatrix at: i) * (outputVector at: i)) ]
				].
						dw := dw + di ] ].
	"
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
AISupportVectorMachinesSoftSGD >> regularizationStrenght: aNumber [ 
	regularizationStrenght := aNumber 
]

{ #category : #accessing }
AISupportVectorMachinesSoftSGD >> weights: aCollection [ 
	weights := aCollection 
]
