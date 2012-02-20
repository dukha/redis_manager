class Permission < ActiveRecord::Base

  # these relationships model that the user is allowed to access this organisation
  belongs_to :user
  belongs_to :organisation
  belongs_to :profile

  # on production got error:
  # ActionView::Template::Error (undefined method `profile_id' for #<Permission:0xacf786c>):
  attr_accessible :user_id, :organisation_id, :profile_id, :user, :organisation, :profile

 scope :for_user, lambda { |user| where( 'user_id = ?', user.id) }
 scope :under_location, lambda { |org| where( 'organisation_id IN (?)', org.accessible_organisations.collect{|each| each.id} ) }

  # set self as the current permission in the given user
  def be_current_permission_for (aUser)
    Rails.logger.info "*** In Permission be_current_permission_for before: #{aUser.current_permission_id}"

    aUser.current_permission_id = self.id

    Rails.logger.info "*** current after be_current_permission_for after : #{aUser.current_permission_id}"
  end

  def to_s
    organisation.name + ", profile: " + profile.name + ", user: " + user.username
  end

  def display
    organisation.name + ", " + profile.name
  end
end

# == Schema Information
#
# Table name: permissions
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  organisation_id :integer         not null
#  created_at      :datetime
#  updated_at      :datetime
#  profile_id      :integer         not null
#

