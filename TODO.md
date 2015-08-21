# TODO.md

- [ ] Manage ssh_keys with differents passphrases :
  - [ ] add the possibility to add keys by passphrase's group
  - [ ] add the possibility to have many config files (define.inc.bh)
  - [ ] test ssh-add with two or more keys with differents passphrases

- [ ] Give possibility to user to define $define_file
- [ ] Option 'interectif' : menu to choise what to do (--run, --setup, --ask)
- [ ] With option --ask give possibility to user to define which variable he want and not all
- [ ] Check directory and files permissions
- [ ] Define Error Codes

- [ ] Do `ls` for keys in $keys_path when prompt for $keys_names
  - [x] Do `ls` when user enter ':ls'
  - [x] Verify  $keys_path for `ls`
  - [x] Filter `ls` by $keys_prefix
  - [ ] Filter files for `ls` with only PRIVATE KEYS

- [ ] End ask user for $keys_names when enter ':end' or ':e' or ':w'

