class ApplicationVersionsController < ApplicationController
  # GET /application_versions
  # GET /application_versions.xml
  #before_filter :authenticate_user!

  @@model_translation_code =$ARM + "application_version.one"
  
  def index
    @application_versions = ApplicationVersion.paginate(:page => params[:page], :per_page=>15)  #ApplicationVersion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @application_versions }
    end
  end

  # GET /application_versions/1
  # GET /application_versions/1.xml
  def show
    @application_version = ApplicationVersion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @application_version }
    end
  end

  # GET /application_versions/new
  # GET /application_versions/new.xml
  def new
    @application_version = ApplicationVersion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @application_version }
    end
  end

  # GET /application_versions/1/edit
  def edit
    @application_version = ApplicationVersion.find(params[:id])
  end

  # POST /application_versions
  # POST /application_versions.xml
  def create
    #debugger
    @application_version = ApplicationVersion.new(params[:application_version])

    respond_to do |format|
      if @application_version.save
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))          
        format.html { redirect_to( :action => "index")} #(@application_version #, :notice => 'Application version was successfully created.') }
        format.xml  { render :xml => @application_version, :status => :created, :location => @application_version }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @application_version.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /application_versions/1
  # PUT /application_versions/1.xml
  def update
    @application_version = ApplicationVersion.find(params[:id])

    respond_to do |format|
      if @application_version.update_attributes(params[:application_version])
        flash[:success] = t('messages.update.success', :model=>t(@@model_translation_code))
        format.html { redirect_to( :action => "index")} #(@application_version, :notice => 'Application version was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @application_version.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /application_versions/1
  # DELETE /application_versions/1.xml
  def destroy
    @application_version = ApplicationVersion.find(params[:id])
    @application_version.destroy

    respond_to do |format|
      flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
      format.html { redirect_to(application_versions_url) }
      format.xml  { head :ok }
    end
  end
end
