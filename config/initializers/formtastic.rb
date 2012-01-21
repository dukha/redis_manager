Formtastic::SemanticFormBuilder.inline_errors = :list # :sentence, :list, :first
# apparently inline_order dropped in formtastic 2 
#Formtastic::SemanticFormBuilder.inline_order = [ :input,:hints, :errors]
# line below enables default formatastic i18n i.e. using formtastic.labels. (not activerecord.attributes. )
Formtastic::SemanticFormBuilder.i18n_lookups_by_default = true


