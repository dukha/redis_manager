=begin
Contains all application specific exceptions
You will need to add
require 'exceptions'
to your ruby file before raising an exception
as the lib directory where is is located is on the rails_path but not autoload
Otherwise in config/application.rb
config.autoload_paths += %W(#{config.root}/lib
=end
module Exceptions
  require File.join(Rails.root, "app", "/helpers" "/translations_helper.rb" ) #'app/helpers/translations_helper.rb'
  include TranslationsHelper

=begin
  This class can be used as a documentation for using i18n with application exceptions
  It does nothing other than change the name of the parameter name for StandardError to
  translation_code
=end
  class AbstractInternationalizedStandardError < StandardError
    # Use the message slot to hold the translation_code instead of message
    def initialize  translation_code
      super translation_code
    end
    
  end



  class IncorrectArrayFormatInYamlFileException < AbstractInternationalizedStandardError
    #include TranslationsHelper
    @@Translation_code = $MS + "array_in_yaml_wrong_format.error"#$MSE + "array_in_yaml_wrong_format"
    def initialize  line_number, upload_id
      super(@@Translation_code)
      @line_number = line_number
      @translation_file_id =translation_file_id
    end
    def file_name
        return Upload.find(@upload_id).upload_file_name
    end

    def message
      m =   I18n.t(super,  :line_number=>@line_number, :file_name=>file_name)
      return m
    end
  end
=begin
  class IncorrectIndentationInYamlLineException < AbstractInternationalizedStandardError
    @@Translation_code = $MSE + "incorrect_indentation_in_yaml_file"
    def initialize line_number
      super @@Translation_code
      @line_number = line_number
    end

    def message
      m  =   I18n.t(super,  :line_number=>@line_number)
    end
  end
=end
  class InvalidBelongsToAssociation < AbstractInternationalizedStandardError
    #include TranslationsHelper
    @@Translation_code = I18n.t($MSE + "existence")
    def initialize record, attribute, value, target
      super @@Translation_code
      @record = record
      @attribute = attribute
      @value = value
      @target = target
    end

    def record
      @record
    end
    def message
      @record.errors[@attribute]= I18n.t(super , :attribute => @attribute, :value=>@value, :target=>@target )
      return @record.errors[@attribute]
    end
  end

end
