"
An AISupportVectorMachinesQPTest is a test class for testing the behavior of AISupportVectorMachinesQP
"
Class {
	#name : #AISupportVectorMachinesQPTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'AI-SupportVectorMachines-Tests'
}

{ #category : #test }
AISupportVectorMachinesQPTest >> setUp [

	super setUp.

	model := self supportVectorMachines
]

{ #category : #tests }
AISupportVectorMachinesQPTest >> supportVectorMachines [

	^ AISupportVectorMachinesQP new
]

{ #category : #test }
AISupportVectorMachinesQPTest >> testPXYInnerProducts [

	| input output pResult pxMethod |
	input := #( #( 0 0 ) #( 1 1 ) #( 3 3 ) #( 4 4 ) ).
	output := #( 1 1 -1 -1 ).


	"pResult := #( 0 0 0 6 8 24 ) asOrderedCollection."

	pResult := #( 0 0 0 -6 -8 24 ) asOrderedCollection.

	pxMethod := model pX: input y: output.
	self assert: pxMethod equals: pResult
]

{ #category : #test }
AISupportVectorMachinesQPTest >> testQVector [

	| input qResult qVectorMethod |
	input := #( #( 0 0 ) #( 1 1 ) #( 3 3 ) #( 4 4 ) ).

	"qResult := #( (#(-1) -1 -1 -1 ) asGVector."
	qResult := #(#(-1)#(-1)#(-1)#(-1)) asGVector.
	qVectorMethod := model qVector: input.
	self assert: qVectorMethod equals: qResult
]
