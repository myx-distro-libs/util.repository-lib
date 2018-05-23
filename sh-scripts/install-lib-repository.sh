#!/bin/sh

####
## Note: this is a special script that is designed 
##       to run stand-alone (no location on local 
##       file-system) and on un-prepared OS. 
####

TGT_APP_PATH="${TGT_APP_PATH:-$1}"
test -z "$TGT_APP_PATH" && echo "'TGT_APP_PATH' env must be set" >&2 && exit 1

#
#
# It will make sure that "myx.common" utility is installed and will install "myx/myx.distro-install" package into workspace
#
#

##########################
echo "Installing myx.common"

FetchStdout(){
	local URL="$1"
	[ -z "$URL" ] && echo "FetchStdout: The URL is required!" && exit 1
	set -e

	if [ ! -z "`which curl || true`" ]  ; then curl --silent -L $URL  ; return 0 ; fi
	if [ ! -z "`which fetch || true`" ] ; then fetch -o - $URL        ; return 0 ; fi
	if [ ! -z "`which wget || true`" ]  ; then wget --quiet -O - $URL ; return 0 ; fi

	echo "ERROR: curl, fetch or wget were not found, do not know how to download!"
	exit 1
}

FetchStdout https://raw.githubusercontent.com/myx/os-myx.common/master/sh-scripts/install-myx.common.sh -o - | sh -e

##########################
echo "Installing packages"

for PKG in bash git ; do
	myx.common lib/installEnsurePackage $PKG
done

###########################################################
echo "Installing LIB repository into: $TGT_APP_PATH"

export APP="$TGT_APP_PATH"

myx.common lib/gitCloneSync "$APP/source/lib/util.repository-lib" "git@github.com:myx-distro-libs/util.repository-lib.git"

############
echo "Done."