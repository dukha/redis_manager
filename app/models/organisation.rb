=begin
 Represents a calm instance. This is where most users will login.
 Registrars work primarily in an organisation.
=end
class Organisation <  Location
  
  validates_with SubOrganisationValidator

  has_many :permissions
  has_many :users, :through => :permissions

  # allowed children types defines in super classes
  # Hereallow only the organisation 'world' to have servers
  def allow_server_child?
    Location.world == self
  end

  # when this location is created, return false if it is a sub-organisation
  def allow_organisation_ancestor? 
    !has_organisation_ancestor?
  end

  def allow_organisation_child?
    false
    # necessary because if self is an organisation 
    # then has_organisation_ancestor? is still false
    # also correct for org. at tree root
  end


end

# == Schema Information
#
# Table name: locations
#
#  id               :integer         not null, primary key
#  name             :string(255)     not null
#  type             :string(255)     not null
#  parent_id        :integer
#  translation_code :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  marked_deleted   :boolean         default(FALSE)
#

