class WhiteboardType < ActiveRecord::Base
  validates :name_english, :presence => true, :uniqueness=>true
  validates :translation_code, :presence => true, :uniqueness=>true

  attr_accessible :name_english, :translation_code
  
  cattr_reader :per_page
  @@per_page = 10

end

# == Schema Information
#
# Table name: whiteboard_types
#
#  id               :integer         not null, primary key
#  name_english     :string(255)
#  translation_code :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

