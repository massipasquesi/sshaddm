#!/usr/bin/env bash
set -e

# cd to sshaddm directory if not inside
cd $(dirname $([ -L $0 ] && readlink -f $0 || echo $0))
# source init.bh
. init.bh


###############################################
## Check ssh_keys's variables                ##
###############################################

# init $check_status
declare -i check_status=0

# 1. # Check '$keys_path' # #
if [ ! -d  "$keys_path" ]; then
    eerror "${keys_path} does not exists or is not a directory";
    check_status=2
fi

# 2. # Check '$keys_names' # #
keys_full_names=""
for key_name in $keys_names; do
    key_full_name="${keys_path}/${keys_prefix}$key_name"
    keys_full_names="${keys_full_names} ${key_full_name}"
    if [ ! -f "$key_full_name" ]; then
        eerror "File not found : ${key_full_name} !";
        if [ $check_status -ne 2 ]; then check_status=2; fi
    fi
done;

if [ $check_status -gt 0 ]; then
    vecho "keys_path = ${keys_path}"
    vecho "keys_prefix = ${keys_prefix}"
    vecho "keys_names = ${keys_names}"
    vecho "[debug] keys_full_names = ${keys_full_names}"
    ewarning "Please verify wrong variables's values and run again sshaddm with -r option : `sshaddm -r`"
    ewarning "Or modify variables's values manually in ${define_file} and run again `sshaddm`"
    #\o/ DEBUG \o/#
    echodebug $(declare -p check_status)
    exit $check_status;
fi


# SCRIPT ENGINE
echo -e "ssh keys : ${keys_full_names}"
goornotgo ; GO=$?
if [ "$GO" != 0 ]; then
    echo "Please change variables's values and run again sshaddm with -r option : `sshaddm -r`"
    echo "Or modify variables's values manually in ${define_file} and run again `sshaddm`"
    exit 1
fi

let "success = -1"
while [ $success != 0 ]; do
    ssh-add $KEYS 2>&1
    let "success = $?"
    case $success in
        0)
            ssh-add -l
            ;;
        1)
            exit $success
            ;;
        2)
            eval `ssh-agent`
            ;;
        \?) 
            echo "What's the Fuck ??"
            exit $success
            ;;
    esac
done

echo -e "VERY GOOD :)\n"
exit 0;
