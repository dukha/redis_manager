class WhiteboardsController < ApplicationController
  require 'translations_helper'
  include TranslationsHelper
  # GET /whiteboards
  # GET /whiteboards.xml
  before_filter :authenticate_user!
  # almost replaced with global handler
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

 
 
  @@model = "whiteboard"
  @@model = @@model 
  def index
    # most recent first
    @whiteboards = Whiteboard.paginate(:page => params[:page], :per_page=>15, :order=>'updated_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @whiteboards }
    end
  end

  # GET /whiteboards/1
  # GET /whiteboards/1.xml
  def show
    @whiteboard = Whiteboard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @whiteboard }
    end
  end

  # GET /whiteboards/new
  # GET /whiteboards/new.xml
  def new
    @whiteboard = Whiteboard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @whiteboard }
    end
  end

  # GET /whiteboards/1/edit
  def edit
    @whiteboard = Whiteboard.find(params[:id])
  end

  # POST /whiteboards
  # POST /whiteboards.xml
  def create
    @whiteboard = Whiteboard.new(params[:whiteboard])

    respond_to do |format|
      if @whiteboard.save
        tflash('create', :success, {:model=>@@model})
        format.html { redirect_to(:action=>"index")} #, :notice => t('messages.create.success', :model=>@@model)) }
        format.xml  { render :xml => @whiteboard, :status => :created, :location => @whiteboard }
      else
        flash.now[:error] = t('messages.create.failure', :model=>t(@@model))
        format.html { render :action => "new" }
        format.xml  { render :xml => @whiteboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /whiteboards/1
  # PUT /whiteboards/1.xml
  def update
    @whiteboard = Whiteboard.find(params[:id])
    #rescue ActiveRecord::RecordNotFound, :with => :record_not_found
    respond_to do |format|
      if @whiteboard.update_attributes(params[:whiteboard])
        tflash('update', :success, {:model=>@@model})
        format.html { redirect_to(:action=>"index")} #, :notice => t('messages.update.success', :model=>@@model)) }
        format.xml  { head :ok }
      else
        flash.now[:error] = t('messages.update.failure', :model=>t(@@model))
        format.html { render :action => "edit" }
        format.xml  { render :xml => @whiteboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /whiteboards/1
  # DELETE /whiteboards/1.xml
  def destroy
    @whiteboard = Whiteboard.find(params[:id])
    @whiteboard.destroy
    tflash('delete', :success, {:model=>@@model, :count=>1})
    respond_to do |format|
      format.html { redirect_to(whiteboards_url) }
      format.xml  { head :ok }
    end
  end
  private
    def record_not_found exception
      tflash('record_not_found', :warning,  {:model=>t(@@model, :count=>1)})
      flash[:error] = exception.message
      respond_to do |format|
        format.html { redirect_to(whiteboards_url) }
        format.xml  { head :ok }
      end
    end
end
