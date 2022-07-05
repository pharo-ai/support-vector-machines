"
I implement the hard margin of Support Vector Machines with Quadratic Programming. I'll be refactored to strategy pattern for the next margin (soft margin)
"
Class {
	#name : #AISupportVectorMachinesQP,
	#superclass : #Object,
	#instVars : [
		'weights',
		'bias',
		'supportVectorsCollection'
	],
	#category : #'AI-SupportVectorMachines'
}

{ #category : #api }
AISupportVectorMachinesQP >> fitX: inputMatrix y: outputVector [

	| m p q a b h |
	m := inputMatrix size.
	p := self pX: inputMatrix y: outputVector.
	q := [ 1 to: inputMatrix size do: [:x| -1 ] ].
	a := outputVector transposed.
	b := 0.
	"g := "
	h := [ 1 to: inputMatrix size do: [ ^ 0 ] ] asOrderedCollection
	"solution := import from Python"
	"alphas := solution collect: 'x'."
]

{ #category : #api }
AISupportVectorMachinesQP >> pX: inputMatrix y: outputVector [

	"dot each x with its y"

	| innerProducts dotProduct x_i x_j y_i y_j dotProductWithY |
	supportVectorsCollection := OrderedCollection new.

	inputMatrix
		with: outputVector
		collect: [ :y :x | supportVectorsCollection add: y * x ].

	"^ supportVectorsCollection"


	innerProducts := OrderedCollection new.


	1 to: inputMatrix size do: [ :i | 
		i + 1 to: inputMatrix size do: [ :j |
			y_i := outputVector at: i.
			y_j := outputVector at: j.
			x_i := (inputMatrix at: i) asGVector.
			x_j := (inputMatrix at: j) asGVector.
			dotProduct := x_i dotProduct: x_j.
			dotProductWithY := y_i * y_j * dotProduct.
			innerProducts add: dotProductWithY ] ].


	"dot each xy with the rest of xys"
	"1 to: supportVectorsCollection size do: [ :xy1 | 
		1 to: supportVectorsCollection size do: [ :xy2 | 
			dot := xy1 * xy2.
			innerProducts add: dot.
			] ]."

	"result := innerProducts : [ :xy1 :xy2 | 
		          result := xy1 * xy2.
		          innerProducts add: result ].
	^ innerProducts"

	^ innerProducts
]

{ #category : #acccessing }
AISupportVectorMachinesQP >> qVector:inputMatrix [

| minusOnes |

minusOnes := OrderedCollection new .
"inputMatrix := Array2D new: 4."
"1 to: inputMatrix size do: [ -1 ]"
 1 to: inputMatrix size do: [ :x| -1 . minusOnes add: x.^ minusOnes]

]
