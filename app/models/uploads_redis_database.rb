class UploadsRedisDatabase < ActiveRecord::Base
  include Validations
  attr_accessible :redis_database_id, :upload_id
  belongs_to :upload
  belongs_to :redis_database

  validates :redis_database_id, :existence=> true
  validates :upload_id, :existence=> true

  def  self.uploads_redis_db_exists? upl_id, rdb_id
    return UploadsRedisDatabase.where('upload_id = :upload_id and redis_database_id = :redis_database_id',
         {:upload_id=>upl_id, :redis_database_id=> rdb_id}).exists?
  end
end

# == Schema Information
#
# Table name: uploads_redis_databases
#
#  id                :integer         not null, primary key
#  upload_id         :integer         not null
#  redis_database_id :integer         not null
#

