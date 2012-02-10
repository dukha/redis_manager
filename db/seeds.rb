log=Logger.new(STDOUT)
UserWork.delete_all
#UploadsRedisDatabase.delete_all 
RedisDatabase.delete_all
RedisInstance.delete_all
CalmappVersion.delete_all
Calmapp.delete_all
Language.delete_all
Whiteboard.delete_all
ReleaseStatus.delete_all
WhiteboardType.delete_all


systemWBType = WhiteboardType.create(:name_english=>"system", :translation_code=>"system")
regionalWBType =WhiteboardType.create(:name_english=>"regional admin", :translation_code=>"regionaladmin")
localWBType = WhiteboardType.create(:name_english=>"local admin", :translation_code=>"localadmin")
userWBType = WhiteboardType.create(:name_english=>"user", :translation_code=>"user")
log.info("Whiteboard Type data inserted successfully.")


vs_dev = ReleaseStatus.create!(:status => "development")
ReleaseStatus.create!(:status => "test")
ReleaseStatus.create!(:status => "production")
log.info("Release Status data inserted successfully.")


Whiteboard.create!(:whiteboard_type_id=> systemWBType.id, :info=>"Translator application under development." )
Whiteboard.create!(:whiteboard_type_id=> userWBType.id, :info=>"We need translators for Russian.")
log.info("Whiteboards data inserted successfully.")


en = Language.create!(:iso_code=> "en", :name=>"English")
nl = Language.create!(:iso_code=> "nl", :name=>"Nederlands")
log.info("Languages inserted")


reg = Calmapp.create!( :name=>"calm_registrar")
trans = Calmapp.create!(:name=>"calm_translator")
log.info("Calm applications inserted")

# delete or change below once login is added

reg_v = CalmappVersion.create!(:calmapp_id => reg.id, :version => 4)
log.info("Calm application version inserted")

ri = RedisInstance.create!(:host=>"localhost", :password => '123456', :port => '6379')
log.info("Redis instance inserted")

rdb = RedisDatabase.create!(:calmapp_version_id => reg_v.id, :redis_instance_id => ri.id, :redis_db_index => 1, :release_status_id => vs_dev.id)
log.info("Redis database inserted")

UserWork.create!(:user_id=>1, :translation_language_id => en.id, :current_redis_database_id=> rdb.id)
log.info("User workss inserted")
