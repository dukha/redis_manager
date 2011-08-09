class TranslationUploadsController < ApplicationController
  # GET /translation_uploads
  # GET /translation_uploads.xml
  #before_filter :authenticate_user!
  def index
    @translation_uploads = TranslationUpload.all

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
        format.html { redirect_to(@translation_upload, :notice => 'Translation upload was successfully created.') }
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
        format.html { redirect_to(@translation_upload, :notice => 'Translation upload was successfully updated.') }
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
    @translation_upload.destroy

    respond_to do |format|
      format.html { redirect_to(translation_uploads_url) }
      format.xml  { head :ok }
    end
  end
end
