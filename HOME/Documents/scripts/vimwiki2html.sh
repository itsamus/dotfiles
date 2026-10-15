#!/bin/bash
FORCE=$1
SYNTAX=$2
EXTENSION=$3
OUTPUT_DIR=$4
INPUT_FILE=$5
CSS_FILE=$6
TEMPLATE_PATH=$7
TEMPLATE_DEFAULT=$8
TEMPLATE_EXT=$9
ROOT_PATH=${10}
CUSTOM_ARGS=${11}

FILENAME=$(basename "$INPUT_FILE")
BASENAME="${FILENAME%.*}"
mkdir -p "$OUTPUT_DIR"

TEMPLATE_FILE="$TEMPLATE_PATH/$TEMPLATE_DEFAULT$TEMPLATE_EXT"
CURRENT_DATE=$(date "+%Y-%m-%d")

# Voer pandoc uit inclusief de custom args indien aanwezig
EXTRA_ARGS=""
if [ "$CUSTOM_ARGS" != "-" ]; then
    EXTRA_ARGS="$CUSTOM_ARGS"
fi

pandoc "$INPUT_FILE" \
    -f markdown \
    -t html \
    -s \
    --template="$TEMPLATE_FILE" \
    --metadata="path:$FILENAME" \
    --metadata="date:$CURRENT_DATE" \
    --metadata="root_path:$ROOT_PATH" \
    $EXTRA_ARGS \
    -o "$OUTPUT_DIR/$BASENAME.html"
