# == Schema Information
# Schema version: 20110629065550
#
# Table name: languages
#
#  id         :integer         not null, primary key
#  iso_code   :string(255)     not null
#  name       :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

class Language < ActiveRecord::Base
  has_many :calmapp_versions_languages
  has_many :calmapp_versions, :through => :calmapp_versions_language

  validates :iso_code, :name, :presence => true,:uniqueness => true
  validates :name, :presence => true, :uniqueness => true

  attr_accessible :iso_code, :name #,  :calm_reg_language, :course_language, :left_to_right
  
  cattr_reader :per_page
  @@per_page = 10
=begin
  helper method
=end
  #def self.find_calm_languages
    #return Language.find_all_by_calm_reg_language(true)
  #end
end
