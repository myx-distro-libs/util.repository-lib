#!/bin/sh

[ -d "$MMDAPP/source" ] || ( echo "ERROR: expecting 'source' directory." >&2 && exit 1 )

. "$MMDAPP/source/lib/util.repository-lib/sh-scripts/sync-all-sources-lib.sh"
