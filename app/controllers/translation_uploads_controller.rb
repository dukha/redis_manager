class TranslationUploadsController < ApplicationController
  # GET /translation_uploads
  # GET /translation_uploads.xml
  #before_filter :authenticate_user!
  
  @@model_translation_code = $ARM +  "translation_upload" +".one"
  def index
    @translation_uploads = TranslationUpload.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @translation_uploads }
    end
  end

  # GET /translation_uploads/1
  # GET /translation_uploads/1.xml
  def show
    @translation_upload = TranslationUpload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @translation_upload }
    end
  end

  # GET /translation_uploads/new
  # GET /translation_uploads/new.xml
  def new
    @translation_upload = TranslationUpload.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @translation_upload }
    end
  end

  # GET /translation_uploads/1/edit
  def edit
    @translation_upload = TranslationUpload.find(params[:id])
  end

  # POST /translation_uploads
  # POST /translation_uploads.xml
  def create
    @translation_upload = TranslationUpload.new(params[:translation_upload])

    respond_to do |format|
      if @translation_upload.save
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
        format.html { redirect_to(:action=>'index') }
        format.xml  { render :xml => @translation_upload, :status => :created, :location => @translation_upload }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @translation_upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /translation_uploads/1
  # PUT /translation_uploads/1.xml
  def update
    @translation_upload = TranslationUpload.find(params[:id])

    respond_to do |format|
      if @translation_upload.update_attributes(params[:translation_upload])
        flash[:success] = t('messages.update.success', :model=>t(@@model_translation_code))
        format.html { redirect_to(:action=>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @translation_upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /translation_uploads/1
  # DELETE /translation_uploads/1.xml
  def destroy
    @translation_upload = TranslationUpload.find(params[:id])
    
    File.delete @translation_upload.translation.path

    @translation_upload.destroy

    respond_to do |format|
      flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
      format.html { redirect_to(translation_uploads_url) }
      format.xml  { head :ok }
    end
  end
  def select_translation_to_redis
    @translation_upload = params[:translation_upload]
    @translation = Translation.new
    render "select_translation"
    #@translation_names =  Translation.all

  end
  def file_to_redis
     #translation_upload_id = params[:id]
     #translation_id = params[:translation_id]
     #debugger
     @translation_upload = TranslationUpload.find(params[:translation_upload])
     #file = @translation_upload.translation.path
     #@translation = Translation.find(params[:translation_id])
     #@translation_upload.write_to_redis(@translation)
     format.html { redirect_to(:action=>'index') }

  end
end
