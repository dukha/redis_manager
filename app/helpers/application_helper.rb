module ApplicationHelper
  include WillPaginate::ViewHelpers
=begin
  These global constants are used as partial keys in yaml translation files
=end
  $A="actions."
  $AR="activerecord."
  $ARA=$AR + "attributes."
  $ARM= $AR + "models."
  $F="formtastic."
  $FL= $F+"labels."
  $FH=$F+"hints."
  $L="links."
  $LU="lookups."
  $M="menus."
  $MS="messages."
  $MSE=$MS+"errors."
  $REDIS_PW='123456'
  

  
  
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
       #translated_operation = t("actions." + action, :model=> t($ARM + model, :count=>1)) #t("actions.save", :model=> t($ARM + "whiteboard", :count=>1) )
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
  def lookup_translation lookup_object =nil, model_name=nil, options = nil
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
=begin
  This code will facilitate i18n in will_paginate
  just substitute twill_paginate for will_paginate
=end  
  def twill_paginate(collection = nil, options = {})
      will_paginate collection, {:previous_label => t('commons.previous'), :next_label => t('commons.next')}.merge(options)
  end
  
end
