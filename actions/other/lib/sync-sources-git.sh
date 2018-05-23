#!/bin/sh

if [ -z "$APP" ] ; then
	set -e
	APP="$( cd $(dirname "$0")/../../../../../.. ; pwd )"
	echo "$0: Working in: $APP"  >&2
	[ -d "$APP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi

. "$APP/source/lib/util.repository-lib/sh-scripts/sync-all-sources-lib.sh"