class RedisDatabasesController < ApplicationController
  # GET /translations
  # GET /translations.xml
  #before_filter :authenticate_user!
  @@model_translation_code =$ARM  +"redis_database.one"
  def index
    @redis_databases = RedisDatabase.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @redis_databases }
    end
  end

  # GET /redis_databases/1
  # GET /redis_databases/1.xml
  def show
    @redis_database = RedisDatabase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @redis_database }
    end
  end

  # GET /redis_databases/new
  # GET /redis_databases/new.xml
  def new
    @redis_database = RedisDatabase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @redis_database }
    end
  end

  # GET /redis_databases/1/edit
  def edit
    @redis_database = RedisDatabase.find(params[:id])
  end

  # POST /redis_databases
  # POST /redis_databases.xml
  def create
    @redis_database = RedisDatabase.new(params[:redis_database])


    respond_to do |format|
      #if @redis_database.create_redis_db
        if @redis_database.save
          flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
          format.html { redirect_to(:action=>:index) }
          format.xml  { render :xml => @redis_database, :status => :created, :location => @redis_database }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @redis_database.errors, :status => :unprocessable_entity }
        end
      #else

      #end
    end
  end

  # PUT /redis_databases/1
  # PUT /redis_databases/1.xml
  def update
    @redis_database = RedisDatabase.find(params[:id])

    respond_to do |format|
      if @redis_database.update_attributes(params[:redis_database])
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @redis_database.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /redis_databases/1
  # DELETE /redis_databases/1.xml
  def destroy
    @redis_database = RedisDatabase.find(params[:id])
    @redis_database.destroy
    flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
    respond_to do |format|
      format.html { redirect_to(redis_databases_url) }
      format.xml  { head :ok }
    end
  end

  
end
