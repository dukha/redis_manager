class UserPreferencesController < ApplicationController
  
  # GET /translations
  # GET /translations.xml
  #before_filter :authenticate_user!
  @@model ="user_preference"
  def index
    @user_preferences = UserPreference.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_preferences }
    end
  end

  # GET /redis_databases/1
  # GET /redis_databases/1.xml
  def show
    @user_preference = UserPreference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      
      format.xml  { render :xml => @user_preference }
    end
  end

  # GET /redis_databases/new
  # GET /redis_databases/new.xml
  def new
    @user_preference = UserPreference.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_preference }
    end
  end

  # GET /redis_databases/1/edit
  def edit
    @user_preference = UserPreference.find(params[:id])
  end

  # POST /redis_databases
  # POST /redis_databases.xml
  def create
    @user_preference = UserPreference.new(params[:redis_database])


    respond_to do |format|
      #if @user_preference.create_redis_db
        if @user_preference.save
          tflash('create', :success, {:model=>@@model, :count=>1})
          format.html { redirect_to(:action=>:index) }
          format.xml  { render :xml => @user_preference, :status => :created, :location => @user_preference }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user_preference.errors, :status => :unprocessable_entity }
        end
      #else

      #end
    end
  end

  # PUT /redis_databases/1
  # PUT /redis_databases/1.xml
  def update
    @user_preference = UserPreference.find(params[:id])

    respond_to do |format|
      if @user_preference.update_attributes(params[:redis_database])
        tflash('update', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_preference.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /redis_databases/1
  # DELETE /redis_databases/1.xml
  def destroy
    @user_preference = UserPreference.find(params[:id])
    @user_preference.destroy
    tflash('delete', :success, {:model=>@@model, :count=>1})
    respond_to do |format|
      format.html { redirect_to(redis_databases_url) }
      format.xml  { head :ok }
    end
  end

  
end
