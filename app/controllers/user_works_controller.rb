class UserWorksController < ApplicationController
  
  # GET /translations
  # GET /translations.xml
  #before_filter :authenticate_user!
  @@model ="user_work"
  def index
    @user_works = UserWork.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_works }
    end
  end

  # GET /redis_databases/1
  # GET /redis_databases/1.xml
  def show
    @user_work = UserWork.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      
      format.xml  { render :xml => @user_work }
    end
  end

  # GET /redis_databases/new
  # GET /redis_databases/new.xml
  def new
    @user_work = UserWork.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_work }
    end
  end

  # GET /redis_databases/1/edit
  def edit
    @user_work = UserWork.find(params[:id])
  end

  # POST /redis_databases
  # POST /redis_databases.xml
  def create
    @user_work = UserWork.new(params[:redis_database])


    respond_to do |format|
      #if @user_work.create_redis_db
        if @user_work.save
          tflash('create', :success, {:model=>@@model, :count=>1})
          format.html { redirect_to(:action=>:index) }
          format.xml  { render :xml => @user_work, :status => :created, :location => @user_work }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user_work.errors, :status => :unprocessable_entity }
        end
      #else

      #end
    end
  end

  # PUT /redis_databases/1
  # PUT /redis_databases/1.xml
  def update
    @user_work = UserWork.find(params[:id])

    respond_to do |format|
      if @user_work.update_attributes(params[:redis_database])
        tflash('update', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /redis_databases/1
  # DELETE /redis_databases/1.xml
  def destroy
    @user_work = UserWork.find(params[:id])
    @user_work.destroy
    tflash('delete', :success, {:model=>@@model, :count=>1})
    respond_to do |format|
      format.html { redirect_to(redis_databases_url) }
      format.xml  { head :ok }
    end
  end

  
end
