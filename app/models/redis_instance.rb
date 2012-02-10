# == Schema Information
#
# Table name: redis_instances
#
#  id       :integer         not null, primary key
#  host     :string(255)     not null
#  port     :integer         not null
#  password :string(255)     not null
#
=begin
  Redis.new(options)

  :path (def= nil may be only usable for sockets??
  or
  :host def =127.0.0.1
  and
  :port (def=6379)
  :db (def=0)
  :timeout
  :password
  :logger
=end

class RedisInstance < ActiveRecord::Base
  
  include Validations
  
  
  
  validates :host,:presence=>true
  validates :port, :presence => true
  validates :password, :presence=>true
  
  # a generalised validation for the record. Checks the attributes to see if it can connect to the instance
  validates  :host, :redis_instance => true
  
  after_initialize :default_values

  def name
    return CalmappVersion.find(calmapp_version_id).name + " / Redis Database Index: " + redis_db_index.to_s
  end


  def database_supports_language? language
    if language.is_a(Language) then
      language = language.id
    end
    return calmapp_version.language_ids.include? language
  end
  private
    def default_values
      self.port ||= 6379
    end

end




# == Schema Information
#
# Table name: redis_instances
#
#  id       :integer         not null, primary key
#  host     :string(255)     not null
#  port     :integer         not null
#  password :string(255)     not null
#

