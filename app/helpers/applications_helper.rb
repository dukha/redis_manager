module ApplicationsHelper
  def languages_available_data id
    #args[:idx] ||= ''
    #puts "idx " + args[:idx].to_s
    if id == nil  then #args[:idx] == "" then
      return Language.all
    else
      Language.all - Language.joins(:applications_languages).where("applications_languages.application_id= :id", :id=>id)
    end
  end
end
