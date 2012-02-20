class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,  :encryptable, :confirmable, :lockable, :timeoutable:rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, 
         :trackable, #:validatable, removing validatable means that we have to do our own validations: TODO!!
         :timeoutable, :timeout_in => 30.minutes
         #, :lockable,
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :username, :login, :actual_name, :current_permission_id

  # username is unique by DB index :unique => true
  # username is required by DB :null => false

  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign_in-using-their-username-or-email-address
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # these relationships model the configured access permissions
  has_many :permissions
  has_many :organisations, :through => :permissions

  validate :has_current_permission

  # Long story cut short: It does not work to store current_permission in a non-persistent attribute
  # (virtual attribute: attr_accessor :current_permission)
  # because each controller may recreate current_user from persistent storage and 
  # then current_permission is lost! 
  # declarative_auth wants method role_symbols to return roles. The users roles depend on the current permission
  # Therefore the current permission cannot be stores in the session but must be remembered by the user. The current permission
  # persists over consecutive sessions. Models cannot access the session!

  # return nil or a Permission for self
  def permission_at_organisation_named (name)
    org = Organisation.find_by_name name
    if org.nil?
      return nil
    end
    perms = permissions.select {|p| p.organisation  == org}
    if perms.size >1
      raise Error "User #{username} has more than one Permission for organisation #{name}"
    end
    if perms.empty? 
      nil
    else
      perms.first
    end
  end

  def current_permission
    if current_permission_id
      begin
        Permission.find current_permission_id
      rescue ActiveRecord::RecordNotFound
        return nil
      end
    else
      nil
    end
  end

  # use this method to add permissions so that aPermission points back to the user
  def add_permission aPermission
    self.permissions << aPermission
    aPermission.user_id = self.id
    aPermission.save
  end

  # return a printable representation of the organisation where self is currently logged in.
  # todo: should use method current_organisation
  def greeting
    if current_permission.nil?
      return "You need to select an organisation to work for!"
    end
    if current_permission.organisation.nil?
       return "Error: My current permission has no organisation"
    end
    "#{current_permission.organisation.name}"
  end

  # todo: either remove def current_organisation_name or implement it using current_organisation
  def current_organisation_name
    if current_permission.nil?
      return "You need to select an organisation to work for!"
    end
    if current_permission.organisation.nil?
       return "Error: My current permission has no organisation"
    end
    current_permission.organisation.name
  end

  def current_organisation
    if current_permission.nil?
      return "You need to select an organisation to work for!"
    end
    if current_permission.organisation.nil?
       return "Error: My current permission has no organisation"
    end
    return current_permission.organisation
  end

=begin
     for declarative auth
     Returns the role symbols of the given user for declarative_auth. 
=end
  def role_symbols
    if current_permission.nil? 
      # if you have no permissions then you are a guest
      # this role is not assigned anywhere else!
      [:guest]
    else
      current_permission.profile.roles.collect {|role|role.to_sym}
    end   
  end

  # Each user must have a current permission at all times!
  # guarantee that in case this is not true a dummy is created and made current
  def has_current_permission
    if self.current_permission.nil?
      current_perm = Permission.create!  :organisation => Location.empty_organisation, :profile => Profile.guest
      self.permissions << current_perm
      self.current_permission_id = current_perm.id
    end

#    errors[:current_permission] << "current perm id = #{current_perm.id},  user id = #{self.id},  perm user_id = #{current_perm.user_id}, user.current_permission_id = #{self.current_permission_id}/#{self.current_permission_id}, associated perm = #{self.permissions}"
    # current perm id = 49, user id = , perm user_id = , user.current_permission_id = 
  end

 # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign_in-using-their-username-or-email-address
 # Overwrite Devise’s find_for_database_authentication method
 protected
 def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
   login = conditions.delete(:login)
   where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
 end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  username               :string(255)     not null
#  actual_name            :string(255)
#  current_permission_id  :integer         not null
#  created_at             :datetime
#  updated_at             :datetime
#

