class LanguagesController < ApplicationController
  require 'translations_helper'
  include TranslationsHelper
  # GET /languages
  # GET /languages.xml
  #before_filter :authenticate_user!, :except=> :change_application_language
  @@model ="language"
  
  def index
    @languages = Language.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @languages }
    end
  end

  # GET /languages/1
  # GET /languages/1.xml
  def show
    @language = Language.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @language }
    end
  end

  # GET /languages/new
  # GET /languages/new.xml
  def new
    @language = Language.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @language }
    end
  end

  # GET /languages/1/edit
  def edit
    @language = Language.find(params[:id])
  end

  # POST /languages
  # POST /languages.xml
  def create
    @language = Language.new(params[:language])

    respond_to do |format|
      if @language.save
        tflash('create', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to(:action=>"index")} # , :notice => t('messages.create.success', :model=>@@model)) }
        format.xml  { render :xml => @language, :status => :created, :location => @language }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /languages/1
  # PUT /languages/1.xml
  def update
    @language = Language.find(params[:id])

    respond_to do |format|
      if @language.update_attributes(params[:language])
        tflash('update', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to(:action=>'index')} #, :notice => t('messages.update.success', :model=>@@model)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1
  # DELETE /languages/1.xml
  def destroy
    @language = Language.find(params[:id])
    @language.destroy
     tflash('delete', :success, {:model=>@@model, :count=>1})
    respond_to do |format|
      format.html { redirect_to(languages_url) }
      format.xml  { head :ok }
    end
  end
=begin
  From anywhere in the application the user can change language
=end
  def change_calmapp_language
    #check that the iso_code is valid
    @language =Language.find_by_iso_code(params[:iso_code])
    #debugger
    
    session[:locale] = @language.iso_code
    log = Logger.new (STDOUT)
    log.debug "set locale in session " + session[:locale].to_s
    if request.xhr?
        # return language data to js calling routine (success)
        render :json => @language
    end
  end

  def upload_yaml_translation_file
    
  end
end
