#!/usr/bin/env bash

if [ -z "$APP" ] ; then
	set -e
	export APP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $APP"  >&2
	[ -d "$APP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi


. "`myx.common which lib/async`"
. "`myx.common which lib/gitCloneSync`"

async(){
	Async -2 GitCloneSync "$@"
}

async "lib/util.repository-lib/"	           "git@github.com:myx-distro-libs/util.repository-lib.git"

wait

INF="$APP/source/lib/util.repository-lib/data/repository/repository.inf"
( set -e ; echo "# copied from $INF at `date`" ; cat "$INF" ) > "$APP/source/lib/repository.inf"
