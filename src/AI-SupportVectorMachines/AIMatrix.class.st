Class {
	#name : #AIMatrix,
	#superclass : #Array,
	#type : #variable,
	#category : #'AI-SupportVectorMachines'
}

{ #category : #'instance creation' }
AIMatrix class >> from: aCollection [

	| matrix |
	matrix := self new: aCollection size.

	1 to: aCollection size do: [ :i | 
	matrix at: i put: (aCollection at: i) ].

	^ matrix
]

{ #category : #'instance creation' }
AIMatrix >> from: aCollection [

	| matrix |
	matrix := self new: aCollection size.
	
	1 to: aCollection size do: [ :i |
		matrix at: i put: (aCollection at: i) ].
	
	^ matrix
	
]

{ #category : #accessing }
AIMatrix >> numberOfColumns [

	^ self ifNotEmpty: [ self first size ] ifEmpty: [ 0 ]
]

{ #category : #accessing }
AIMatrix >> numberOfRows [ 

	^ self size 
]
