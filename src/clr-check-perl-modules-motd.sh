#!/bin/sh

if [ -n "$1" ]; then
	echo "Usage: $0"
	echo "    Creates motd parts for notifying the user about outdated Perl modules."
	echo "    This program takes no options"
	exit 0
fi

MOTDD="/run/motd.d"
MOTDF="$MOTDD/clr-check-perl-modules.motd"

mkdir -p "$MOTDD"

if [ -n "`clr-check-perl-modules -q 2>&1`" ]; then
	echo -e " * Some Perl modules may need to be updated.\n   Run \`clr-check-perl-modules\` to view them." > "$MOTDF"
else
	> "$MOTDF"
fi
