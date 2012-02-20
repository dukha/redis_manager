
=begin
 Abstract representation of various domains in the hierarchy of places, activites and permissions in calm.
 @todo Change use of "location" to "domain"
=end
# acts as tree provides access to parents and children without coding more than parent_id
require 'acts_as_tree'

class Location < ActiveRecord::Base

  acts_as_tree
  validates :name, :presence   => true
  validates :name, :uniqueness => true
  # not that in virtually every lookup translation_code is not null, however in Location it is nullable.
  attr_accessible :name, :type, :parent_id, :translation_code, :marked_deleted, :fqdn

  #has_many :public_schedules, :dependent => :destroy

#  def types
#    return Hash[ :root=>"Root", :server=>"Server", :region =>"Region", :organisation=>"Organisation", :venue=>"Venue" ]
#  end

  def to_s
    type_translation = "#{I18n.t("activerecord.models." + self.class.name.downcase, :count => 1)}"
    # type_translation == e.g organisation, venue etc.
    if translation_code == nil then
      #"#{name} (#{type_translation})"
      "#{name}"
    else
      #"#{I18n.t($LU +"location.name."+ name.downcase)} (#{type_translation})"
      "#{name}"
    end
  end

  # Location is an abstract superclass
  # Need to redirect to concrete subclass' controllers
  def controller_name
    self.class.name.downcase.pluralize
  end

  def may_have_children?
    true
  end

  # Is one of the ancestors of this object an organisation? (the root 'world' excepted)
  # be aware that this will not test self but start only with the parent
  def has_organisation_ancestor?
   ancestor = self.parent
   while ancestor != nil do
     if ancestor.is_a? Organisation
       if ancestor == Organisation.world
         return false
       else
         return true
       end
     end
     ancestor = ancestor.parent
   end
   false
  end

  # all_children gives trashed and active children
  alias_method :all_children, :children

  # children gives only active ones (replacing method from super class)
  def children
    all_children.reject {|c| c.marked_deleted}
  end

  def trashed_children
    all_children.select {|c| c.marked_deleted}
  end

  # overwritten by venue and organisation
  # so consider here what is left, area and server
  def allow_organisation_child?
    true
  end

  def allow_server_child?
    false
  end

  def allow_area_child?
    name != Location.root_name
  end

  def allow_venue_child?
    # only if an ancestor is an organisation, not counting world
    if has_organisation_ancestor?
      return true
    end
    is_a? Organisation and name != Location.root_name
  end

=begin
  Helper method to find all locations not marked as deleted
=end
#  def self.find_valid
#    return find_all_by_marked_deleted(false)
#  end

=begin
  Helper method to find all valid, non-venue locations. (Veneus cannot be used to login.)
  Actually only organisations can be logged into. One can only login to a location
  which is contactable by people. That is an organisation.
=end
#  def self.find_loginable
#    return Location.find.where(:conditions => "type != 'Venue' and marked_deleted = 'f'" )
#  end

  def self.world
    Location.root
  end

  def self.root_name
    "world"
  end

  def self.localhost_name
    "localhost"
  end

  def self.localhost
    if Location.root.nil?
      return nil
    end
    (Location.root.children.select {|child| child.name == localhost_name}).first
  end

  # if we create a user without givin any permission then they will be a guest of Location.empty_organisation
  def self.empty_organisation
    name = 'Empty organisation'
    l = Location.find_by_name name
    if l ; return l; end
    Organisation.create :name => name, :translation_code => "empty_organisation"
  end

  def deletable?
    return false unless all_children.empty?
    #return false unless accessible_courses.empty?
    # todo: if has associated objects (e.g courses, letters etc. then return false
    return true
  end

  # the minimal configuration needed for the application to work
  def self.seed
    if Location.root.nil?
      Organisation.create :name => Location.root_name, :translation_code => "world"
    end
    if Location.localhost.nil?
      Server.create :name => Location.localhost_name, :parent_id =>  Location.root.id, :translation_code => "localhost"
    end
  end

  # all nodes in the subtree starting here
  def accessible_locations
    answer ||= []
    answer << self
    children.each {|node| answer += node.accessible_locations}
    answer
  end


  # return collection of venues which are accessible from this location
  # a venue never has children, it is a leaf of the tree
  # example all venues accessible for the signed in user: 
  #   current_user.current_organisation.accessible_venues
  def accessible_venues
    answer ||= []
    if is_a? Venue
      answer << self
    else
      children.each {|node| answer += node.accessible_venues}
    end
    answer
  end

  def accessible_organisations
    answer ||= []
    if is_a? Organisation
      answer << self
    end
    children.each {|node| answer += node.accessible_organisations }
    answer
  end
=begin  
  # This function should probably be in course.rb according to mpl
  # Course does not know about other courses. But a location may be responsible
  # for a number of courses. eka thinks this is the right place, analogous to simple associations.
  def accessible_courses
    answer = accessible_venues.collect {|v| Course.where(:venue_id => v.id)}
    answer.flatten!
    answer = answer.sort_by {|x| 
      if x.start_date.nil?
        Course.unknown_date
      else
        x.start_date
      end
   }
  end
  
  # courses which have ended up to 5 days ago
  def accessible_current_courses
    accessible_courses.select {|each| each.end_date + 6 > Date.today}
  end

  def accessible_past_courses
    accessible_courses.select {|each| each.end_date < Date.today}
  end
=end
  # default implementation
  def allow_organisation_ancestor?
    true
  end

  def allow_organisation_child?
    !has_organisation_ancestor?
  end

  # some nodes have predefined fixed names by which they
  # are recognized. They must not be changed
  def allow_name_edit?
    name !=  Location.root_name and name != Location.localhost_name
  end

  # the localhost must have a fully qualified domain name
  # by convention this is where PFORM app runs
  def allow_fqdn_edit?
    name == Location.localhost_name
  end
=begin
  # Which publich schedules cover (or include) this location.
  # These are the schedules on locations from here to the root
  # because public schedules select their courses with location.accessible_courses (see public_schedule.rb).
  def covered_by_public_schedules
    schedules = []
    nodes = []
    ancestor = self
    while !ancestor.nil? do    
      nodes << ancestor
      ancestor = ancestor.parent
    end
    nodes.each do |each|
      schedules.concat each.public_schedules
    end
    schedules
  end
=end
  scope :non_root, lambda { |root| where( "id != ? ", root.id) }
  scope :non_venue,  where( "type != 'Venue'")

  def move_targets
    # if self is root or a server then moving is impossible
    return [] if Location.world == self
    return [self.parent] if self.is_a? Server
    # root is not an eligible target
    # no venue is an eligible target
    targets = Location.non_root(Location.root).non_venue
    targets.delete Location.empty_organisation  # never move anything there
    # remote hosts are no targets
    targets = targets.reject {|each| each.is_a? Server and each.name != 'localhost'}
    #remove own subtree from targets
    targets = remove_subtree targets

    #if self or one of its descendents is an organisation then any organisation subtree is not eligible
    if !self.accessible_organisations.empty?
      # remove all organisation subtrees from target
      targets = remove_organisations targets
      targets << self.parent  # the current parent is always the default selection for moving

    #else  not self and none of its descendents is an organisation then 
    else
    # if subtree of self has a venue
      if !self.accessible_venues.empty?
    #   then only organisations and their subtrees are eligible
        # remove all nodes above an organisation from target
        targets = remove_above_organistions targets
        targets << self.parent
    # else 
      else
    #   can move to all eligible targets
        targets
        targets << self.parent
      end
    end
  end

  private
  def print_debug aLocationCollection, title
    puts "vv start #{title} vv"
    aLocationCollection.each{|each| puts each.name+", "}
    puts "^^ end ^^"
  end

  # remove from targets: subtree of location self, self, parent
  def remove_subtree targets
    t = targets.to_set
    t.delete self.parent
    (t-accessible_locations).to_a
  end

  # remove all organisation subtrees from target
  def remove_organisations targets
    t = targets.to_set
    org_sub_trees = Location.localhost.accessible_organisations.collect {|each| each.accessible_locations.to_set}
    org_sub_trees = org_sub_trees.to_set.flatten
    #print_debug t ,"**1*"
    #print_debug org_sub_trees ,"**2*"
    (t - org_sub_trees).to_a
  end

  # remove all nodes above an organisation from target
  def remove_above_organistions targets
    t = targets.to_set
    org_sub_trees = Location.localhost.accessible_organisations.collect {|each| each.accessible_locations.to_set}
    org_sub_trees = org_sub_trees.to_set.flatten
    to_remove = Location.localhost.accessible_locations.to_set - org_sub_trees
    #print_debug t ,"**3*"
    #print_debug org_sub_trees ,"**4*"
    #print_debug to_remove ,"**5*"
    (t - to_remove).to_a
  end
  def translate_name
        
    t = I18n.t(translation_code) unless translation_code.blank?
    return t unless t.blank? || t.index('missing')
    return name 
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

