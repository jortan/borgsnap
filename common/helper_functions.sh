#!/bin/sh
# helper_functions.sh  - licensed under GPLv3. See the LICENSE file for additional
# details.
# shellcheck disable=SC3043
if [ -z "${HELPER_FUNCTIONS_SOURCED+x}" ]; then
    export HELPER_FUNCTIONS_SOURCED=1  
    
    . ./msg_and_err_hdlr.sh 
    
    if [ -z "${LASTFUNC+x}" ]; then
        export LASTFUNC=""
    fi

    if [ -z "${MSG_DEFINED+x}" ]; then
        msg() {
            LASTFUNC="msg"
            printf "WARNING: msg() function called without invoking the debugging.sh script or explicit disabling it!\n"
            printf "WARNING: No debug or verbose message outputs available!\n"
            return 0
        }
        export MSG_DEFINED=1
    fi

    set -u
    msg "DEBUG" "-----------------------------------------------"
    msg "helper_functions.sh invoked"
    msg "DEBUG" "-----------------------------------------------"

    chkDateStr() {
        LASTFUNC="chkDateStr"
        chkDateStr_datestr="$1"

        if echo "$chkDateStr_datestr" | grep -qE '[0-9]{8}'; then
            msg "DEBUG" "$chkDateStr_datestr contains a date."
            unset chkDateStr_datestr
            return 0     
        elif [ "$chkDateStr_datestr" = "daily" ] || [ "$chkDateStr_datestr" = "weekly" ] || [ "$chkDateStr_datestr" = monthly ]; then
            msg "DEBUG" "$chkDateStr_datestr contains a backup interval."
            unset chkDateStr_datestr
            return 1     
        else
            msg "ERROR" "$chkDateStr_datestr does not contain a date or valid backup interval name."
            unset chkDateStr_datestr
            return 2
        fi
        

        }
fi