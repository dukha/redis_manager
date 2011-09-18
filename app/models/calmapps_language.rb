class CalmappsLanguage < ActiveRecord::Base
  belongs_to :calmapp
  belongs_to :language
  validates :calmapp, :existence=>true
  validates :language, :existence=>true
  #attr_accessor :write
  def name
    return Calmapp.find(calmapp_id).name + " " + Language.find(language_id).name
  end
end
