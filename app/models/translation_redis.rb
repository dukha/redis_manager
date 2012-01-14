class TranslationRedis
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  #include TranslationParametersController
  #fix everything below to work with translation_parameters in session.
  attr_reader :redis_connection
  #attr_accessor :redis_database, :dot_key_code, :translation, :translation_message0, :translation_message1, :translation_message2#, :language, :dot_key_code_wrapped, :dot_key_code_last_key
  attr_accessor :redis_database#, #:dot_key_code0, :translation0, :dot_key_code1, :translation1, :dot_key_code2, :translation2, :translation_message0, :translation_message1, :translation_message2, :developer_params
  validates  :dot_key_code, :presence => true
  validates :translation, :presence => true
  #attr_accessible :dot_key_code, :translation,:dot_key_code_wrapped, :dot_key_code_last_key, :dot_key_no_lang
  def self.all
    #redis_database = session[]
    #language=
    redis= redis_database.connect
    arr = Array.new
    search = (language ? (language.iso_code+"*") : "*"  )
    redis.key '*'.each do |k|
      arr.push  TranslationRedis.new(k, redis.get( k))
    end
    return arr
  end
  
  def self.new_from_class translation
    new(translation.dot_key_code, translation.translation)
  end
  
  def initialize dot_key, trans
    super
    #puts "in init"
    @dot_key_code=dot_key
    @translation=trans
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
     keys = redis_connection.keys(language.iso_code + '.' + dot_key)
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
  
  def save!
    #puts @dot_key_code + " x " + @translation
    valid?
    redis_connection.set(@dot_key_code, @translation)
     
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
  def self.current_user_id
    return 1
  end
  def self.language
    return UserPreference.find(current_user_id).translation_language.iso_code
  end
  
  def self.redis_database
    return UserPreference.find(current_user_id).current_redis_database
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
    def connect
      #if ! redis_connection then
      @redis_connection= TranslationRedis.redis_database.connect
      #end
      @redis_connection
    end
  
  
  
end
