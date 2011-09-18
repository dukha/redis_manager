# == Schema Information
# Schema version: 20110808235031
#
# Table name: translations
#
#  id          :integer         not null, primary key
#  redis_index :integer         not null
#  name        :string(255)     not null
#  host        :string(255)     not null
#  port        :integer         not null
#  created_at  :datetime
#  updated_at  :datetime
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

class RedisDatabase < ActiveRecord::Base
  #require 'validations'
  include Validations

  belongs_to :calmapp_version

  validates :calmapp_version, :existence => true
  validates :redis_db_index, :presence=>true
  validates :calmapp_version_id,:presence=>true
  validates :host,:presence=>true
  validates :port, :presence => true
  validates  :redis_db_index, :redis_db => true
  #validates_with Validations::TranslationValidator
  after_initialize :default_values

  def name
    return CalmappVersion.find(calmapp_version_id).name + " / Redis Database Index: " + redis_db_index.to_s
  end
  
  private
    def default_values
      self.port ||= 6379
    end

end
