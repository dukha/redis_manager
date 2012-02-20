class TranslationRedis
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  #include TranslationParametersController
  #fix everything below to work with translation_parameters in session.
  attr_reader :redis_connection
  #attr_accessor :redis_database, :dot_key_code, :translation, :translation_message0, :translation_message1, :translation_message2#, :language, :dot_key_code_wrapped, :dot_key_code_last_key
  #attr_accessor :redis_database#, #:dot_key_code0, :translation0, :dot_key_code1, :translation1, :dot_key_code2, :translation2, :translation_message0, :translation_message1, :translation_message2, :developer_params
  validates  :dot_key_code, :presence => true
  validates :translation, :presence => true
  #attr_accessible :dot_key_code, :translation,:dot_key_code_wrapped, :dot_key_code_last_key, :dot_key_no_lang
  def self.all
    #redis_database = session[]
    #language=
    redis= UserWork.redis_database.connect
    arr = Array.new
    search = (UserWork.language_iso_code ? (UserWork.language_iso_code + "*") : "*"  )
    redis.key '*'.each do |k|
      arr.push  TranslationRedis.new(k, redis.get( k))
    end
    return arr
  end
  
  def self.new_from_class translation
    new(translation.dot_key_code, translation.translation, translation.calmapp_version_id)
  end
  
  def initialize dot_key, trans, app_version_id
    super
    #puts "in init"
    @dot_key_code=dot_key
    @translation=trans
    @calmapp_version_id=app_version_id
    #puts dot_key_code
    
  end
  # Gets the translation data from the redis db
  def self.find(redis_connection, lang_id, dot_key=nil)
     #tp = get_translation_parameters
     #redis_database= RedisDatabase.find(redis_db_id)
     language= Language.find(lang_id)
     #debugger
     #keys = []
     #debugger

     dot_key='*' if dot_key.nil?

     #if dot_key.index('*') then
     keys = redis_connection.keys(UserWork.language_iso_code + '.' + dot_key)
     #end
     translations = []
     if keys.empty? and !dot_key.index('*') then
       # this is an untranslated key
       tx =Translation.new
       tx.dot_key_code = dot_keyt
     else
       debugger
       keys.each do |k|
         tx = Translation.new #(k, redis_connection.get(k))
         tx.dot_key_code = k
         tx.translation= redis_connection.get(k)
         translations << tx
         puts "tx: " + tx.dot_key_code
       end
     end
     return ((translations.length == 1) ? translations.first : translations)
  end
  def self.save_multiple translations_redis=[]
    translations_redis.each do |tr|
      tr.save!
    end
    #This should only return true if all are saved in redis
    return true
  end
  def save!
    #puts @dot_key_code + " x " + @translation
    debugger
    #if valid? then
      # @todo valid? doesn't seem to work. Only trying to valid presence of the 2 attributes: should return true???
      #@todo Also need a redis_connection.exists? here. Have to write it ourselves
      puts "Is redis record valid? " + valid?.to_s
      redis_connection.set(@dot_key_code, @translation)
      puts "Wrote " + @dot_key_code +" = " + redis_connection.get( @dot_key_code)
      
   # end 
  end
  
  def persisted?
    #check to see if they are in session
    false
  end
 
  #def redis_database
    #@redis_database
  #end
  def dot_key_code
    @dot_key_code
  end
  
  
  def translation
    @redis_translation
  end
  
  
=begin
  def redis_database= rd
     puts "redis database set"
    @redis_database = rd
     puts "@ set " + @redis_database
    connect
  end
=end
  def dot_key_code=  dkc
    puts "dkc " +dkc
    @dot_key_code = dkc
  end
  
  def translation= tr
    @translation = tr
  end
=begin
  def language= lang
    @language = lang
  end
=end
  def get key
    return redis_connection.get key
  end
  
  def del key
    return redis_connection.del key
  end
  
  def set(key, translation)
    redis_connection.set(key, translation)
  end
  
  private
     #Returns the current Redis database (an instance of Redis)
    def redis_connection
      #puts "in rc"
      if ! @redis_connection then
        #puts "in loop"
        connect
      end
      #puts "end loop"
      @redis_connection
    end
  
  
  private
   #Returns the current Redis database (an instance of Redis)
    def connect
      #if ! redis_connection then
      @redis_connection= UserWork.redis_database.connect
      #end
      @redis_connection
    end
  
  
  
end
