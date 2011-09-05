class ApplicationsLanguage < ActiveRecord::Base
  belongs_to :application
  belongs_to :language
  #attr_accessor :write
  def name
    return Application.find(application_id).name + " " + Language.find(language_id).name
  end
end
