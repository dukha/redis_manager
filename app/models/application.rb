# == Schema Information
# Schema version: 20110629065550
#
# Table name: applications
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

=begin
  Every application will have a number of translation files plus use common files.
  This class is the application that owns translation files
  Shared (common) translation files are kept in an application called Shared
=end
class Application < ActiveRecord::Base
  
  has_many :application_versions, :dependent => :destroy
=begin
  These attributes permit the adding of version and languages info in the application screen in a new record
  add_first_version boolean indicating the user wants to add extra data
  version_name the name of the version to be added
  add_non_english_languages boolean indicating the users intent
  language_ids is a collection of the language i's for the non english languages to be added
=end
  attr_accessor :add_first_version, :version_name, :add_non_english_languages, :language_ids
  attr_accessible :name



  validates :name, :presence=>true
  validates_uniqueness_of :name
  


end
