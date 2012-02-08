class ApplicationController < ActionController::Base
  #require 'translations_helper'
  #include TranslationsHelper
  
  include Exceptions
  include Search
  protect_from_forgery
  before_filter  :set_locale
  #rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid
  rescue_from ActiveRecord::RecordInvalid do |exception|
    #tflash[:error] = exception.message
    render :action => (exception.record.new_record? ? :new : :edit)
  end
  rescue_from   InvalidBelongsToAssociation do |exception|
      #tflash[:error] = exception.message

      render :action => (exception.record.new_record? ? :new : :edit)
  end
  #Rescuing a violation of DB unique contstaint 
  rescue_from ActiveRecord::RecordNotUnique do |not_unique|
     message = not_unique.message
    if pgerror? not_unique then
        # We have a postgres non_unique error. This should only happen for multicolumn unique indexes
        # which cannot be properly trapped by active record.
        # We make a translatable more user friendly index
        message.gsub!("PGError:","")
        messages = message.split("\n")
        opening_bracket1_index = messages[1].index("(")
        closing_bracket1_index = messages[1].index(")", opening_bracket1_index )
        opening_bracket2_index = messages[1].index("(", closing_bracket1_index)
        closing_bracket2_index = messages[1].index(")", opening_bracket2_index )

        fieldlist = messages[1][(opening_bracket1_index+1)..(closing_bracket1_index-1)]
        model= nil

        if messages.length > 2 then
          messages[2].downcase!()
          tokens = messages[2].split(" ")
          #tokens[0] should be ':'
          if tokens[1] == 'insert' && tokens[2] == 'into' then
            model=tokens[3].delete("\"").singularize
          elsif
            if tokens[1] == 'update' then
              model= tokens[2].delete("\"").singularize
            end
          end
        end
        debugger
        translated_fields = fieldlist.split(",").collect{|f| tlabel(f.strip, model)}
        single_value = (translated_fields.split.length == 1)
        if  single_value then
          key_qualifier="non_unique_singlevalue_key."
        else
          key_qualifier="non_unique_multivalue_key."
        end

        #msg= single_value ?  "" : (t("messages." + key_qualifier + "error") + "<br>")
        msg_detail = t("messages." + key_qualifier + "error", :fieldlist=>"(" + translated_fields.join(", ") +")", :valuelist=>messages[1][opening_bracket2_index..closing_bracket2_index])
        user_friendly_message= (msg_detail).html_safe
      else
        user_friendly_message = message
      end
      #user_friendly_message
      #puts user_friendly_message
      flash[:error]= user_friendly_message
      debugger
      render :action => ((messages.length > 2) && (messages[2].index("INSERT INTO"))) ? :new : :edit
      #render :action => "new", :controller => "calmapps"
  end
  rescue_from Exception, :with => :rescue_all_exceptions  if Rails.env == 'production'

  $application_name = "CALM Translator"
  $application_version ="0.0.0 M1"
  

  # Is Authorization.current_user the same as current_user???
  #qq before_filter {|contr| Authorization.current_user = contr.current_user}
=begin
This function, together with the scope in routes.rb allows the setting of urls like http://example.com/en/products/1
=end
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def set_locale
    logger.debug "Param locale = " + (params[:locale]==nil ? "nil" : params[:locale].to_s)
    logger.debug "Session locale = " + (session[:locale] ==nil ? "nil" : session[:locale].to_s)
    I18n.locale = session[:locale] = params[:locale] || session[:locale] || :en #extract_locale_from_accept_language_header
    logger.info "Locale set to " + I18n.locale.to_s
  end
=begin
  This function will fall over if called outside the browser (like in rspec, for example)
=end
  def extract_locale_from_accept_language_header
    
    logger.info 'HTTP_ACCEPT_LANGUAGE = ' + request.env['HTTP_ACCEPT_LANGUAGE']
     request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    request.env['HTTP_ACCEPT_LANGUAGE'].split(",").first
  end

def pgerror? exception
    exception.message.start_with? "PGError:"
end
 

=begin
  Use this function to rescue all situations
  Add exception for no
=end
  def rescue_all_exceptions(exception)
    case exception
      when ActiveRecord::RecordNotFound
        # render :text => "Invalid request", :status => :not_found

      else
        logger.error( "\nWhile processing a #{request.method} request on #{request.path}\n
        parameters: #{request.parameters.inpect}\n
        #{exception.message}\n#{exception.clean_backtrace.join( "\n" )}\n\n" )
        #render :text => "An internal error occurred. Sorry for inconvenience", :status => :internal_server_error
    end
  end
=begin
 def record_invalid(exception)
    flash[:error] = exception.message + " " + exception.record.to_s
  end
=end
end

