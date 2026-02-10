#!/usr/bin/env bash
set -e

if [ $# -ne 1 ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

NAME=$1
ROOT="src/$NAME"

if [ -d "$ROOT" ]; then
  echo "Project '$NAME' already exists"
  exit 1
fi

echo "Creating project: $NAME"

mkdir -p \
  $ROOT/rtl \
  $ROOT/tb \
  $ROOT/test \
  $ROOT/build \
  $ROOT/waves \
  $ROOT/logs

# Copy templates
# Escape sed replacement special chars (/, &)
esc_name=$(printf '%s' "$NAME" | sed -e 's/[\/&]/\\&/g')

sed "s/{{NAME}}/$esc_name/g; s/{{PROJ}}/$esc_name/g" templates/module.v.tpl > $ROOT/rtl/$NAME.v
sed "s/{{NAME}}/$esc_name/g; s/{{PROJ}}/$esc_name/g" templates/tb.v.tpl > $ROOT/tb/${NAME}_tb.v
sed "s/{{NAME}}/$esc_name/g; s/{{PROJ}}/$esc_name/g" templates/test.v.tpl > $ROOT/test/${NAME}_test.v

# Copy Makefile template
# Do not create per-project Makefiles; root Makefile manages projects centrally.
# If a project needs overrides, create `project.mk` inside the project directory.

echo "Project '$NAME' created at $ROOT"