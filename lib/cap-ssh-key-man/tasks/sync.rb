abort "cap-ssh-key-man requires Capistrano 2" unless Capistrano::Configuration.respond_to?(:instance)
require "cap-ssh-key-man/public_key_combiner"

Capistrano::Configuration.instance(true).load do
  namespace :sshkey do
    desc "Sync keys to servers"
    task :deploy do
      set :sshkeys_path, nil unless exists?(:sshkeys_path)
      remote_ssh_folder_path = File.join("/home/#{user}", ".ssh", "authorized_keys")
      put CapSshKeyMan::PublicKeyCombiner.combine_developer_public_keys_in(sshkeys_path), remote_ssh_folder_path
      run "chmod 600 #{remote_ssh_folder_path}"
    end
  end
end
