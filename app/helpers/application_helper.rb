module ApplicationHelper
  include WillPaginate::ViewHelpers
  require 'translations_helper'
  include TranslationsHelper
=begin
  These global constants are used as partial keys in yaml translation files
  Moved to translations_helper
  $A="actions."
  $AR="activerecord."
  $ARA=$AR + "attributes."
  $ARM= $AR + "models."
  $F="formtastic."
  $FL= $F+"labels."
  $FH=$F+"hints."
  $FA = $F + "actions."
  $L="links."
  $LU="lookups."
  $M="menus."
  $MS="messages."
  $MSE=$MS+"errors."
  $REDIS_PW='123456'
  $TM="translation missing:"
=end
  
  
  def titler
    if @title.nil?
      $application_name
    else
      "#{$application_name} : #{@title}"
    end
  end

  def logo
    image_tag( "bodhi.gif", :alt => "Bodhi leaf not found", :height=>"50px")
  end
  # you need this if you are doing hebrew or arabic
  def text_direction
    I18n.translate(:'bidi.direction') == 'right-to-left' ? 'rtl' : 'ltr'
    # in ../locale/he.yml add
    # he:
        #bidi:
        #direction: right-to-left
    # then in ../locale/root.yml  add
    # root:
       #bidi:
       #  direction: left-to-right
  end

  #def set_user_language   # (id)
       #logger.info current_user
       #I18n.locale =:en
      #NOt until devise is installed :I18n.locale = Language.find_by_id(current_user.language_id).iso_code if current_user != nil
      #logger.info("App controller i18n.locale = " +I18n.locale.to_s)
      #I18n.locale= Language.find_by_id(id).iso_code
      #logger.info("App controller i18n.locale = " +I18n.locale.to_s)
      #default_url_options(options={})
  #end
=begin
@deprecated (code to call this is in share._errors.html.erb)
=end
  #def error_count_display object,  action="save", model
     #if object.errors.any?
       #translated_operation = t("actions." + action, :model=> t($ARM + model, :count=>1}) #t("actions.save", :model=> t($ARM + "whiteboard", :count=>1) )
       #text =    t("commons.problem", :count=>object.errors.count)
       #return t("messages.operation.failure", :count_message=>text, :operation=> translated_operation)
     #end
  #end
=begin
@deprecated (code to call this is in share._errors.html.erb)
=end
  #def error_list object
    #if object.errors.any?
      #return object.errors.full_messages #.each do |msg|
    #else
      #return Array.new
    #end
  #end

=begin
   This function will return the translation of objects in lookup tables. The translations come in the form of
   <lang>.lookups.<model>.<attribute>
   and
   <lang>.lookups.<model>.<attribute>.description
   lookup_object is the model object e.g. course_type
   model_name is the name of the model e.g. "course_type"
  options are either "name" or "description". Defaults to name
=end
=begin
  def tlookup lookup_object =nil, model_name=nil, options = nil
    #debugger
    if lookup_object == nil || lookup_object.id == nil || model_name==nil then
      return ""
    else
      if options==nil || options["name"] then
        return t($LU +model_name.downcase + "." + lookup_object.translation_code)
      elsif options["description"] then
        return t($LU +model_name.downcase + '.description.'+lookup_object.translation_code)
      else
        return ""
      end
    end
  end
=end
=begin
def t_pgerror exception
    # remove the PGError designation
    message.gsub("PGError:","")
    if exception.is_a? ActiveRecord::RecordNotUnique
      t_pgerror_non_unique
    end
    messages = message.split("\n")
    opening_bracket1_index = messages[1].index("(")
    closing_bracket1_index = messages[1].index(")", opening_bracket1_index )
    opening_bracket2_index = messages[1].index("(", closing_bracket1_index)
    closing_bracket2_index = messages[1].index(")", opening_bracket2_index )
    msg= t("messages.non_unique_multivalue_key.error")
    fieldlist = messages[1][(opening_bracket1_index+1)..(closing_bracket1_index-1)]
    translated_fields = fieldlist.split(",").collect{|f| t($FL + f.strip)}

    msg_detail = t("messages.non_unique_multivalue_key.detailed_error", :fieldlist=>"(" + translated_fields.join(", ") +")", :valuelist=>messages[1][opening_bracket2_index..closing_bracket2_index])
    user_friendly_message= (msg + "<br>" + msg_detail).html_safe
  end
=end


   
end
