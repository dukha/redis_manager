class UploadsController < ApplicationController
  # GET /uploads
  # GET /uploads.xml
  #before_filter :authenticate_user!
  
  @@model_translation_code = $ARM +  "upload" +".one"
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
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
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
        flash[:success] = t('messages.update.success', :model=>t(@@model_translation_code))
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
    
    File.delete @upload.translation.path

    @upload.destroy

    respond_to do |format|
      flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
      format.html { redirect_to(uploads_url) }
      format.xml  { head :ok }
    end
  end
  def select_translation_to_redis
    @upload = Upload.find(params[:id])
    @redis_database = RedisDatabase.new
    debugger
    render "select_translation"
    #@translation_names =  Translation.all

  end
  def file_to_redis
     #translation_upload_id = params[:id]
     #translation_id = params[:translation_id]
     #debugger
     @upload = Upload.find(params[:upload])
     #file = @translation_upload.translation.path
     #@translation = Translation.find(params[:translation_id])
     #@translation_upload.write_to_redis(@translation)
     format.html { redirect_to(:action=>'index') }

  end
end
