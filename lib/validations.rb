=begin
 This module is in lib dir which is not automatically loaded
 To have this on your path make sure that this line is in config/application.rb
 config.autoload_paths += %W(#{config.root}/lib)
 Otherwise you will need to do both (only the later if you autoload.)
 require 'validations'
 include Validations
=end
module Validations
  class EmailFormatValidator < ActiveModel::EachValidator
     def validate_each(object, attribute, value)
       # Regex below is a simplified regex for email
       # official
       # value =~ RFC2822::EmailAddress
       # which is probably this regex:
       # (?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])
       # more practical than the official
       # [a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?
       # Taking care of new top level domains, but apparently not international ones ...forget this
       # [a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)\b
       # railscasts
       # /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
       # more experimentation is needed before going internationally live

       unless value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
         object.errors[attribute] << (options[:message] || I18n.t($MS+ "invalid_email_format.error", :attribute => attribute, :value=> value))
       end
     end
   end

   class VersionFormatValidator < ActiveModel::EachValidator
     def validate_each(object, attribute, value)
       # Regex 0.0.0 is valid as is 99.99.99
       unless value =~ /([0-9]{1,2}).([0-9]{1,2}).([0-9]{1,2})/
         #debugger
         object.errors[attribute] << I18n.t($MS + "invalid_version_format.error", :value=>value) #(options[:message] || "messages.errors." +")
       end
     end
   end

   #class TranslationValidator < ActiveModel::Validator
     #def validate(record)
         #debugger
         #rescue_from Exception :with=> :bad_redis_index
         
         #begin
           #db= Redis.new :password => $REDIS_PW, :host=>record.host, :db=>record.redis_db_index.to_s
           #db.dbsize
           
           #return true
         #rescue => runtimeerror
           #record.errors[:base] << runtimeerror
           #return false
         #end
     #end
     #def bad_redis_index( exception)
       #msg= exception.message.gsub("\n", '<br>').html_safe
       #logger.error(exception.to_s)
       #tflash[:error] = msg

     #end
   #end
   #deprecated
   class RedisDbValidator< ActiveModel::EachValidator
     def validate_each(object,attribute, value)
       #
       #redis_db = Redis.new( :db=> value, :password=>$REDIS_PW, :port=>object.port, :host=> object..host)
       redis_db = Redis.new( :db=> value, :password=>object.redis_instance.password, :port=>object.redis_instance.port, :host=> object.redis_instance.host)
       # the above line doesn't try to connect immediately. You have to do something with it (like ping) to force it to connect.
       debugger
       redis_db.ping
     rescue Exception => e
       if e.message.index("invalid DB index") then
         object.errors[attribute] = I18n.t($MS + "invalid_redis_db_index.error", :value=>value)
       elsif e.message.index("getaddrinfo") then
         object.errors[:host] = I18n.t($MS + "invalid_redis_db_location.error", :value=>object.host)
       elsif e.message.index("Connection refused") then
         object.errors[:port] = I18n.t($MS + "redis_connection_refused.error", :value=>object.port)
       elsif e.message.index("invalid password") then
         object.errors[attribute] = I18n.t($MS + "invalid_redis_password.error", :value=>value)
       end
       # All exception handling in this case only works if you re-raise e only works if you raise e again
       #raise e
       puts object.errors[attribute]
     end #def rescue
   end
   # deprecated
   class RedisInstanceValidator< ActiveModel::EachValidator
     def validate_each(object,attribute, value)
       #
       #redis_db = Redis.new( :db=> value, :password=>$REDIS_PW, :port=>object.port, :host=> object..host)
       #debugger
       redis_db = Redis.new( :db=> 0, :password=>object.password, :port=>object.port, :host=> object.host)
       # the above line doesn't try to connect immediately. You have to do something with it (like ping) to force it to connect.
       #debugger
       redis_db.ping
     rescue Exception => e
       if e.message.index("invalid DB index") then
         object.errors[attribute] = I18n.t($MS + "invalid_redis_db_index.error", :value=>value)
       elsif e.message.index("getaddrinfo") then
         object.errors[:host] = I18n.t($MS + "invalid_redis_db_location.error", :value=>object.host)
       elsif e.message.index("Connection refused") then
         object.errors[:port] = I18n.t($MS+ "redis_connection_refused.error", :value=>object.port)
       elsif e.message.index("invalid password") then
         object.errors[:password] = I18n.t($MS + "invalid_redis_password.error", :value=>value)
       end
       # All exception handling in this case only works if you re-raise e only works if you raise e again
       #raise e
       puts object.errors[attribute]
     end #def rescue
   end
   # @deprecated Couldn't figure out how to do validates :with
   class RedisDbValidator2 < ActiveModel::Validator
      def validate(record)
        redis_db = Redis.new( :db=> record.redis_db_index, :password=>$REDIS_PW, :port=>record.port, :host=> record.host)
        redis_db.ping
      rescue Exception => e
        #if record.name.starts_with? 'X'
          #record.errors[:name] << 'Need a name starting with X please!'
        #end
        if e.message.index("invalid DB index") then
          record.errors[:redis_db_index] = I18n.t($MS + "invalid_redis_db_index.error", :value=>record.redis_db_index)
          #raise e
        elsif e.message.index("getaddrinfo") then
          record.errors[:host] = I18n.t($MS + "invalid_redis_db_location.error", :value=>record.host)
        elsif e.message.index("Connection refused") then
          object.errors[:port] = I18n.t($MS + "redis_connection_refused.error", :value=>record.port)
       else
         raise e
       end #invalid index
      end
   end
#ActiveRecord::DeleteRestrictionError
=begin
  This class is copied and modified from validates_existence gem.
  Mods fix i18n and prevent duplicate error messages displaying
=end
   class ExistenceValidator < ActiveModel::EachValidator
        include Exceptions
        def validate_each(record, attribute, value)
          #debugger
          puts attribute.to_s + " valid =" + value.to_s
          #remove the _id from the attribute with the association. Convert to symbol
          normalized = attribute.to_s.sub(/_id$/, "").to_sym
          #get the name of the association
          association = record.class.reflect_on_association(normalized)

          if association.nil? || !association.belongs_to?
            raise ArgumentError, "Cannot validate existence on #{normalized}, not a :belongs_to association"
          end

          target_class = nil

          # dealing with polymorphic belongs_to
          if association.options[:polymorphic]
            foreign_type = record.send(association.options[:foreign_type] || association.foreign_type)
            target_class = foreign_type.constantize unless foreign_type.nil?
          else
            target_class = association.klass
          end
          #debugger
          #The line below is changed so that it does not validate if the value is nil
          #In some cases nil may be valid. If it si not valid then add validates presence_of to the model
          #if value.nil? || target_class.nil? || !target_class.exists?(value)
          if ! value.nil? then
            if  target_class.nil? || !target_class.exists?(value) then
            #errors = [attribute]

            # add the error on both :relation and :relation_id
            #if options[:both]
              
              if Rails::VERSION::MAJOR == 3 and Rails::VERSION::MINOR == 0 then
                # rails 3.0
                foreign_key = association.primary_key_name
              else
                # this is for rails 3.1 and may be rails 4??
                foreign_key = association.foreign_key
              end

            #end
            #msg= I18n.t($MSE + "existence", :default=>"does not exist", :value=>value, :attribute=>attribute, :target=>target_class.name)
           
            record.errors[attribute]= I18n.t($MS + "existence.error", :default=>"does not exist", :value=>value, :attribute=>attribute, :target=>target_class.name)
            
            #raise InvalidBelongsToAssociation.new(record, attribute, value, target_class.name)
          end
        end
     end
  end
=begin
  
  #This class can't be found inside of validations.rb ???
  class SubOrganisationValidator < ActiveModel::Validator
    def validate(aLocation)
      aLocation.errors[:parent] << "Sub organisations are not permitted" unless aLocation.allow_organisation_ancestor?
    end
  end
=end 
end
