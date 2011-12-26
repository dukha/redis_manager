# == Schema Information
#
# Table name: redis_databases
#
#  id                 :integer         not null, primary key
#  calmapp_version_id :integer         not null
#  redis_instance_id  :integer
#  redis_db_index     :integer         not null
#  created_at         :datetime
#  updated_at         :datetime
#


class UserPreference < ActiveRecord::Base
  include Validations
  #validates :with => RedisDbValidator2
  belongs_to :current_redis_database, :class_name=> "RedisDatabase" 
  belongs_to :translation_language, :class_name=>"Language"
  
  validates :current_redis_database, :existence => true
  validates :translation_language, :presence=>true
  

  
  
end




