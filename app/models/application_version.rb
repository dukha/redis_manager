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

  attr_accessible  :application_id, :version, :version_status_id

  belongs_to :application, :class_name => "Application", :foreign_key => "application_id"
  belongs_to :version_status, :class_name => "VersionStatus", :foreign_key=>"version_status_id"
  has_many :language_application_versions, :dependent => :destroy
  has_many :languages, :through => :language_application_versions
  require 'validations'
  include Validations
  validates :version, :presence=>true, :version_format => true
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
    return name + " / " +version
  end
  def application_name
    return Application.where("id = ?", application_id).name
  end
  # moved to validations lib
  #def self.validate_version version
    ##return version.match( regex)
  #end
end
