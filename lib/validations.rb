=begin
 This module is in lib dir which is not automatically loaded
 To have this on your path make sure that this line is in config/application.rb
 config.autoload_paths += %W(#{config.root}/lib
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
         object.errors[attribute] << (options[:message] || I18n.t($MSE+ "invalid_email_format", :attribute => attribute, :value=> value))
       end
     end
   end

   class VersionFormatValidator < ActiveModel::EachValidator
     def validate_each(object, attribute, value)
       # Regex 0.0.0 is valid as is 99.99.99
       unless value =~ /([0-9]{1,2}).([0-9]{1,2}).([0-9]{1,2})/
         debugger
         object.errors[attribute] << I18n.t($MSE + "invalid_version_format", :value=>value) #(options[:message] || "messages.errors." +")
       end
     end
   end

   class RedisDatabaseValidator < ActiveModel::Validator
     def validate(record)
         debugger
         #rescue_from Exception :with=> :bad_redis_index
         
         begin
           db= Redis.new :password => $REDIS_PW, :host=>record.host, :db=>record.redis_index.to_s
           db.dbsize
           record.errors[:base] << I18n.t($MSE + "invalid_redis_database_index", :value=>record.redis_index.to_s) #(options[:message] || "messages.errors." +")
         rescue => runtimeerror
           record.errors[:base] << runtimeerror
           return false
         end
     end
     def bad_redis_index( exception)
       msg= exception.message.gsub("\n", '<br>').html_safe
       logger.error(exception.to_s)
       flash[:error] = msg

     end
   end
end
