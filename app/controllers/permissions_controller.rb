class PermissionsController < ApplicationController

  before_filter :authenticate_user!
  filter_access_to :set_current_by_ajax do
    true                  # anyone can select from the permissions they were granted
  end
  filter_access_to :select do
    true                  # anyone can select from the permissions they were granted
  end
  filter_access_to :all   # deny anything not mentioned above
  filter_access_to :all

  # GET /permissions
  # GET /permissions.xml
  # after successful authetication devise redirects to 
  # -> root 
  # -> /:locale 

  # -> PermissionsController#index#locale allows User to choose permission (= organisation & roles)
  # -> WhiteboardsController#index#locale


  # after devise has authenticated it has set current_user and it redirects to root
  # route root invokes this action
  def select
    
    if !current_user.nil? and !current_user.current_permission.nil?
      flash.keep
      
      redirect_to whiteboards_path and return
    end
    
    @user = current_user
    @permissions = current_user.permissions
    respond_to do |format|
      format.html # select.html.erb
      format.xml  { render :xml => @permissions }
   end 
   puts languages_url + "perms-cc"
  end

  def set_current
    @selected_permission = Permission.find params[:id]
    @selected_permission.be_current_permission_for current_user
    current_user.save
    Rails.logger.info "**** In action permissions#set_current: #{current_user.greeting} #{current_user.object_id}"
    
    redirect_to whiteboards_path
  end

  def set_current_by_ajax

    # from layouts/_header.html.erb,  data:       { id:  permissionId },

    @selected_permission = Permission.find params[:id]  #todo use both user id and from route
    @selected_permission.be_current_permission_for current_user
    current_user.save
    Rails.logger.info "**** In action permissions#set_current: #{current_user.greeting} #{current_user.object_id}"

    # returning some json to the javascript in the _header layout because it is waiting for that
    # one cannot have multiple redirect_to and/or render! Window refresh needs to be done in javascript
    render :json => {:result => "ok"}
  end

  # this resource is nested in users: params[:user_id]
  # show only permissions with locations in subtree of current_user.current_organisation
  def index
    @user = User.find_by_id!(params[:user_id])
    @permissions = Permission.for_user(@user).under_location(current_user.current_organisation).paginate(:page => params[:page], :per_page => 15)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @permissions }
    end
  end

  # GET /permissions/1
  # GET /permissions/1.xml
  def show
    @permission = Permission.find_by_id_and_user_id!(params[:id],params[:user_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /auth_user/16/permissions/new
  # GET /auth_user/16/permissions/new.xml
  def new
    #@permission = Permission.new :user_id => params[:user_id]
    @permission = Permission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find_by_id_and_user_id!(params[:id],params[:user_id])
  end

  # POST /permissions
  # POST /permissions.xml
  def create
    # needs: user_id | organisation_id | profile_id
    # but params seemd to be missing user_id !
    # Rails.logger.info "&&&&&&&&&&&&"+ params.to_s
    # &&&&&&&&&&&&{"utf8"=>"✓", "authenticity_token"=>"tsqtdCcALnfkLJO7+zPa1CfDTyp0iMWm2XtN0+u7rPA=", 
    #  "permission"=>{"organisation_id"=>"17", "profile_id"=>"2"}, i
    #  "commit"=>"Create Access permission", "action"=>"create", "controller"=>"permissions", "locale"=>"en", "user_id"=>"2"}

    params[:permission][:user_id] = params[:user_id]
    @permission = Permission.new(params[:permission])
    raise "Cannot create permissons for unrelated locations" unless current_user.current_organisation.accessible_locations.include? @permission.organisation
    respond_to do |format|
      if @permission.save
        format.html { redirect_to(permissions_path, :notice => 'Permission was successfully created.') }
        format.xml  { render :xml => @permission, :status => :created, :location => @permission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /permissions/1
  # PUT /permissions/1.xml
  def update
    params["user_id"] =  params["permission"]["user_id"]
    #Rails.logger.info "&&&&&&&&&&&&"+ params.to_s
    #&&&&&&&&&&&&{"utf8"=>"✓", "_method"=>"put", "authenticity_token"=>"tzUAldwoIRBsSDKRiWrVygP2pTr6MUE82qnFCKLc21M=", "permission"=>{"user_id"=>"4", "organisation_id"=>"13", "profile_id"=>"2"}, "commit"=>"Update Access permission", "action"=>"update", "controller"=>"permissions", "locale"=>"en", "user_id"=>"4", "id"=>"26"}

    @permission = Permission.find(params[:id])

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.html { redirect_to(permissions_path(params["user_id"]), :notice => 'Permission was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.xml
  def destroy
    @permission = Permission.find(params[:id])
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to(permissions_path) }
      format.xml  { head :ok }
    end
  end
end
