#!/bin/bash

# script keeps one snapshot of the $LV alive
# messages are output only on error (notifications via cron)

set -o errexit
set -o nounset
set -o pipefail

VG="vg"
LV="home"
SNAPSHOT_SUBSTRING="_auto_"
SNAPSHOT_SIZE="50%FREE" # it's weird but I don't want to hardcode a size
ISO_TODAY="$( date -I )"

function delete_every_autosnapshot_except_last_one() {
    local SNAP
    for SNAP in $( lvs -o name --noheadings --select "origin=${LV},name=~${SNAPSHOT_SUBSTRING}" |
        sort -V | head -n -1 ); do
        # this will fail if filesystem is mounted. but eventually snapshot will
        # be removed
        lvremove -f "${VG}/${SNAP}" | grep -v 'successfully removed' || true
    done
}

function main() {
    # try to put snapshot list into a predictable state (so that only the latest snapshot exists)
    # we cannot remove old snapshots only once at the end of the script, because we might not
    # get there, and having an endlessly growing list is painful
    delete_every_autosnapshot_except_last_one || true
    lvcreate --name "${VG}/${LV}${SNAPSHOT_SUBSTRING}${ISO_TODAY}" \
        --permission r \
        --extents "${SNAPSHOT_SIZE}" \
        --snapshot "${VG}/${LV}" | grep -vP "Logical volume [^ ]+ created." || true
    delete_every_autosnapshot_except_last_one
}

main
