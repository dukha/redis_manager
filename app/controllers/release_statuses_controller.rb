class ReleaseStatusesController < ApplicationController
  require 'translations_helper'
  include TranslationsHelper
  # GET /release_statuses
  # GET /release_statuses.xml
  #before_filter :authenticate_user!

  @@model = "release_status"
  
  def index
    @release_statuses = ReleaseStatus.paginate(:page => params[:page], :per_page=>15)  #ReleaseStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @release_statuses }
    end
  end

  # GET /release_statuses/1
  # GET /release_statuses/1.xml
  def show
    @vrelease_status = ReleaseStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @release_status }
    end
  end

  # GET /release_statuses/new
  # GET /release_statuses/new.xml
  def new
    @release_status = ReleaseStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @release_status }
    end
  end

  # GET /release_statuses/1/edit
  def edit
    @release_status = ReleaseStatus.find(params[:id])
  end

  # POST /release_statuses
  # POST /release_statuses.xml
  def create
    @release_status = ReleaseStatus.new(params[:release_status])

    respond_to do |format|
      if @release_status.save
        tflash('create', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to( :action => "index")} #(@release_status #, :notice => 'version status was successfully created.') }
        format.xml  { render :xml => @release_status, :status => :created, :location => @release_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @release_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /release_statuses/1
  # PUT /release_statuses/1.xml
  def update
    @release_status = ReleaseStatus.find(params[:id])

    respond_to do |format|
      if @release_status.update_attributes(params[:release_status])
        tflash('update', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to( :action => "index")} #(@release_status, :notice => 'version status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @release_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /release_statuses/1
  # DELETE /release_statuses/1.xml
  def destroy
    @release_status = ReleaseStatus.find(params[:id])
    @release_status.destroy
    tflash('delete', :success, {:model=>@@model})
    respond_to do |format|
      format.html { redirect_to(release_statuses_url) }
      format.xml  { head :ok }
    end
  end
end
