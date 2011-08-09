# == Schema Information
# Schema version: 20110808235031
#
# Table name: redis_databases
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
  validates_with Validations::RedisDatabaseValidator
  after_initialize :default_values

  

  private
    def default_values
      self.port ||= 6379
    end

end
