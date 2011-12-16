module CapSshKeyMan
  class PublicKeyCombiner
    AUTHORIZED_KEYS_PATH = File.join ".", "tmp", "authorized_keys"
    PUBLIC_KEY_PATH      = File.join(".", "config", "developer_public_keys")
    OMNI_RSA_KEY_PATH    = File.expand_path(File.join "~", ".ssh", "id_rsa.pub")
    OMNI_DSA_KEY_PATH    = File.expand_path(File.join "~", ".ssh", "id_dsa.pub")

    def self.combine_developer_public_keys_to public_key_path = PUBLIC_KEY_PATH
      File.open AUTHORIZED_KEYS_PATH, "w" do |f|
        f.write File.read(get_current_user_public_key_path) if get_current_user_public_key_path
        files = Dir[File.join(public_key_path, '*')]
        raise "Can't find any public keys in #{public_key_path} dir." if files.size == 0
        files.each do |file|
          f.write File.read(file)
        end
      end
    end

    def self.get_current_user_public_key_path
      current_user_key_path = nil
      current_user_key_path = OMNI_RSA_KEY_PATH if File.exist?(OMNI_RSA_KEY_PATH)
      current_user_key_path = OMNI_DSA_KEY_PATH if File.exist?(OMNI_DSA_KEY_PATH)
      current_user_key_path
    end
  end
end
