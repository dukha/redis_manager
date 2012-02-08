


class UserPreference < ActiveRecord::Base
  include Validations
  #validates :with => RedisDbValidator2
  belongs_to :current_redis_database, :class_name=> "RedisDatabase" 
  belongs_to :translation_language, :class_name=>"Language"
  
  validates :current_redis_database, :existence => true
  validates :translation_language, :presence=>true
  

  # This method will need to be changed once devise is added
  def self.current_user_id
    return 1
  end
  
  def self.language_iso_code
    return UserPreference.find(current_user_id).translation_language.iso_code
  end
  
  def self.redis_database
    return UserPreference.find(current_user_id).current_redis_database
  end
  
  def self.calmapp_version
    return redis_database.calmapp_version
  end
  
end




