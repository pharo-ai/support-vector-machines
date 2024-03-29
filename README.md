# Linear Models

[![Build status](https://github.com/pharo-ai/support-vector-machines/workflows/CI/badge.svg)](https://github.com/pharo-ai/support-vector-machines/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/support-vector-machines/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/support-vector-machines?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/support-vector-machines/master/LICENSE)


# support-vector-machines

## How to install it?

To install support vector machines, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'AISupportVectorMachines';
  repository: 'github://pharo-ai/support-vector-machines/src';
  load.
```

## How to depend on it?

If you want to add a dependency on support vector machines to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'AISupportVectorMachines'
  with: [ spec repository: 'github://pharo-ai/support-vector-machines/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

Here's an example of how to use soft margin SVM. For that, open a Playground (CMD+OW) in your Pharo image and execute this code (CMD+A) and then (CMD+PP)

```st
inputMatrix :=#( #( 1 0 0 ) #( 1 1 1 ) #( 1 3 3 ) #( 1 4 4 ) ).
outputVector := #( 1 1 -1 -1 ).

model := AISupportVectorMachines new.
model regularizationStrenght: 10000.
model learningRate: 1e-6.
model maxEpochs: 5000.

model fitX: inputMatrix y: outputVector.

testInput := #( #( 1 -1 -1 ) #( 1 5 5 ) #( 1 6 6 ) #( 1 7 7 ) ).

model predict: testInput  "#(1 -1 -1 -1)"
```

To understand this example and the soft margin svm in general please refer to our [Wiki](https://github.com/pharo-ai/wiki/blob/master/wiki/MachineLearning/Support-Vector-Machines.md).
