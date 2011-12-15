Cap ssh-key man
===============

A capistrano command that allows you to put all developers' public keys to all servers.
This must be a painful job to add developer's ssh key to all servers one by one,
but after you have this tool, you just need execute `cap sshkey:deploy`

Usage
=====

1. Add `gem "cap-ssh-key-man"` in your Gemfile.

2. Add `require 'cap-ssh-key-man/tasks/sync'` to `config/deploy.rb` of your rails project.

3. Put all public ssh keys to `config/developer_ssh_keys` dir of your rails project.

4. Execute `cap sshkey:deploy`

Done.

Author
======
Michael He

http://www.tui8.com

http://github.com/hlxwell