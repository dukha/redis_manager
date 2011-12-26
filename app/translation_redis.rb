class TranslationRedis
   include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  #include TranslationParametersController
  #fix everything below to work with translation_parameters in session.
  attr_reader :redis_connection
  #attr_accessor :redis_database, :dot_key_code, :translation, :translation_message0, :translation_message1, :translation_message2#, :language, :dot_key_code_wrapped, :dot_key_code_last_key
  attr_accessor :redis_database, :dot_key_code0, :translation0, :dot_key_code1, :translation1, :dot_key_code2, :translation2, :translation_message0, :translation_message1, :translation_message2, :developer_params
  
  #attr_accessible :dot_key_code, :translation,:dot_key_code_wrapped, :dot_key_code_last_key, :dot_key_no_lang
  def self.all
    #redis_database = session[]
    #language=
    redis= redis_database.connect
    arr = Array.new
    search = (language ? (language.iso_code+"*") : "*"  )
    redis.key '*'.each do |k|
      arr.push  RedisTranslation.new(k, redis.get( k))
    end
    return arr
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
  
  def self.save
     
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
    @redis_translationt
  end
  def language
    @language
  end
  def redis_database= rd
     puts "redis database set"
    @redis_database = rd
     puts "@ set " + @redis_database
    connect
  end
  def dot_key_code=  dkc
    @dot_key_code = dkc
  end
  def translation= tr
    @translation = tr
  end
  def language= lang
    @language = lang
  end
  def redis_connection
    @redis_connection
  end
  def connect
    @redis_connection= @redis_database.connect
  end
  
  #This is just for display: Move to Helper
  def dot_key_code_wrapped
    if dot_key_code.nil? || dot_key_code.length < 20 then
      return dot_key_code
    else
      arr= dot_key_code.split('.')
      chars=0
      sep = '.'
      str = nil
      #puts 'a:' + arr.to_s
      arr.each do |part|
        #debugger
        #puts 'p:' + part
        chars += part.length
        if chars > 20 then
          sep='.<br>'
          chars =0
        end
        #puts 'c:' + chars.to_s
        if str.nil? then
          str = part
        else
          str += (sep + part)
        end
        #puts 's:' + str
      end
        #puts 'se:' + str
        return str.html_safe
      #line = dot_key_code[20..(dot_key_code.length - 1)]
      #index = line.replace( line.index('.')
    end
  end
  def dot_key_code_last_key
    return dot_key_code.split('.').last
  end
  def dot_key_code_no_lang
    arr = dot_key_code.split('.')
    return arr[1..(arr.length-1)].join('.')
  end
end
