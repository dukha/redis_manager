class ApplicationsController < ApplicationController
  # GET /applications
  # GET /applications.xml
  
  #before_filter :find_model,  :only => [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user!
  # almost replaced with global handler
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  @@model ="application"
  @@model_translation_code =$ARM + "application" +".one"
  def index
    #@applications = Application.all
    @applications =  Application.paginate(:page => params[:page], :per_page=>15)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @applications }
    end
  end

  # GET /applications/1
  # GET /applications/1.xml
  def show
    @application = Application.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @application }
    end
  end
  class AppLang
    attr_accessor :language_id, :iso_code, :write
    #attr_accessible
  end
  # GET /applications/new
  # GET /applications/new.xml
  def new
    #debugger
    @application = Application.new
    #@application.id=nil
    #@languages = Language.all
    #@app_langs=[]
    #debugger
    #@languages.each {|l|
      #al=AppLang.new
      #debugger
      #al.language_id = l.id
      #al.iso_code = l.iso_code
      #al.write = false
      #@app_langs<<al
    #  al.language_id = l.id
    #  @application.languages << al
    #}
    #@application.languages=@languages

    #debugger
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @application }
    end
  end

  # GET /applications/1/edit
  def edit
    @application = Application.find(params[:id])
  end

  # POST /applications
  # POST /applications.xml
  def create
    @application = Application.new(params[:application])
    #puts @application
    #@app_langs = params[:app_langs]
    #debugger

    respond_to do |format|
      if @application.save
        puts "zzzzz" + @application.languages.to_s
        #if params[:version_name] then
          #@application_version= {:version=>params[:version_name], :version_status_id=> VersionStatus.where( :status, 'development')}
          #@application.version.create!( @application_version)
        
          #if @application.version != nil then
            flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
            format.html { redirect_to(:action=>:index) }
            format.xml  { render :xml => @application, :status => :created, :location => @application }
          #else
            #flash[:error] =  t(messages.errors.failed_to_save_version_in_application, :application=>@application['name'], :version=>@application_version['version'])
          #end
        #else
          #flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
          #format.html { redirect_to( :action => "index")} #(@application_version #, :notice => 'Application version was successfully created.') }
          #format.xml  { render :xml => @application_version, :status => :created, :location => @application_version }
        #end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /applications/1.xml
  def update
    @application = Application.find(params[:id])
    if params[:application][:language_ids]==nil then
      params[:application][:language_ids] = Array.new
    end
   
    respond_to do |format|

      if @application.update_attributes(params[:application])
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.xml
  def destroy
    @application = Application.find(params[:id])
    @application.destroy

    respond_to do |format|
      flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
      format.html { redirect_to(applications_url) }
      format.xml  { head :ok }
    end
  end

  private
    def record_not_found exception
      flash[:warning] = t('messages.record_not_found', :model=>t(@@model_translation_code))
      flash[:error] = exception.message
      respond_to do |format|
        format.html { redirect_to(applications_url) }
        format.xml  { head :ok }
      end
    end
end
