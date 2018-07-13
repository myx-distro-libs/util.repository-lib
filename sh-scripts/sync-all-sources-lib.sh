#!/usr/bin/env bash

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi


. "`myx.common which lib/async`"
. "`myx.common which lib/gitCloneSync`"

async(){
	Async -2 GitCloneSync "$MMDAPP/source/$@"
}

async "lib/util.repository-lib/"	    		"git@github.com:myx-distro-libs/util.repository-lib.git"

async "lib/lib.apache-commons-compress/"	    "git@github.com:myx-distro-libs/lib.apache-commons-compress.git"
async "lib/lib.tukaani-xz-java/"			    "git@github.com:myx-distro-libs/lib.tukaani-xz-java.git"

wait

INF="$MMDAPP/source/lib/util.repository-lib/data/repository/repository.inf"
( set -e ; echo "# copied from $INF at `date`" ; cat "$INF" ) > "$MMDAPP/source/lib/repository.inf"
