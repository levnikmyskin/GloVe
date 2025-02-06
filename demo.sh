#!/bin/bash
set -e


make

CORPUS=../../glove_trajectories_alldata.txt
VOCAB_FILE=../../vocab.txt
COOCCURRENCE_FILE=../../cooccurrence.bin
COOCCURRENCE_SHUF_FILE=../../cooccurrence.shuf.bin
BUILDDIR=build
SAVE_FILE=vectors
VERBOSE=2
MEMORY=24.0
VOCAB_MIN_COUNT=5
VECTOR_SIZE=100
MAX_ITER=25
WINDOW_SIZE=15
BINARY=2
NUM_THREADS=13
X_MAX=100
if hash python 2>/dev/null; then
    PYTHON=python
else
    PYTHON=python3
fi

echo
echo "$ $BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CORPUS > $VOCAB_FILE"
$BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CORPUS > $VOCAB_FILE
echo "$ $BUILDDIR/cooccur -memory $MEMORY -vocab-file $VOCAB_FILE -verbose $VERBOSE -window-size $WINDOW_SIZE < $CORPUS > $COOCCURRENCE_FILE"
$BUILDDIR/cooccur -memory $MEMORY -vocab-file $VOCAB_FILE -verbose $VERBOSE -window-size $WINDOW_SIZE < $CORPUS > $COOCCURRENCE_FILE
echo "$ $BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $COOCCURRENCE_FILE > $COOCCURRENCE_SHUF_FILE"
$BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $COOCCURRENCE_FILE > $COOCCURRENCE_SHUF_FILE
