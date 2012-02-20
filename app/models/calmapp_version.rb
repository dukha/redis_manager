class CalmappVersion < ActiveRecord::Base
  #require 'validations'
  include Validations
  #languages available is a virtual attribute to allow languages_available to be used in the new form
  # :add_languages, :new_redis_db are virtual attributes for the user to indicate that a languages and redis database are to be added at the same time as a new version
  attr_accessor :languages_available, :add_languages, :new_redis_dev_db
  attr_accessible   :calmapp_id, :version,  :redis_database, :language_ids, :new_redis_dev_db
  
  belongs_to :calmapp #, :class_name => "Application", :foreign_key => "calmapp_id"
  
  has_one :redis_database
  
 
  validates  :version,  :presence=>true
  validates :version, :numericality=> {:only_integer=>false, :allow_nil =>true}
  
  validates :calmapp_id, :presence=>true

  has_many :calmapp_versions_languages, :dependent => :destroy
  has_many :languages , :through => :calmapp_versions_languages
  validates :calmapp_id, :existence=>true
  
  
  

=begin
@return a collection of all calmapp names with versions
=end
  def self.calmapp_names_with_versions
     calmapps = Calmapp.all
    name_versions = []
    calmapps.each{ |app|
       app.calmapp_versions.each{|version|
         name_versions << app.calmapp_name_with_version
       }
     }
     name_versions.sort!
     return name_versions
  end
  
  # return a concatenation of name and version suitable for display
  def calmapp_name_with_version
    return calmapp_name + " version " + version.to_s
  end
  def name
    return calmapp_name_with_version
  end
  def calmapp_name
    #puts "xxxx" + Application.where(:id => application_id).name
    return Calmapp.where(:id => calmapp_id).first.name
  end
  # moved to validations lib
  #def self.validate_version version
    ##return version.match( regex)
  #end

  def available_languages
    #if id == nil  then #args[:idx] == "" then
      #return Language.all
    #else
      return Language.all - languages
    #end
  end
end

# == Schema Information
#
# Table name: calmapp_versions
#
#  id         :integer         not null, primary key
#  calmapp_id :integer         not null
#  version    :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

