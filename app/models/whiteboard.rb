# == Schema Information
# Schema version: 20110318050652
#
# Table name: whiteboards
#
#  id                 :integer         not null, primary key
#  info               :text            not null
#  whiteboard_type_id :integer         not null
#  created_at         :datetime
#  updated_at         :datetime
#

class Whiteboard < ActiveRecord::Base
  include Validations
  attr_accessible  :info, :whiteboard_type_id
  belongs_to :whiteboard_type #, :class_name=>"WhiteboardType", :foreign_key=>"whiteboard_type_id"

  validates :whiteboard_type, :existence => true
  validates :whiteboard_type_id, :presence =>true
  validates :whiteboard_type_id, :uniqueness => true
  validates :info, :presence => true
  cattr_reader :per_page
  @@per_page = 10

end
