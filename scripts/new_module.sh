#!/usr/bin/env bash
set -e

if [ $# -ne 3 ]; then
  echo "Usage: $0 <module|test|tb> <name> <project>"
  exit 1
fi

TYPE=$1
NAME=$2
PROJECT=$3

DEST=""
TEMPLATE=""
FILENAME=""

if [ "$TYPE" = "module" ]; then
  DEST="src/$PROJECT/rtl"
  TEMPLATE="templates/module.v.tpl"
  FILENAME="$NAME.v"

elif [ "$TYPE" = "tb" ]; then
  DEST="src/$PROJECT/tb"
  TEMPLATE="templates/tb.v.tpl"
  FILENAME="${NAME}_tb.v"

elif [ "$TYPE" = "test" ]; then
  DEST="src/$PROJECT/test"
  TEMPLATE="templates/test.v.tpl"
  FILENAME="${NAME}_test.v"

else
  echo "Unknown type '$TYPE'"
  exit 1
fi

mkdir -p "$DEST"

# escape sed replacement special chars (/, &)
esc_name=$(printf '%s' "$NAME" | sed -e 's/[\/&]/\\&/g')
esc_proj=$(printf '%s' "$PROJECT" | sed -e 's/[\/&]/\\&/g')

sed "s/{{NAME}}/$esc_name/g; s/{{PROJ}}/$esc_proj/g" "$TEMPLATE" > "$DEST/$FILENAME"

echo "$TYPE '$NAME' created in project '$PROJECT'"
echo "→ $DEST/$FILENAME"
