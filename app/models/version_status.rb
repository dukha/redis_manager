# == Schema Information
# Schema version: 20110520013314
#
# Table name: version_statuses
#
#  id         :integer         not null, primary key
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class VersionStatus < ActiveRecord::Base
  validates :status, :presence =>true
  validates_uniqueness_of :status

end
