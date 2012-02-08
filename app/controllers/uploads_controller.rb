class UploadsController < ApplicationController
  # GET /uploads
  # GET /uploads.xml
  #before_filter :authenticate_user!
  require 'translations_helper'
  include TranslationsHelper
  
  @@model =  "upload" 
  def index
    @uploads = Upload.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uploads }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.xml
  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.xml
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.xml
  def create
    @upload = Upload.new(params[:upload])

    respond_to do |format|
      if @upload.save
        tflash('create', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to(:action=>'index') }
        format.xml  { render :xml => @upload, :status => :created, :location => @upload }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.xml
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        tflash('update', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to(:action=>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.xml
  def destroy
    @upload = Upload.find(params[:id])
    
    File.delete @upload.upload.path

    @upload.destroy

    respond_to do |format|
      tflash('delete', :success, {:model=>@@model, :count=>1})
      format.html { redirect_to(uploads_url) }
      format.xml  { head :ok }
    end
  end

  def select_translation_to_redis
    @upload = Upload.find(params[:id])
    @redis_database = RedisDatabase.new
    #debugger
    render "select_translation"
    #@translation_names =  Translation.all

  end
  def file_to_db
    @upload = Upload.find(params[:id])
  end
  def file_to_redis
     #translation_upload_id = params[:id]
     #translation_id = params[:translation_id]
     #debugger
     @upload = Upload.find(params[:id])
     @redis_database =RedisDatabase.find(params[:redis_database][:id])
     if ! UploadsRedisDatabase.uploads_redis_db_exists? params[:id], params[:redis_database][:id] then
       @upload.write_to_redis @redis_database
       @uploads_redis_database= UploadsRedisDatabase.new
       @uploads_redis_database.upload_id =params[:id]
       @uploads_redis_database.redis_database_id=params[:redis_database][:id]
       if @uploads_redis_database.save then
         tflash("file_to_redis", :success, {:file=> @upload.upload_file_name})
         redirect_to(:action=>'index', :controller=>'uploads')
       else
         tflash('failed_to_save_file_written_to_redis', :error )
         render 'select_translation'
       end #save
     else
      tflash('file_already_written_to_redis', :error, {:file_name=>@upload.upload_file_name, :redis_name=>@redis_database.calmapp_version.name})
      render 'select_translation'
     end # not exists
     
     #debugger
     #file = @translation_upload.translation.path
     #@translation = Translation.find(params[:translation_id])
     #@translation_upload.write_to_redis(@translation)
       

  end
end
