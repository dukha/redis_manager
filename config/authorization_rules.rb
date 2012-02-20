authorization do

  # list all roles which are defiend here by:
  # Authorization::Engine.instance.roles

  def standard_roles aResourceSymbol
    r = (aResourceSymbol.to_s + "_read").to_sym
    role r do
      #has_permission_on aResourceSymbol, :to => :read
      has_permission_on aResourceSymbol, :to => [:index, :show]
      #has_permission_on :CalmSessions, :to => [:new, :create, :destroy]
    end
    r = (aResourceSymbol.to_s + "_write").to_sym
    role r do
      has_permission_on aResourceSymbol, :to => [:edit, :update]
      #has_permission_on :CalmSessions, :to => [:new, :create, :destroy]
    end
    r = (aResourceSymbol.to_s + "_create").to_sym
    role r do
      has_permission_on aResourceSymbol, :to => [:new, :create]
      #has_permission_on :CalmSessions, :to => [:new, :create, :destroy]
    end
    r = (aResourceSymbol.to_s + "_destroy").to_sym
    role r do
      has_permission_on aResourceSymbol, :to => [:destroy]
      #has_permission_on :CalmSessions, :to => [:new, :create, :destroy]
    end
  end

#privileges do
#  privilege :read do
#    includes :index, :show
#  end
#end
# might do same for :write, :add, :remove

  # users who have no permission are guest see user.rb >> role_symbols
  role :guest do
    has_permission_on :languages, :to => [:change_application_language, :index, :show]
    #has_permission_on :CalmSessions, :to => [:new, :create, :destroy]
  end
=begin
  role :location_tree do
    has_permission_on [:location_tree], :to => [:index, :show]
    #has_permission_on :CalmSessions, :to => [:new, :create, :destroy]
  end
=end
  standard_roles :users
  role :users_read do
    has_permission_on [:users], :to => [:select]
  end
  role :users_write do
    has_permission_on [:users], :to => [:unlock_user]
  end


  standard_roles :profiles

  standard_roles :languages
  standard_roles :calmapp_versions
  


  standard_roles :calmapps
  standard_roles :redis_databases
  standard_roles :redis_instances
  

  #standard_roles :locations
  standard_roles :release_statuses
  standard_roles :translations
  standard_roles :uploads
  standard_roles :user_works
 
  standard_roles :whiteboard_types
  standard_roles :whiteboards

#  create and send newsletters
#  role :newsletter_editor do
#    has_permission_on [], :to => []
#  end

#  create templates for letters and published schedules
#  role :templates_editor do
#    has_permission_on [], :to => []
#  end

end
