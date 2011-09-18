# == Schema Information
# Schema version: 20110629065550
#
# Table name: application_versions
#
#  id                :integer         not null, primary key
#  application_id    :integer         not null
#  version           :string(255)     not null
#  version_status_id :integer         not null
#  created_at        :datetime
#  updated_at        :datetime
#

class CalmappVersion < ActiveRecord::Base
  #require 'validations'
  include Validations
  attr_accessible   :calmapp_id, :major_version, :version_status_id

  belongs_to :calmapp #, :class_name => "Application", :foreign_key => "calmapp_id"
  belongs_to :version_status #, :class_name => "VersionStatus", :foreign_key=>"version_status_id"
  has_one :redis_database
  
  #require 'validations'
  #include Validations
  validates  :major_version,  :presence=>true
  validates :major_version, :numericality=> {:only_integer=>true}
  validates :version_status_id, :presence=>true
  validates :calmapp_id, :presence=>true
  validates :version_status_id, :existence => true
  #validates :redis_database, :existence => true
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
    return calmapp_name + " version " + major_version.to_s
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
end
