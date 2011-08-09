class ApplicationController < ActionController::Base
  
  
  protect_from_forgery
  before_filter  :set_locale
  rescue_from Exception, :with => :rescue_all_exceptions  if Rails.env == 'production'
  $application_name = "CALM Translator"
  $application_version ="0.0.0 M1"
  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "Access denied!"
  #   redirect_to root_url
  # end

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


end
