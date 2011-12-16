abort "cap-ssh-key-man requires Capistrano 2" unless Capistrano::Configuration.respond_to?(:instance)
require "cap-ssh-key-man/public_key_combiner"

Capistrano::Configuration.instance(true).load do
  namespace :sshkey do
    desc "Sync keys to servers"
    task :deploy do
      if !exists?(:sshkeys_path) or !File.exist?(sshkeys_path)
        abort "Please add 'set :sshkeys_path, YOUR_PUBLIC_KEY_DIR' in your deploy.rb, and put public keys in YOUR_PUBLIC_KEY_DIR."
      end
      CapSshKeyMan::PublicKeyCombiner.combine_developer_public_keys_to sshkeys_path
      put File.read(CapSshKeyMan::PublicKeyCombiner::AUTHORIZED_KEYS_PATH), File.join("/home/#{user}", ".ssh", "authorized_keys")
      FileUtils.rm CapSshKeyMan::PublicKeyCombiner::AUTHORIZED_KEYS_PATH # delete temp file after use it.
    end
  end
end
