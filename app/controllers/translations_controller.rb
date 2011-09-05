class TranslationsController < ApplicationController
  # GET /translations
  # GET /translations.xml
  #before_filter :authenticate_user!
  @@model_translation_code =$ARM  +"translation.one"
  def index
    @translations = Translation.paginate(:page => params[:page], :per_page=>15)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @translations }
    end
  end

  # GET /translations/1
  # GET /translations/1.xml
  def show
    @translation = Translation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @translation }
    end
  end

  # GET /translations/new
  # GET /translations/new.xml
  def new
    @translation = Translation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @translation }
    end
  end

  # GET /translations/1/edit
  def edit
    @translation = Translation.find(params[:id])
  end

  # POST /translations
  # POST /translations.xml
  def create
    @translation = Translation.new(params[:translation])


    respond_to do |format|
      #if @translation.create_redis_db
        if @translation.save
          flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
          format.html { redirect_to(:action=>:index) }
          format.xml  { render :xml => @translation, :status => :created, :location => @translation }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @translation.errors, :status => :unprocessable_entity }
        end
      #else

      #end
    end
  end

  # PUT /translations/1
  # PUT /translations/1.xml
  def update
    @translation = Translation.find(params[:id])

    respond_to do |format|
      if @translation.update_attributes(params[:translation])
        flash[:success] = t('messages.create.success', :model=>t(@@model_translation_code))
        format.html { redirect_to(:action=>:index) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @translation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /translations/1
  # DELETE /translations/1.xml
  def destroy
    @translation = Translation.find(params[:id])
    @translation.destroy
    flash[:success]= t('messages.delete.success', :model=>t(@@model_translation_code))
    respond_to do |format|
      format.html { redirect_to(translations_url) }
      format.xml  { head :ok }
    end
  end

  
end
