# == Schema Information
# Schema version: 20110918232413
#
# Table name: calmapp_versions_languages
#
#  id                 :integer         not null, primary key
#  calmapp_version_id :integer         not null
#  language_id        :integer         not null
#

class CalmappVersionsLanguage < ActiveRecord::Base
  include Validations
  belongs_to :calmapp_version
  belongs_to :language

  validates :calmapp_version, :existence=>true
  validates :language, :existence=>true
  #attr_accessor :write
  def name
    return CalmappVersion.find(calmapp_version_id).name + " " + Language.find(language_id).name
  end
end
