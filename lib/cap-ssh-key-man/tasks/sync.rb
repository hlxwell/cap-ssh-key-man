require "cap-ssh-key-man/public_key_combiner"
Capistrano::Configuration.instance(true).load do
  namespace :sshkey do
    desc "Sync keys to servers"
    task :deploy do
      puts "Creating authorized_keys file ..."
      CapSshKeyMan::PublicKeyCombiner.combine_developer_public_keys

      puts "Deploying authorized_keys ..."
      tmp_authorized_keys_path = File.join(".", "tmp", "authorized_keys")
      put File.read(tmp_authorized_keys_path), File.join("/home/#{user}", "authorized_keys")

      # delete temp file after use it.
      FileUtils.rm tmp_authorized_keys_path
    end
  end
end