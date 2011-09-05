class VersionStatusesController < ApplicationController
  # GET /version_statuses
  # GET /version_statuses.xml
  #before_filter :authenticate_user!

  @@model_translation_code =$ARM + "version_status.one"
  
  def index
    @version_statuses = VersionStatus.paginate(:page => params[:page], :per_page=>15)  #VersionStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @version_statuses }
    end
  end

  # GET /version_statuses/1
  # GET /version_statuses/1.xml
  def show
    @version_status = VersionStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @version_status }
    end
  end

  # GET /version_statuses/new
  # GET /version_statuses/new.xml
  def new
    @version_status = VersionStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @version_status }
    end
  end

  # GET /version_statuses/1/edit
  def edit
    @version_status = VersionStatus.find(params[:id])
  end

  # POST /version_statuses
  # POST /version_statuses.xml
  def create
    @version_status = VersionStatus.new(params[:version_status])

    respond_to do |format|
      if @version_status.save
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))          
        format.html { redirect_to( :action => "index")} #(@version_status #, :notice => 'version status was successfully created.') }
        format.xml  { render :xml => @version_status, :status => :created, :location => @version_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @version_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /version_statuses/1
  # PUT /version_statuses/1.xml
  def update
    @version_status = VersionStatus.find(params[:id])

    respond_to do |format|
      if @version_status.update_attributes(params[:version_status])
        flash[:success] = t('messages.update.success', :model=>t(@@model_translation_code))
        format.html { redirect_to( :action => "index")} #(@version_status, :notice => 'version status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @version_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /version_statuses/1
  # DELETE /version_statuses/1.xml
  def destroy
    @version_status = VersionStatus.find(params[:id])
    @version_status.destroy
    flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
    respond_to do |format|
      format.html { redirect_to(version_statuses_url) }
      format.xml  { head :ok }
    end
  end
end
