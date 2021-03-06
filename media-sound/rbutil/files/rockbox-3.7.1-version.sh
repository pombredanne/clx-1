#!/bin/sh
#             __________               __   ___.
#   Open      \______   \ ____   ____ |  | _\_ |__   _______  ___
#   Source     |       _//  _ \_/ ___\|  |/ /| __ \ /  _ \  \/  /
#   Jukebox    |    |   (  <_> )  \___|    < | \_\ (  <_> > <  <
#   Firmware   |____|_  /\____/ \___  >__|_ \|___  /\____/__/\_ \
#                     \/            \/     \/    \/            \/
# $Id: version.sh 28653 2010-11-23 22:15:00Z gevaerts $
#

# Usage: version.sh [source-root]

# Prints the revision of the repository.
#
# The format is rNNNNN[M]-YYMMDD
#
# The M indicates the revision isn't matched to a pure Subversion ID, usually
# because it's built from something like GIT.

svnversion_safe() {
    # LANG=C forces svnversion to not localize "exported".
    if OUTPUT=`LANG=C svnversion "$@"`; then
        if [ "$OUTPUT" = "exported" ]; then
            echo "unknown"
        else
            echo "r$OUTPUT"
        fi
    else
        echo "unknown"
    fi
}

# This logic is pulled from the Linux's scripts/setlocalversion (also GPL) and tweaked for
# rockbox. If the commit information for HEAD has a svn-id in it we report that instead of
# the git id
gitversion() {
    export GIT_DIR="$1/.git"

    # This verifies we are in a git directory
    if head=`git rev-parse --verify --short HEAD 2>/dev/null`; then

	# Get the svn revision of the most recent git-svn commit
	version=`git log --pretty=format:'%b' --grep='git-svn-id: svn' -1 | tail -n 1 | perl -ne 'm/@(\d*)/; print "r" . $1;'`
	mod=""
	# Is this a git-svn commit?
	if ! git log  HEAD^.. --pretty=format:"%b" | grep -q "git-svn-id: svn" ; then
	    mod="M"
	# Are there uncommitted changes?
	else
	    export GIT_WORK_TREE="$1"
	    if git diff --name-only HEAD | read dummy; then
		mod="M"
	    elif git diff --name-only --cached HEAD | read dummy; then
		mod="M"
	    fi
	fi

	echo "${version}${mod}"
	# All done with git
	exit
    fi
}

# Work out the latest svn id and also the latest bzr revno
bzrversion() {

    # look for a svn revno in the current head
    svnver=`LANG=C bzr log -l1 $1 | grep '^ *svn revno: ' | cut -d : -f2 | cut -d ' ' -f 2`

    if [ -n "$svnver" ]; then
        # current head is a svn version so we don't care about bzr
        version="r$svnver"
    else
        # look for a svn revno anywhere in history including in merges
        svnver=`LANG=C bzr log -n0 $1 | grep '^ *svn revno: ' | head -n 1 | cut -d : -f2 | cut -d ' ' -f 2`
        if [ -n "$svnver" ]; then
            version="r$svnver+bzr`bzr revno $1`"
        else
            version="bzr`bzr revno $1`"
        fi
    fi
    if ! bzr diff $1 >/dev/null; then
        mod="M"
    fi
    echo "${version}${mod}"
}

# XXX: Don't run the scripts and just display the release version
echo "3.7.1"
exit 0

#
# First locate the top of the src tree (passed in usually)
#
if [ -n "$1" ]; then TOP=$1; else TOP=..; fi

# If the VERSIONFILE exisits we use that
VERSIONFILE=docs/VERSION
if [ -r $TOP/$VERSIONFILE ]; then VER=`cat $TOP/$VERSIONFILE`; 
else
    # Ok, we need to derive it from the Version Control system
    if [ -d "$TOP/.git" ]; then
	VER=`gitversion $TOP`
    elif [ -d "$TOP/.bzr" ]; then
	VER=`bzrversion $TOP`
    else
	VER=`svnversion_safe $TOP`;
	if [ "$VER" = "unknown" ]; then
        # try getting it from a subdir to test if perhaps they are symlinked
        # from the root
        VER=`svnversion_safe $TOP/tools`;
	fi
    fi
fi
VERSION=$VER-`date -u +%y%m%d`
echo $VERSION

