class TranslationsController < ApplicationController
  def new
  end
   def dev_new
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
    if params[:translation][:dot_key_code0] != '' && params[:translation][:translation0] != '' then
      @translation0 = Translation.new
      @translation0.dot_key_code = params[:translation][:dot_key_code0]
      @translation0.translation = params[:translation][:translation0]
      if @translation0.save then
         result0 = :success
      else
        result0 = :error
      end
      debugger
      tflash('create_translation', result0, {:code => @translation0.dot_key_code, :translation=>@translation0.translation},true)
    end
    if params[:translation][:dot_key_code1] != '' && params[:translation][:translation1] != '' then
      @translation1 = Translation.new
      @translation1.dot_key_code = params[:translation][:dot_key_code1]
      @translation1.translation = params[:translation][:translation1]
      if @translation1.save then
         result1 = :success
      else
        result1 = :error
      end
       tflash('create_translation', result1, {:code =>@translation1.dot_key_code, :translation=>@translation1.translation},true)
    end
    if params[:translation][:dot_key_code2] != '' && params[:translation][:translation2] != '' then
      @translation2 = Translation.new
      @translation2.dot_key_code = params[:translation][:dot_key_code2]
      @translation2.translation = params[:translation][:translation2]
       if @translation1.save then
         result2 = :success
      else
        result2=:error
      end
      tflash('create_translation', result2, {:code =>@translation2.dot_key_code, :translation=>@translation1.translation},true)
    end
    if (!result0.nil? && result0 == :error) || (!result1.nil? && result1 == :error) || (!result2.nil? && result2 == :error)
      # go back to same screen
      render :action => "dev_new"  
    else
      render "dev_new"  
    end
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

end
