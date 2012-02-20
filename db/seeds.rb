log=Logger.new(STDOUT)
UserWork.delete_all
User.delete_all
#UploadsRedisDatabase.delete_all 
RedisDatabase.delete_all
RedisInstance.delete_all
CalmappVersion.delete_all
Calmapp.delete_all
Language.delete_all
Whiteboard.delete_all
ReleaseStatus.delete_all
WhiteboardType.delete_all
Location.delete_all
Profile.delete_all    


systemWBType = WhiteboardType.create(:name_english=>"system", :translation_code=>"system")
regionalWBType =WhiteboardType.create(:name_english=>"regional admin", :translation_code=>"regionaladmin")
localWBType = WhiteboardType.create(:name_english=>"local admin", :translation_code=>"localadmin")
userWBType = WhiteboardType.create(:name_english=>"user", :translation_code=>"user")
log.info("Whiteboard Type data inserted successfully.")


vs_dev = ReleaseStatus.create!(:status => "development")
vs_test = ReleaseStatus.create!(:status => "test")
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

reg4 = CalmappVersion.create!(:calmapp_id => reg.id, :version => 4)
trans1=CalmappVersion.create!(:calmapp_id => trans.id, :version => 1)
log.info("Calm application version inserted")

ri_local = RedisInstance.create!(:host=>"localhost", :password => '123456', :port => '6379', :max_databases=>16, :description=> 'Local Desktop Computer')
ri_integration = RedisInstance.create!(:host=>"31.222.138.180", :password => '123456', :port => '6379', :max_databases=>32, :description=>'Integration Server')
log.info("Redis instances inserted")

red_reg4_loc_dev = RedisDatabase.create!(:calmapp_version_id => reg4.id, :redis_instance_id => ri_local.id, :redis_db_index => 1, :release_status_id => vs_dev.id)
red_reg4_loc_test = RedisDatabase.create!(:calmapp_version_id => reg4.id, :redis_instance_id => ri_local.id, :redis_db_index => 2, :release_status_id => vs_test.id)
red_trans1_int_dev = RedisDatabase.create!(:calmapp_version_id => trans1.id, :redis_instance_id => ri_integration.id, :redis_db_index => 1, :release_status_id => vs_dev.id)
red_trans1_int_test = RedisDatabase.create!(:calmapp_version_id => trans1.id, :redis_instance_id => ri_integration.id, :redis_db_index => 2, :release_status_id => vs_test.id)
log.info("Redis databases inserted")


Profile.seed
log.info("profiles seeded")
Location.seed
log.info("Locations seeded")
#global = Area.create :name => "Global" , :parent_id => Location.localhost.id
vipassana =  Organisation.create :name => "Vipassana" , :parent_id => Location.find_by_name(Location.localhost_name).id
log.info("Global area and vipassana org inserted")

# ceate users which can log-in
    User.all.each do |each|
      if each.username == 'root'; next; end
      each.destroy
    end

    pw = '123456'
    
    current_perm = Permission.create!  :organisation => Location.world, :profile => Profile.root
    param = {:password => pw,:password_confirmation => pw,:username => 'admin',:email => 'admin@calm.org', 
             :current_permission_id => current_perm.id}
    #puts "current permission i d= " +current_perm.id.to_s
    admin = User.create! param
    admin.add_permission current_perm

    prof_guest = Profile.create! :name => 'guest', :roles => ['guest']
    perm = Permission.create!  :organisation => vipassana,  :profile => prof_guest
    admin.add_permission perm
    param[:organisation]=vipassana
    param[:username]='translator'
    param[:email]= 'translator@calm.org'
    translator=User.create! param
    
    param[:username]='developer'
    param[:email]= 'developer@calm.org'
    translator=User.create! param
#User.create!( :username=>'translator', :email=> 'translator@calm.org', :password=>'123456', :confirm_password=>'123456')
#User.create!( :username=>'admin', :email=> 'admin@calm.org', :password=>'123456', :confirm_password=>'123456')
#User.create!( :username=>'developer', :email=> 'developer@calm.org', :password=>'123456', :confirm_password=>'123456')
log.info("Users inserted")

UserWork.create!(:user_id=> User.find_by_username('translator'), :translation_language_id => nl.id, :current_redis_database_id=> red_reg4_loc_test.id)
UserWork.create!(:user_id=> User.find_by_username('developer'), :translation_language_id => en.id, :current_redis_database_id=> red_trans1_int_dev.id)
log.info("User works inserted")