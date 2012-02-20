class SubOrganisationValidator < ActiveModel::Validator
  def validate(aLocation)
    aLocation.errors[:parent] << "Sub organisations are not permitted" unless aLocation.allow_organisation_ancestor?
  end

end
