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
 

  def index
     #@translation_redises = TranslationRedis.find(@redis_connection, @language_id).paginate(:page => params[:page], :per_page=>25)  #Translation.all
     # We now do all our primary io via activerecord/postgres and only publish to redis....
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
    
    #debugger
    translations = []
    if params[:translation][:dot_key_code0] != '' && params[:translation][:translation0] != '' then
      @translation0 = Translation.new
      @translation0.dot_key_code = params[:translation][:dot_key_code0]
      @translation0.translation = params[:translation][:translation0]
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
    Translation.save_multiple translations
    #This is actually called twice in case of rollback
    if !@rolledback
      
      reload_dev_new()
      tflash('create', :success, {:model=>@@model, :count=>1})
    end
    render "dev_new"  
    #@developer_param = DeveloperParam.new
    #@developer_param.model=params[:developer_param][:model]
    #@translation= Translation.new
=begin    
    if (!result0.nil? && result0 == :error) || (!result1.nil? && result1 == :error) || (!result2.nil? && result2 == :error)
      # go back to same screen
      
      @translation.dot_key_code0=params[:translation][:dot_key_code0]
      @translation.dot_key_code1=params[:translation][:dot_key_code1]
      @translation.dot_key_code2=params[:translation][:dot_key_code2]
      
      @translation.translation0=params[:translation][:translation0]
      @translation.translation1=params[:translation][:translation1]
      @translation.translation2=params[:translation][:translation2]
      
      
      @developer_param.attribute=params[:developer_param][:attribute]
      @developer_param.key_helper=params[:developer_param][:key_helper]
      render "dev_new"  
    else
      render :action => "dev_new"  
    end
=end
  
=begin
    respond_to do |format|
      if @translation.save
        tflash('create', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to( :action => "index")} #(@translation #, :notice => 'version status was successfully created.') }
        format.xml  { render :xml => @translation_redis, :status => :created, :location => @translation_redis }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @translation_redis.errors, :status => :unprocessable_entity }
      end
    end
=end
  end
  
  def update
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
      debugger
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
