class DeveloperParam
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :key_helper, :model, :attribute

  #def key_helper
    #@key_helper
  #end

end
