# SSHADDM

*ssh-add multi-keys bash script*

## INSTALL

```bash
SSHADDM-DIR-NAME="The name you want for sshaddm directory"
git clone https://github.com/massipasquesi/sshaddm.git $SSHADDM-DIR-NAME
```

if you want sshaddm works anyware,
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