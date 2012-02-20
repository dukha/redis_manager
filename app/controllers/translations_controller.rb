class TranslationsController < ApplicationController
  # RecordInvalid is thrown when a constaint is violated (e.g. uniqueness)
  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid
  #RecordNotUnique is thrown when the database unique constraint is violated. 
  #It is derived from the more general ActiveRecord::RecordInvalid
  rescue_from ActiveRecord::RecordNotUnique, :with => :record_not_unique
  #rescue_from ActiveRecord::RecordInvalid, :with => :record_not_unique
  @@model='translation'
  def new
  end
   def dev_new
     #debugger
    @translation = Translation.new
    
    @developer_param = DeveloperParam.new
    respond_to do |format|
      format.html
    end
  end
  def update
    #debugger
    @translation = Translation.find params[:id]

  respond_to do |format|
    if @translation.update_attributes(params[:translation])
      format.html { redirect_to(@translation, :notice => 'Translation was successfully updated.') }
      format.json { respond_with_bip(@translation) }
    else
      format.html { render :action => "edit" }
      format.json { respond_with_bip(@translation) }
    end
  end
  end

  def index
    #@translation_redises = TranslationRedis.find(@redis_connection, @language_id).paginate(:page => params[:page], :per_page=>25)  #Translation.all
    # We now do all our primary io via activerecord/postgres and only publish to redis....
   
    # to work with best_in_place to edit in the index html table we need to work with eager loading 
    # so that we can reference @translations as an array @transaltions[1] etc in the erb page
    # Thus use to use will_paginate we eagerly load, giving an array by using .all 
    # The array will still paginate provided we have will_paginate/array
    # messy but it works!! 
    searchable_attr = Translation.searchable_attr
    criteria=criterion_list(searchable_attr)
  
    operators=operator_list(searchable_attr, criteria)
  
    sortable_attr=Translation.sortable_attr
    sorting=sort_list(sortable_attr)
  
    require 'will_paginate/array'
    
    # Fix this when we get devise
   # current_user = UserWork.current_user_id
    # We need current_user for auth
    @translations = Translation.search(current_user, criteria, operators, sorting).paginate(:page => params[:page], :per_page=>25) 
    #puts "@translations: " + @translations.first.dot_key_code
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @translations }
    end
  end
  # contains a table that is editable
  def editable_list
    debugger
     @translations = Translation.paginate(:page => params[:page], :per_page=>25) 
    #puts "@translations: " + @translations.first.dot_key_code
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @translations }
    end
  end
  
  def edit
  end

  
  
  def create
     #debugger
    
    debugger
    translations = []
    translations_redis = []
    if params[:translation][:dot_key_code0] != '' && params[:translation][:translation0] != '' then
      @translation0 = Translation.new
      @translation0.dot_key_code = params[:translation][:dot_key_code0]
      @translation0.translation = params[:translation][:translation0]
      @translation0.calmapp_version_id = UserWork.calmapp_version.id
       #@translation_redis0 = TranslationRedis.new(@translation0.dot_key_code, @translation0.translation)
      #if @translation0.save then
       #  result0 = :success
      #else
      # result0 = :error
      #end
      #debugger
      #tflash('create_translation', result0, {:code => @translation0.dot_key_code, :translation=>@translation0.translation},true)
      translations << @translation0
    end
    if params[:translation][:dot_key_code1] != '' && params[:translation][:translation1] != '' then
      @translation1 = Translation.new
      @translation1.dot_key_code = params[:translation][:dot_key_code1]
      @translation1.translation = params[:translation][:translation1]
      @translation1.calmapp_version_id = UserWork.calmapp_version.id
      #@translation_redis1 = TranslationRedis.new(@translation1.dot_key_code, @translation1.translation)
      #if @translation1.save then
         #result1 = :success
      #else
        #result1 = :error
      #end
       #tflash('create_translation', result1, {:code =>@translation1.dot_key_code, :translation=>@translation1.translation},true)
       translations << @translation1
    end
    if params[:translation][:dot_key_code2] != '' && params[:translation][:translation2] != '' then
      @translation2 = Translation.new
      @translation2.dot_key_code = params[:translation][:dot_key_code2]
      @translation2.translation = params[:translation][:translation2]
      @translation2.calmapp_version_id = UserWorke.calmapp_version.id
       #@translation_redis2 = TranslationRedis.new(@translation2.dot_key_code, @translation2.translation)
       #if @translation2.save then
         #result2 = :success
      #else
        #result2=:error
      #end
      #tflash('create_translation', result2, {:code =>@translation2.dot_key_code, :translation=>@translation1.translation},true)
      translations << @translation2
    end
    # Need to do this do use a transaction
    @rolledback=false
    debugger
    Translation.save_multiple translations
    #This is actually called twice in case of rollback
    if !@rolledback then
      translations.each do |t|
        translations_redis << TranslationRedis.new_from_class(t)
      end  
      if TranslationRedis.save_multiple translations_redis then 
        reload_dev_new()
        
        tflash('create_relationaldb_redis', :success, {:code=>@translation0.dot_key_code + (@translation1.nil? ? ' ' : ' ' + @translation1.dot_key_code) + (@translation2.nil? ? ' ' : ' ' + @translation2.dot_key_code)})
      else
        # We need to delete the records from the rdb here
        tflash('create_relationaldb_redis', :warning, {:code=>@translation0.dot_key_code + (@translation1.nil? ? ' ' : ' ' + @translation1.dot_key_code) + (@translation2.nil? ? ' ' : ' ' + @translation2.dot_key_code)})
      end  
    end
    render "dev_new"  
 
  end
  
  def show
    debugger
    @translation = Translation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @translation }
    end
  end

  def destroy
  end
  
  protected
    # This method called when the DB uniqueness constraint is violated
    def record_not_unique exception
      debugger 
      
      flash.now[:error] = exception.message
      tflash("all_rolledback", :warning, {:model=>@@model, :count=>10}, true )
      #flash.now[:warning] = t($MS + "all_rolledback")
      reload_dev_new_after_rollback()
      render "dev_new"
    end
    
    # This method called when the rails uniqueness validation is violated
    def record_invalid exception
      #debugger
      flash.now[:error] =exception.message
      #flash.now[:warning] = t($MS + "all_rolledback")
      tflash("all_rolledback", :warning, {:model=>@@model, :count=>10}, true )
      reload_dev_new_after_rollback()
      render "dev_new"
    end
    def reload_dev_new
      @developer_param = DeveloperParam.new
      @developer_param.model=params[:developer_param][:model]
      @translation= Translation.new
    end
    def reload_dev_new_after_rollback
      reload_dev_new()
      @translation.dot_key_code0=params[:translation][:dot_key_code0]
      @translation.dot_key_code1=params[:translation][:dot_key_code1]
      @translation.dot_key_code2=params[:translation][:dot_key_code2]
      
      @translation.translation0=params[:translation][:translation0]
      @translation.translation1=params[:translation][:translation1]
      @translation.translation2=params[:translation][:translation2]
      
      
      @developer_param.attribute=params[:developer_param][:attribute]
      @developer_param.key_helper=params[:developer_param][:key_helper]
      @rollbacked = true
    end
end
