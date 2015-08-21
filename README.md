# SSHADDM

### ssh-add multi-keys bash script ###

### [VERSION](https://github.com/massipasquesi/sshaddm/blob/master/VERSION.md) :warning: ###
:heavy_exclamation_mark: :zero:**.**:one:**-DEV** :heavy_exclamation_mark: 
:boom:  **This is a DEV version, so NO STABLE version** :construction:

This bash script 'sshaddm' help you to add multiples keys to your ssh-agent with only one command.

**It run correctly if you have the same passphrase for all yours keys you want to add in one time !!**

**_In next version I'll add the possibility to add keys by passphrase's group ..._**

Take a look at [TODO.md](https://github.com/massipasquesi/sshaddm/blob/master/TODO.md) ;)

## REQUIREMENTS

### OPERATING SYSTEM ###

Tested on **Ubuntu/Debian**

### DEPENDS ###

+ **_openssh-client_**  
> how verify : 
> ```dpkg -s openssh-client```
> how install (**But Normally you would not be here if you don't know what is _openssh-client_ and how it runs ;)**) :
> ``` sudo apt-get install openssh-client```

## INSTALL

```bash
SSHADDM-DIR-NAME="The name you want for sshaddm directory"
git clone https://github.com/massipasquesi/sshaddm.git $SSHADDM-DIR-NAME
```

if you want sshaddm works everywhere,  
you can create a symlink to sshaddm.sh in /usr/local/bin or /usr/bin (depends on your $PATH environment variable)

```bash
sudo ln -s $SSHADDM-DIR-NAME/sshaddm.sh /usr/local/bin/sshaddm
```

## RUN

```bash
cd $SSHADDM-DIR-NAME/
./sshaddm.sh
```

or if you made the symlink  
you can run it from everywhere with simply `sshaddm` command :

```bash
sshaddm
```

When you run sshaddm for the first time you'll invited to set configuration variables from the prompt.

You can set variables manually by copying 'define.example' and naming it 'define.rc' into $SSHADDM-DIR-NAME  
and set variables like explained in this CONFIG section below.

Everytime you want to change configuration variables you can do it manually or running 'setup.sh'

```bash
sshaddm -s
# OR
sshaddm --setup
# OR
cd $SSHADDM-DIR-NAME && ./setup.sh
```

## CONFIG

*define $keys\_path : path to yours ssh_keys. No trailing slashs at the end of the path !*

```bash
# exemple : all your keys in "your home"/.ssh directory
keys_path="${HOME}/.ssh"
```

*If all your keys have the same prefix -> set $keys\_prefix.*
*If not set to empty string : ""*

```bash
# exemple : all your keys's names are prefixed by "id_dsa_" :
keys_prefix="id_dsa_"
# exemple : keys's names have differents prefix or they don't have any :
keys_prefix=""
```

*Define $keys\_names : list ok keys's names separated by a space.*
*If you setted $keys\_prefix remove it from key's name*

```bash
# exemple : all your keys's names have the same prefix $keys_prefix like :
# id_dsa_firstkey, id_dsa_secondkey, id_dsa_thirdkey
keys_names="firstkey secondkey thirdkey"
# exemple : keys's names have differents prefix or they don't have any like :
# mykey, another_key, my_prefered_key,
keys_names="id_dsa_mykey another_key my_prefered_key"
```