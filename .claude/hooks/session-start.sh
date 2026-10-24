#!/bin/bash
set -euo pipefail

# Only run in Claude Code cloud sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}"

VENV_DIR=".venv"
PYTHON_VERSION="3.14"

if command -v uv >/dev/null 2>&1; then
  [ -x "$VENV_DIR/bin/python" ] || uv venv -q --python "$PYTHON_VERSION" "$VENV_DIR"
  uv pip install -q --python "$VENV_DIR/bin/python" -r requirements.txt -r requirements.dev.txt
else
  [ -x "$VENV_DIR/bin/python" ] || "python$PYTHON_VERSION" -m venv "$VENV_DIR"
  "$VENV_DIR/bin/python" -m pip install -q -r requirements.txt -r requirements.dev.txt
fi

if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  echo "export VIRTUAL_ENV=\"$PWD/$VENV_DIR\"" >> "$CLAUDE_ENV_FILE"
  echo "export PATH=\"$PWD/$VENV_DIR/bin:\$PATH\"" >> "$CLAUDE_ENV_FILE"
fi

# Report wemake-python-styleguide violations without failing session start
"$VENV_DIR/bin/python" -m flake8 app tests --select=WPS || echo "WPS: violations found, see above" >&2
