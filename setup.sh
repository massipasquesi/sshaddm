#!/usr/bin/env bash
set -e

## If $setup var not exists is because `setup.sh` is called manually
# so run with '--setup' mode (write define_file but don't run `sshaddm`)
if [ -z "$setup" ]; then
    setup="only"
fi

# Set Default variables's values for define_file
default_keys_path="${HOME}/.ssh" 

###############################################
## Write variables definition in define_file ##
###############################################

# 1. # Define '$keys_path' # #
vecho "I'll ask you the full path of the ssh_keys's folder."
vecho "No trailing slashes at the end of the path !"
vecho "Leave blank if you want [default=value]"
vecho ""
while [ ! -d  "$keys_path" ]; do
    question=$(cecho "Please enter the full path of the ssh_keys's folder [default=\$HOME/.ssh] : ")
    read -p "$question" keys_path
    if [ "$keys_path" == "" ]; then
        keys_path=$default_keys_path
    fi
    if [ ! -d  "$keys_path" ]; then
        eerror "${keys_path} does not exists or is not a directory";
    fi
done
echo ""

# 2. # Define '$keys_prefix' # #
vecho "I'll ask you (if one exists) the prefix of all your keys."
vecho "Leave blank if you won't to set prefix."
vecho ""
question=$(cecho "Please enter the keys's prefix : ")
read -p "$question" keys_prefix
#: strip whitespaces from $keys_prefix
keys_prefix=${keys_prefix//[[:space:]]}
echo ""

# 3. # Define '$keys_names' # #
vecho "I'll ask you ssh_key's names."
vecho "If you setted \$keys_prefix remove it (${keys_prefix}) from key's name"
vecho "You can enter in one time, separating them with a space"
vecho "Or enter one name at a time"
vecho "If you would like to have a list of key in your keys's directory : ${keys_path}, enter ':ls'"
vecho "Enter ':end' when you've done"
vecho ""
question=$(cecho "Please enter ssh_key(s)'s name(s)' : ")
keys_names=""

while true; do
    read -p "$question" key_name
    if [ "$key_name" == ":ls" ]; then
        ls_keys
    # if user leave blank echo error message
    elif [ "$key_name" == "" -a "$keys_names" == "" ] || [ "$key_name" == ":end" -a "$keys_names" == "" ]; then
        eerror "\$keys_names variable cannot be empty !!!"
    elif [ "$key_name" == "" -a "$keys_names" != "" ] || [ "$key_name" == ":end" -a "$keys_names" != "" ]; then
        break
    else
        # add $key_name to the $keys_names var stripping $keys_prefix if exists
        if [ "$keys_names" == "" ]; then
            keys_names="$key_name"
        else
            keys_names="${keys_names} $key_name"
        fi
    fi
done


# unset loop's variable $key_name and $question
unset key_name question

# 4. # Write to $define_file if asked # #
if [ "$setup" != "temp" ]; then
    ## If setup.sh is called is always to write oe re-write define_file
    # so remove if it exists
    if [ -f "$define_file" ] ; then
        # if already exists delete the file
        rm -v "$define_file"
    fi
    # Create new empty define_file
    touch "$define_file"

    echo "#!/usr/bin/env bash" >> "$define_file"
    echo "set -e" >> "$define_file"
    echo "" >> "$define_file"
    echo "keys_path=\"${keys_path}\"" >> "$define_file"
    echo "keys_prefix=\"${keys_prefix}\"" >> "$define_file"
    echo "keys_names=\"${keys_names}\"" >> "$define_file"
    vcat "$define_file"
else
    vechovars "keys_path" "keys_prefix" "keys_names"
fi