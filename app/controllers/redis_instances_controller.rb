class RedisInstancesController < ApplicationController
  require 'translations_helper'
  include TranslationsHelper
  # GET /translations
  # GET /translations.xml
  #before_filter :authenticate_user!
  @@model="redis_instance"
  def index
    @redis_instances = RedisInstance.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @redis_instances }
    end
  end

  # GET /redis_instances/1
  # GET /redis_instances/1.xml
  def show
    @redis_instance = RedisInstance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @redis_instance }
    end
  end

  # GET /redis_instances/new
  # GET /redis_instances/new.xml
  def new
    @redis_instance = RedisInstance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @redis_instance }
    end
  end

  # GET /redis_instances/1/edit
  def edit
    @redis_instance = RedisInstance.find(params[:id])
  end

  # POST /redis_instances
  # POST /redis_instances.xml
  def create
    @redis_instance = RedisInstance.new(params[:redis_instance])


    respond_to do |format|
      #if @redis_instance.create_redis_db
        #debugger
        if @redis_instance.save
          tflash('create', :success, {:model=>@@model, :count=>1})
          format.html { redirect_to(:action=>:index) }
          format.xml  { render :xml => @redis_instance, :status => :created, :location => @redis_instance }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @redis_instance.errors, :status => :unprocessable_entity }
        end
      #else

      #end
    end
  end

  # PUT /redis_instances/1
  # PUT /redis_instances/1.xml
  def update
    @redis_instance = RedisInstance.find(params[:id])

    respond_to do |format|
      if @redis_instance.update_attributes(params[:redis_instance])
        tflash('update', :success, {:model=>@@model, :count=>1})
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @redis_instance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /redis_instances/1
  # DELETE /redis_instances/1.xml
  def destroy
    @redis_instance = RedisInstance.find(params[:id])
    @redis_instance.destroy
    tflash('delete', :success, {:model=>@@model, :count=>1})
    respond_to do |format|
      format.html { redirect_to(redis_instances_url) }
      format.xml  { head :ok }
    end
  end

  def unused_redis_database_indexes
    puts  "unused_redis_database_indexes"
    debugger
    ri = RedisInstance.find(params[:redis_instance_id])
    data = ri.unused_redis_database_indexes()
    if request.xhr?
      render :json => data
    end 
  
  end  
end
