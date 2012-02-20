class RedisDatabase < ActiveRecord::Base
  include Validations
  #validates :with => RedisDbValidator2
  belongs_to :calmapp_version
  belongs_to :redis_instance
  belongs_to :release_status
  #has_many :uploads_redis_databases
  #has_many :uploads, :through => :uploads_redis_databases
  validates :calmapp_version_id, :existence => true, :presence=>true
  validates :redis_db_index, :presence=>true
  
  validates :release_status_id, :presence=>true, :existence=>true
  #validates :release_status_id, :existence=>true
  #validates :calmapp_version_id,:presence=>true
  #validates :host,:presence=>true
  #validates :port, :presence => true
  #This validation checks whether the redis_db_index is one permitted by the installation.
  #Returns false if not. Default redis setup is for databases 0-15 to be avilable.
  #This can be increased in the redis config file (not via rails)
  #validates  :redis_db_index, :redis_db => true
  #validates_with Validations::TranslationValidator

  
  @connection=nil
  def save!
    if new_record?
      state='new'
    end
    super
    new_record state
  end
  def save
    if new_record?
      state='new'
    end
    super
    new_record state
  end 
  def new_record state
    if state=='new' then
      redis = connect
      redis.flushdb
      temp_redis = Redis.new :db=> 0, :password=> redis_instance.password, :host=> redis_instance.host, :port=> redis_instance.port 
      temp_redis.set name, redis_db_index
    end
  end
  def name
    return CalmappVersion.find(calmapp_version_id).name + " / Redis Database Index: " + redis_db_index.to_s
  end
  # returns an instance of Redis class
  def connect
    #@connection is a singleton: only 1 connection per database" will need testing in a multiuser situation
    if ! @connection then
      @connection = Redis.new :db=> redis_db_index, :password=> redis_instance.password, :host=> redis_instance.host, :port=> redis_instance.port
    end
    return @connection
     
  end

  def database_supports_language? language
    if language.is_a(Language) then
      language = language.id
    end
    return calmapp_version.language_ids.include? language
  end

  def redis_to_yaml #file
    redis = Redis.new(:db=>redis_db_index, :host=>redis_instance.host, :port=> redis_instance.port, :password=>redis_instance.password )
    key_array= redis.keys('*')
    container = Hash.new
    key_array.each{ |k|
      emit_1_dot_key_value( k, redis.get(k), container)
    }
    puts container.to_yaml
    return container.to_yaml
  end
  
  def redis_instance
    if @redis_instance.nil? then
      @redis_instance = RedisInstance.find(redis_instance_id)
    end
    return @redis_instance  
  end
  

  def port
    return redis_instance.port
  end
  
  def host
    return redis_instance.host
  end
  
  def password
    return redis_instance.password
  end
  
  
=begin
  # This method takes a key and value, for example from redis and puts it into container, in a form readily converted to yaml
  def emit_1_dot_key_value(dot_key, val, container)
    partial_keys = dot_key.split(".")
    traverse_dot_key( partial_keys, val, container)
  end

  def traverse_dot_key parts, val, container
    if parts.length > 0 then
      if  container.is_a? Hash then
        if  container.key? parts[0] then
          traverse_dot_key parts[1..parts.length-1],val, container[parts[0]]
          return
        else
          #parts[0] is not in Hash as key
          if parts.length == 1 then
            #last partial, so store the value
            container.store(parts[0], val)
            return
          elsif parts.length==2 then
            # check to see if we need to add an array or hash for the last container
            if parts[1] =~ /[0-9]{3}/ then
              # we are in a sequence coming up
              new_sub_container = Array.new
            else
              new_sub_container = Hash.new
            end
            #container.store(parts[0], new_sub_container)
          else
            # parts length is > 2 i.e. not a special case
            new_sub_container= Hash.new
          end
            container.store(parts[0], new_sub_container)
            traverse_dot_key(parts[1..(parts.length-1)], val, new_sub_container)
            return
        end
      elsif container.is_a? Array then
          container.push val
          return
      elsif container[parts[0]].is_a? String then
          # the key apparently has a value and so key is in error
          raise Exception.new("This key already has a value:" + parts.join( "."))
          return
      else
          # this is an error
          raise Exception.new( "There is a partial key that is wrong in the dot_key: Partial Key = " + parts[0] + " in dot key = " + parts.join("."))
          return
      end # pars[0] is hash

    else
      #empty array
      raise Exception.new( "Empty array passed with value " + val + " when parsing file.")
      return
    end
  end
=end
end





# == Schema Information
#
# Table name: redis_databases
#
#  id                 :integer         not null, primary key
#  calmapp_version_id :integer         not null
#  redis_instance_id  :integer
#  redis_db_index     :integer         not null
#  release_status_id  :integer         not null
#  created_at         :datetime
#  updated_at         :datetime
#

