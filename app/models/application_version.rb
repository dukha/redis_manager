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

class ApplicationVersion < ActiveRecord::Base

  attr_accessible  :application_id, :major_version, :version_status_id

  belongs_to :application #, :class_name => "Application", :foreign_key => "application_id"
  belongs_to :version_status #, :class_name => "VersionStatus", :foreign_key=>"version_status_id"
  #has_one :redis_database
  
  #require 'validations'
  #include Validations
  validates  :major_version,  :presence=>true
  validates :version_status_id, :presence=>true
  validates :application_id, :presence=>true
  
  

=begin
@return a collection of all application names with versions
=end
  def self.application_names_with_versions
     applications = Application.all
    name_versions = []
    applications.each{ |app|
       app.application_versions.each{|version|
         name_versions << app.application_name_with_version
       }
     }
     name_versions.sort!
     return name_versions
  end
  
  # return a concatenation of name and version suitable for display
  def application_name_with_version
    return application_name + " version " + major_version.to_s
  end
  def application_name
    #puts "xxxx" + Application.where(:id => application_id).name
    return Application.where(:id => application_id).first.name
  end
  # moved to validations lib
  #def self.validate_version version
    ##return version.match( regex)
  #end
end
