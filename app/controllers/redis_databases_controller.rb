class RedisDatabasesController < ApplicationController
  require 'translations_helper'
  include TranslationsHelper
  # GET /translations
  # GET /translations.xml
  #before_filter :authenticate_user!
  @@model ="redis_database"
  def index
    @redis_databases = RedisDatabase.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @redis_databases }
    end
  end

  # GET /redis_databases/1
  # GET /redis_databases/1.xml
  def show
    @redis_database = RedisDatabase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.yml { render :yml => @redis_database.redis_to_yaml }
      #format.xml  { render :xml => @redis_database }
    end
  end

  # GET /redis_databases/new
  # GET /redis_databases/new.xml
  def new
    @redis_database = RedisDatabase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @redis_database }
    end
  end

  # GET /redis_databases/1/edit
  def edit
    @redis_database = RedisDatabase.find(params[:id])
  end

  # POST /redis_databases
  # POST /redis_databases.xml
  def create
    @redis_database = RedisDatabase.new(params[:redis_database])


    respond_to do |format|
      #if @redis_database.create_redis_db
        if @redis_database.save
          tflash('create', :success, {:model=>@@model, :count=>1})
          format.html { redirect_to(:action=>:index) }
          format.xml  { render :xml => @redis_database, :status => :created, :location => @redis_database }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @redis_database.errors, :status => :unprocessable_entity }
        end
      #else

      #end
    end
  end

  # PUT /redis_databases/1
  # PUT /redis_databases/1.xml
  def update
    @redis_database = RedisDatabase.find(params[:id])

    respond_to do |format|
      if @redis_database.update_attributes(params[:redis_database])
        tflash('update', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @redis_database.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /redis_databases/1
  # DELETE /redis_databases/1.xml
  def destroy
    @redis_database = RedisDatabase.find(params[:id])
    @redis_database.destroy
    tflash('delete', :success, {:model=>@@model, :count=>1})
    respond_to do |format|
      format.html { redirect_to(redis_databases_url) }
      format.xml  { head :ok }
    end
  end

  def redis_to_yaml_get_file
     @redis_database= RedisDatabase.find(params[:id])
     render "select_yaml_file"
  end
  def redis_to_yaml
    @redis_database= RedisDatabase.find(params[:id])
    @file = File.new params[:file]
    @redis_database.redis_to_yaml @file
  end
  
  
end
