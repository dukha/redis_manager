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
  Every calmapp will have a number of translation files plus use common files.
  This class is the calmapp that owns translation files
  Shared (common) translation files are kept in an calmapp called Shared
=end
class Calmapp < ActiveRecord::Base
  
  attr_accessor :languages_available

  has_many :calmapp_versions, :dependent => :destroy
  has_many :calmapps_languages, :dependent => :destroy
  has_many :languages , :through => :calmapps_languages
=begin
  These attributes permit the adding of version and languages info in the calmapp screen in a new record
  add_first_version boolean indicating the user wants to add extra data
  version_name the name of the version to be added
  add_non_english_languages boolean indicating the users intent
  language_ids is a collection of the language i's for the non english languages to be added
=end
  #attr_accessor :add_first_version, :version_name, :add_non_english_languages, :language_ids
  attr_accessible :name, :language_ids


  validates :languages, :associated => true
  validates :calmapp_versions, :associated => true
  validates :name, :presence=>true
  validates :name, :uniqueness=>true
  
  def available_languages
    #if id == nil  then #args[:idx] == "" then
      #return Language.all
    #else
      return Language.all - languages
    #end
  end
  def save_app_version_database(version=nil, redis_database=nil)
    #require 'models/calmapp_version'
    #include CalmappVersion
    
    Calmapp.transaction do
      save!
      if ! version.nil? then
        CalmappVersion.transaction(:requires_new => true) do
          version.calmapp_id=id
          version.save!
        end
      end
      if ! redis_database.nil? then
        RedisDatabase.transaction(:requires_new => true) do
          redis_database.calmapp_version_id=version_id
          redis_database.save!
        end
      end
    end # calmapp transaction
    return self
  end #save_app_version_database

 
end
