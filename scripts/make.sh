#!/usr/bin/env bash
#
# Environment variables:
#
# * `NODE_INSTALLER`: Which Node.js package manager to use (`yarn` or `npm`). Defaults to detecting
#   which package manager was used on the app via `yarn-or-npm` (which is used by Electron Forge).
#

set -e

args=(
  --targets
  "$TARGET_MAKER"
  --platform
  "$TARGET_PLATFORM"
)

# Check if PACKAGE_ROOT is set, if so, cd into it (`npm run make` doesn't have arguments to specify cwd)
if [[ -n "$PACKAGE_ROOT" ]]; then
  cd "$PACKAGE_ROOT"
fi

# Check for SKIP_PACKAGE
if [[ "$SKIP_PACKAGE" = "true" ]]; then
  args=( ${args[@]} --skip-package )
fi

if [[ -n "$TARGET_ARCH" ]]; then
  args=( ${args[@]} --arch "$TARGET_ARCH" )
fi

if [[ "$NODE_INSTALLER" = "npm" ]]; then
  npm run make -- "${args[@]}"
elif [[ "$NODE_INSTALLER" = "yarn" ]]; then
  yarn make "${args[@]}"
else
  "$(npm bin)"/yarn-or-npm run make -- "${args[@]}"
fi
