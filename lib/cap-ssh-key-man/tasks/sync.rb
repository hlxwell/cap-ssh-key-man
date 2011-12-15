require "cap-ssh-key-man/public_key_combiner"
Capistrano::Configuration.instance(true).load do
  namespace :sshkey do
    desc "Sync keys to servers"
    task :deploy do
      CapSshKeyMan::PublicKeyCombiner.combine_developer_public_keys
      put File.read(CapSshKeyMan::PublicKeyCombiner::AUTHORIZED_KEYS_PATH), File.join("/home/#{user}", ".ssh", "authorized_keys")
      FileUtils.rm CapSshKeyMan::PublicKeyCombiner::AUTHORIZED_KEYS_PATH # delete temp file after use it.
    end
  end
end