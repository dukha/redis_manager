


class UserPreference < ActiveRecord::Base
  include Validations
  #validates :with => RedisDbValidator2
  belongs_to :current_redis_database, :class_name=> "RedisDatabase" 
  belongs_to :translation_language, :class_name=>"Language"
  
  validates :current_redis_database, :existence => true
  validates :translation_language, :presence=>true
  

  
  
end




