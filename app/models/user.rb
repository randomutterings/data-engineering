class User < ActiveRecord::Base
  scope :find_from_auth, ->(auth) { where(auth.slice("provider", "uid"))}

  def self.find_or_create_from_auth(auth)
    find_from_auth(auth).first || create_from_auth(auth)
  end

  def self.create_from_auth(auth)
    create!({ provider: auth["provider"],
              uid: auth["uid"],
              name: auth["info"]["name"] })
  end
end
