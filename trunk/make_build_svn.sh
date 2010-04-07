#!/bin/sh
#	\file make_build_svn.sh
#	\brief build.h file generator.
#	\author AG
#

#set -x

get_build() {
	LANG=C
	SVN_REV_LIST=`svn info -R . | grep "Last Changed Rev" | sed -e "s/Last Changed Rev: //"`

	if test -z "$SVN_REV_LIST"
	then
		echo "none"
		return 1
	fi

	MAX=0

	for i in $SVN_REV_LIST
	do
		if test $MAX -lt $i
		then
			MAX=$i
		fi
	done

	echo $MAX
	return 0
}

# Getting build number
BUILD=`get_build`

# Opening file if first argument given
if test ! -z "$1"
then
	exec 1<> "$1"
fi

# Generating h-file
cat <<-EOF
/*!
	\file $1
	\brief Build number file.
	This file is automatically generated by $0 in build time from
	a last SVN revision number in directory tree.
	WARNING! All changes made here will be lost.
*/
#ifndef CZ_BUILD_H
#define CZ_BUILD_H

EOF

#BUILD=none

if test x"$BUILD" = x"none"
then
	echo "/* WARNING! Cannot detect SVN revision number. */"
else
	echo "#define CZ_VER_BUILD		$BUILD	/*!< SVN revision numeric constant. */"
	echo "#define CZ_VER_BUILD_STRING	\"$BUILD\"	/*!< SVN revision string constant. */"
fi

cat <<-EOF

#endif//CZ_BUILD_H
EOF

#return 0
