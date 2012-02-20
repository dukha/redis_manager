class Profile < ActiveRecord::Base

  validates :name, :presence => true, :uniqueness=>true

  # roles are defineds as symbols in config/authorization_rules.rb
  # list all roles which are defiend there:  Authorization::Engine.instance.roles
  # roles do not change in any way at run-time so there is no need to keep them in the DB
  # Also such redundancy would be complicated.
  # A permission object uses the ORM to persist the set of roles the user with this permission can assume.
  # (If we switch to profiles we will have instead belongs_to :user_profile  and serialise the set there)
  # Here serialize tells ActiveRecord to serialize (to yaml) whatever object(-graph) roles points to.
  # For the DB this needs a migration with: add_column :permissions, :roles, :text
  # http://www.postgresql.org/docs/8.3/interactive/datatype-character.html says: text has variable unlimited length
  # It is unlikely the yaml will be too long and be truncated.
  # see also methods roles and add_role
  serialize :roles, Array

  # return the roles for this profile. If not yet initialized then initialize with empty
  # set and return it.
  # this also shows how to implement setter and getter in ruby
  def roles(selectedRoles=nil)
    if selectedRoles.nil?
      read_attribute(:roles) || write_attribute(:roles, [])
    else
      # all should be symbols
      sel_roles = selectedRoles.collect {|each| each.to_sym} 
      #remove duplicates
      sel_roles = sel_roles.to_set.to_a
      write_attribute(:roles, sel_roles)
    end
  end
  alias_method :roles=, :roles   #setter and getter

  # if the aSymbol is not a defined role then do nothing
  # other wise add it.
  def add_role aSymbol
    if Profile.available_roles.include? aSymbol.to_sym
      roles.add aSymbol.to_sym
      return true
    end
    false
  end

  def display
    answer = ''
    roles.each do |role|
      answer += ','
      answer += role.to_s
    end
    answer[1..-1]  #cut out leading comma
  end

  def to_s
    display
  end
  
  def self.seed
    Profile.create :name => 'root', :roles => Profile.available_roles
  end

  # all roles defined in config/authorization_rules.rb
  # as a collection of symbols
  def self.available_roles
    Authorization::Engine.instance.roles
    
  end

  # profile to use for root user
  def self.root
    Profile.find_by_name "root"
  end

  # profile to use for guest user
  def self.guest
    (Profile.find_by_name "guest") || (Profile.create :name => 'guest', :roles => [:guest])
  end
  
  
end

=begin
   reads= []
    creates =[]
    writes =[]
    destroys=[]
    misc =[]
    
    available_roles.each do |role|
      role=role.to_s
      if role.index("_read") then
        reads<<role
      elsif role.index("_create")  then
        creates<<role
      elsif role.index("_write") then
        writes<<role
      elsif role.index("_destroy") then
        destroys<<role
      else
        misc<<role
      end        
     end
    puts reads
    puts creates
    puts writes
    puts destroys
    puts misc
    puts 
=end

# == Schema Information
#
# Table name: profiles
#
#  id         :integer         not null, primary key
#  roles      :text
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)     not null
#

