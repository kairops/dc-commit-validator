#!/bin/bash

# Valid categories sorted in relevance order
#
#   Breaking - for a backwards-incompatible enhancement.
#   New - implemented a new feature.
#   Upgrade - for a dependency upgrade.
#   Update - for a backwards-compatible enhancement.
#   Fix - for a bug fix.
#   Build - changes to build process only.
#   Docs - changes to documentation only.
#   Security - for security skills.
#   Deprecated - for deprecated features.

set -eo pipefail

function echo_err () {
    echo >&2 -e "$@"
}
function echo_debug () {
    if [ "$KD_DEBUG" == "1" ]; then
        echo >&2 ">>>> DEBUG >>>>> $(date "+%Y-%m-%d %H:%M:%S") $KD_NAME: $@"
    fi
}
KD_NAME="commit-validator"
echo_debug "begin"

function getNumberByType() {
    case $1 in
        'Breaking:') number=0;;
        'New:') number=1;;
        'Upgrade:') number=2;;
        'Update:') number=3;;
        'Fix:') number=4;;
        'Build:') number=5;;
        'Docs:') number=6;;
        'Security:') number=7;;
        'Deprecated:') number=8;;
        *) number=-1;;
    esac
    echo -n $number
}

function validateCommit() {
    local commit=$1
    echo_debug "Checking commit $commit"
    type=$(echo $commit|awk '{print $2}')
    message=$(echo $commit|awk '{ print substr($0, index($0,$3)) }')
    number=$(getNumberByType $type)
    if [ $number -eq -1 ]; then
        echo_err "Error: Commit messager does not fulfill rules in commit '${commit}'"
        echo "$commitList"
        echo_debug "end"
        exit 1
    fi
}

function validateRepository() {
    local lastTag=$(git describe --tags `git rev-list --tags --max-count=1` 2> /dev/null || echo '')
    if [ "$lastTag" == "" ]; then
        local commitRange="HEAD"
    else
        local commitRange="${lastTag}..HEAD"
    fi

    echo_debug "Using commit messages of '${commitRange}'"

    # Initalizacion
    OLDIFS="$IFS"
    IFS=$'\n' # bash specific
    commitList=$(git log ${commitRange} --no-merges --pretty=format:"%h %s")
    for commit in $commitList
    do
        validateCommit $commit
    done
    echo_debug "All commits OK"
    IFS="$OLDIFS"
}

validateRepository .
echo_debug "end"
