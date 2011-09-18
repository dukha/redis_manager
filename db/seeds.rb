log=Logger.new(STDOUT)
WhiteboardType.delete_all
systemWBType = WhiteboardType.create(:name_english=>"system", :translation_code=>"system")
regionalWBType =WhiteboardType.create(:name_english=>"regional admin", :translation_code=>"regionaladmin")
localWBType = WhiteboardType.create(:name_english=>"local admin", :translation_code=>"localadmin")
userWBType = WhiteboardType.create(:name_english=>"user", :translation_code=>"user")
log.info("Whiteboard Type data inserted successfully.")

VersionStatus.delete_all
VersionStatus.create!(:status => "development")
VersionStatus.create!(:status => "test")
VersionStatus.create!(:status => "production")
log.info("Version Status data inserted successfully.")

Whiteboard.delete_all
Whiteboard.create!(:whiteboard_type_id=> systemWBType.id, :info=>"Translator application under development." )
Whiteboard.create!(:whiteboard_type_id=> userWBType.id, :info=>"We need translators for Russian.")
log.info("Whiteboards data inserted successfully.")

Language.delete_all
en = Language.create!(:iso_code=> "en", :name=>"English")
nl = Language.create!(:iso_code=> "nl", :name=>"Nederlands")
log.info("Languages inserted")

Calmapp.delete_all
reg = Calmapp.create!( :name=>"calm_registrar")
trans = Calmapp.create!(:name=>"calm_translator")
log.info("Calm applications inserted")