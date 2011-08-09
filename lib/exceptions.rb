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
=begin

=end
  class IncorrectArrayFormatInYamlFileException < AbstractInternationalizedStandardError
    @@Translation_code = $MSE + "array_in_yaml_wrong_format"
    def initialize  line_number, translation_file_id
      super(@@Translation_code)
      @line_number = line_number
      @translation_file_id =translation_file_id
    end
    def file_name
        return TranslationFile.find(@translation_file_id).english_translation_file_name
    end

    def message
      m =   I18n.t(super,  :line_number=>@line_number, :file_name=>file_name)
      return m
    end
  end

  class IncorrectIndentationInYamlLineException < AbstractInternationalizedStandardError
    @@Translation_code = $MSE + "incorrect_indentation_in_yaml_file"
    def initialize line_number
      #debugger
      super @@Translation_code
      @line_number = line_number
    end

    def message
      m  =   I18n.t(super,  :line_number=>@line_number)
    end
  end
end
