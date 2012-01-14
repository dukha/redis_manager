# This class is used to provide ongoing upposrt for the developer by remember params between saves
class DeveloperParam
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  # key_helper is the index of the array of possible actions for the developer 
  attr_accessor :key_helper, :model, :attribute

  #def key_helper
    #@key_helper
  #end

end
