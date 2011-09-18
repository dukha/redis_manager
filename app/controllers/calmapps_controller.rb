class CalmappsController < ApplicationController
  #after_create do |record|
   # @calmapp_version.id = record.id
  #end
  # GET /applications
  # GET /calmapps.xml
  
  #before_filter :find_model,  :only => [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user!
  # almost replaced with global handler
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  
  #@@model ="application"
  @@model_translation_code =$ARM + "calmapp"
  def index
    #@applications = Calmapp.all
    @calmapps =  Calmapp.paginate(:page => params[:page], :per_page=>15)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calmapps }
    end
  end

  # GET /calmapps/1
  # GET /applications/1.xml
  def show
    @calmapp = Calmapp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calmapp }
    end
  end
  class AppLang
    attr_accessor :language_id, :iso_code, :write
    #attr_accessible
  end
  # GET /calmapps/new
  # GET /applications/new.xml
  def all_in_one_new
    #debugger
    puts "qqqq all in one"
    @calmapp = Calmapp.new
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
      format.xml  { render :xml => @calmapp }
    end
  end

  def new
    #debugger
    puts "wwwww n new"
    @calmapp = Calmapp.new
    @calmapp_version = CalmappVersion.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @calmapp }
    end
  end
  def create
    @calmapp = Calmapp.new(params[:calmapp])
    @calmapp_version =CalmappVersion.new(params[:calmapp_version]) 
    if @calmapp.save_app_version_database(@calmapp_version) then
       #@calmapp_version.calmapp_id = @calmapp.id
       #if @calmapp_version.save then
         flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code, :count=>1))
         redirect_to(:action=> :index)  #@calmapp }#(:action=>:index, :controller => :calmapps) }
         #format.xml  { render :xml => @calmapp, :status => :created, :location => @calmapp }
       #else

         #format.html { render :action => "new", :controller => "calmapp_versions" }
       #end
    else
      #format.html {
        flash[:error] = "Save of calmapp name = " + @calmapp.name + " version = " + @calmapp_version.major_version.to_s + ' failed.'
        render :action => "new", :controller => "calmapps"
      #}
      #format.xml  { render :xml => @calmapp.errors, :status => :unprocessable_entity }
    end
  end
  # GET /calmapps/1/edit
  def edit
    @calmapp = Calmapp.find(params[:id])

  end

  # POST /calmapps
  # POST /applications.xml
  def all_in_one_create
    @calmapp = Calmapp.new(params[:calmapp])
    #puts @calmapp
    #@app_langs = params[:app_langs]
    #debugger

    respond_to do |format|
      if @calmapp.save
        puts "zzzzz" + @calmapp.languages.to_s
        #if params[:version_name] then
          #@application_version= {:version=>params[:version_name], :version_status_id=> VersionStatus.where( :status, 'development')}
          #@calmapp.version.create!( @application_version)
        
          #if @calmapp.version != nil then
            flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code, :count=>1))
            format.html { redirect_to(:action=>:index) }
            format.xml  { render :xml => @calmapp, :status => :created, :location => @calmapp }
          #else
            #flash[:error] =  t(messages.errors.failed_to_save_version_in_application, :calmapp=>@application['name'], :version=>@calmapp_version['version'])
          #end
        #else
          #flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
          #format.html { redirect_to( :action => "index")} #(@application_version #, :notice => 'Application version was successfully created.') }
          #format.xml  { render :xml => @calmapp_version, :status => :created, :location => @application_version }
        #end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calmapp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /applications/1
  # PUT /calmapps/1.xml
  def update
    @calmapp = Calmapp.find(params[:id])
    if params[:calmapp][:language_ids]==nil then
      params[:calmapp][:language_ids] = Array.new
    end
   
    respond_to do |format|

      if @calmapp.update_attributes(params[:calmapp])
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code, :count=>1))
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calmapp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /calmapps/1.xml
  def destroy
    @calmapp = Calmapp.find(params[:id])
    @calmapp.destroy

    respond_to do |format|
      flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
      format.html { redirect_to(calmapps_url) }
      format.xml  { head :ok }
    end
  end

  private
    def record_not_found exception
      flash[:warning] = t('messages.record_not_found', :model=>t(@@model_translation_code, :count=>1))
      flash[:error] = exception.message
      respond_to do |format|
        format.html { redirect_to(calmapps_url) }
        format.xml  { head :ok }
      end
    end
end
