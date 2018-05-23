#!/usr/bin/env bash

if [ -z "$APP" ] ; then
	set -e
	export APP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $APP"  >&2
	[ -d "$APP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi

[ -f "$APP/source/myx/util.repository-myx/sh-lib/syncing.sh.include" ] || ()
. "$APP/source/myx/util.repository-myx/sh-lib/syncing.sh.include"

async -2 gitSync "lib/util.repository-lib/"	           "git@github.com:myx-distro-libs/util.repository-lib.git"


INF="$APP/source/lib/util.repository-lib/data/repository/repository.inf"
( set -e ; echo "# copied from $INF at `date`" ; cat "$INF" ) > "$APP/source/lib/repository.inf"

# wait
