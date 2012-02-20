=begin
 Represents an area
 @deprecated
=end
class Area <  Location
end

# == Schema Information
#
# Table name: locations
#
#  id               :integer         not null, primary key
#  name             :string(255)     not null
#  type             :string(255)     not null
#  parent_id        :integer
#  translation_code :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  marked_deleted   :boolean         default(FALSE)
#

