module CapSshKeyMan
  class PublicKeyCombiner
    def self.combine_developer_public_keys
      authorized_keys_path = File.join ".", "tmp", "authorized_keys"
      public_key_path      = File.join(".", "config", "developer_public_keys")

      File.open authorized_keys_path, "w" do |f|
        f.write File.read(get_current_user_public_key_path) if get_current_user_public_key_path
        files = Dir[File.join(public_key_path, '*')]
        raise "Can't find any public keys in #{public_key_path} dir." if files.size == 0
        files.each do |file|
          f.write File.read(file)
        end
      end
    end

    def self.get_current_user_public_key_path
      omni_rsa_key_path = File.expand_path(File.join "~", ".ssh", "id_rsa.pub")
      omni_dsa_key_path = File.expand_path(File.join "~", ".ssh", "id_dsa.pub")
      current_user_key_path = nil
      current_user_key_path = omni_rsa_key_path if File.exist?(omni_rsa_key_path)
      current_user_key_path = omni_dsa_key_path if File.exist?(omni_dsa_key_path)
      current_user_key_path
    end
  end
end
