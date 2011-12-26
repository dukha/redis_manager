class CalmappVersionsController < ApplicationController
  require 'translations_helper'
  include TranslationsHelper
  # GET /application_versions
  # GET /application_versions.xml
  #before_filter :authenticate_user!

  @@model="calmapp_version"
  
  def index
    @calmapp_versions = CalmappVersion.paginate(:page => params[:page], :per_page=>15)  #CalmappVersion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calmapp_versions }
    end
  end

  # GET /calmapp_versions/1
  # GET /calmapp_versions/1.xml
  def show
    @calmapp_version = CalmappVersion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calmapp_version }
    end
  end

  # GET /calmapp_versions/new
  # GET /calmapp_versions/new.xml
  def new
    @calmapp_version = CalmappVersion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @calmapp_version }
    end
  end

  # GET /calmapp_versions/1/edit
  def edit
    @calmapp_version = CalmappVersion.find(params[:id])
  end

  # POST /calmapp_versions
  # POST /calmapp_versions.xml
  def create
    #debugger
    @calmapp_version = CalmappVersion.new(params[:calmapp_version])

    respond_to do |format|
      if @calmapp_version.save
        tflash('create', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to( :action => "index")} #(@calmapp_version #, :notice => 'Application version was successfully created.') }
        format.xml  { render :xml => @calmapp_version, :status => :created, :location => @calmapp_version }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calmapp_version.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /calmapp_versions/1
  # PUT /calmapp_versions/1.xml
  def update
    @calmapp_version = CalmappVersion.find(params[:id])

    respond_to do |format|
      if @calmapp_version.update_attributes(params[:calmapp_version])
        tflash('update', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to( :action => "index")} #(@calmapp_version, :notice => 'Application version was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calmapp_version.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /calmapp_versions/1
  # DELETE /calmapp_versions/1.xml
  def destroy
    @calmapp_version = CalmappVersion.find(params[:id])
    @calmapp_version.destroy

    respond_to do |format|
      tflash('delete', :success, {:model=>@@model, :count=>1})
      format.html { redirect_to(calmapp_versions_url) }
      format.xml  { head :ok }
    end
  end
end
