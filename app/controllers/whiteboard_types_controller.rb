class WhiteboardTypesController < ApplicationController
  # GET /whiteboard_types
  # GET /whiteboard_types.xml
  # before_filter :authenticate_user!
  @@model ="whiteboard_type"
  @@model_translation_code =$ARM  +@@model +".one"
  def index
    @whiteboard_types = WhiteboardType.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @whiteboard_types }
    end
  end

  # GET /whiteboard_types/1
  # GET /whiteboard_types/1.xml
  def show
    @whiteboard_type = WhiteboardType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @whiteboard_type }
    end
  end

  # GET /whiteboard_types/new
  # GET /whiteboard_types/new.xml
  def new
    @whiteboard_type = WhiteboardType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @whiteboard_type }
    end
  end

  # GET /whiteboard_types/1/edit
  def edit
    @whiteboard_type = WhiteboardType.find(params[:id])
  end

  # POST /whiteboard_types
  # POST /whiteboard_types.xml
  def create
    puts "aa:"
    @whiteboard_type = WhiteboardType.new(params[:whiteboard_type])
    puts "xx:" #+ @whiteboard_type.to_s
    @whiteboard_type.save
    redirect_to(:action=>'index')
    puts "In WT"
=begin
    respond_to do |format|
      if @whiteboard_type.save
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
        format.html { redirect_to(:action=>'index')} #, :notice => t('messages.create.success', :model=>@@model)) }
        format.xml  { render :xml => @whiteboard_type, :status => :created, :location => @whiteboard_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @whiteboard_type.errors, :status => :unprocessable_entity }
      end
    end
=end
  end

  # PUT /whiteboard_types/1
  # PUT /whiteboard_types/1.xml
  def update
    @whiteboard_type = WhiteboardType.find(params[:id])

    respond_to do |format|
      if @whiteboard_type.update_attributes(params[:whiteboard_type])
        flash[:success] = t('messages.update.success', :model=>t(@@model_translation_code))
        format.html { redirect_to(:action=>'index')} #, :notice => t('messages.update.success', :model=>@@model)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @whiteboard_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /whiteboard_types/1
  # DELETE /whiteboard_types/1.xml
  def destroy
    @whiteboard_type = WhiteboardType.find(params[:id])
    @whiteboard_type.destroy
    flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
    respond_to do |format|
      format.html { redirect_to(whiteboard_types_url) }
      format.xml  { head :ok }
    end
  end
end
