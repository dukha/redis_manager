class Translation < ActiveRecord::Base
  # needed for self.search
  extend SearchModel
  
  validates :dot_key_code, :uniqueness=>true#, :presence=>true 
  #validates :translation, :presence=>true
  
  # for developers  we want to be able to process up to 3 translations from 1 form: thus extra virtual attributes
  # to be saved as separate translations
  attr_accessor  :dot_key_code0, :translation0, :translation_message0, :dot_key_code1, :translation1, :translation_message1, :dot_key_code2, :translation2,  :translation_message2#, :developer_params
  scope :all, order('dot_key_code asc')
  
  def english_translation 
    new_locale = replace_locale_in_dot_key_code('en')
    en = Translation.where{dot_key_code == my{new_locale}}
    puts  en.all.to_s
    return en
  end
  def translation_locale 
    dot_key_code[0..(dot_key_code.index('.')-1)]
  end
  def remove_locale_from_dot_key_code
    dot_key_code[(dot_key_code.index('.')+1)..(dot_key_code.size() -1)]
  end
  def replace_locale_in_dot_key_code new_locale
    new_locale + '.' +remove_locale_from_dot_key_code
  end
  def self.save_multiple translation_array
    #debugger
    transaction do 
      translation_array.each do |t|
        t.save!
      end
    end
  end
  
  def self.searchable_attr
    %w(iso_code dot_key_code translation)
  end
  
  def self.sortable_attr
    %w(dot_key_code translation)
  end
  def self.search_dot_key_code_operators
     %w(ends_with matches does_not_match equals )
  end
  def self.search_translation_operators
    %w(begins_with ends_with matches  does_not_match equals is_null is_not_null)
  end
  # need a model as param
  def self.search(current_user, criteria={}, operators={}, sorting={})
    
    translations= all
    puts translations.class.name
    #debugger
    #@val=nil
    if ! criteria['iso_code'].nil? then
      #operators["dot_key_code"] = 'begins_with'
      #criteria["dot_key_code"] = criteria['iso_code'] + '.'
      # We have to do it like this as language is a separate selection criterion which uses dot_key_code
      # This ways we can select again on dot_key_code to narrow the selection further 
      
      translations= translations.where{ dot_key_code  =~ criteria['iso_code'] + '.%' }
      operators.delete('iso_code')
      criteria.delete('iso_code')
    end
    # We need to do this for dot key code otherwise it will split on '.'
    # in and not_in are a bit shakey. They come to the controller as lists as a string. So we try to split
    # using space, or comma
    if criteria['dot_key_code'] then
      if operators['dot_key_code'] == 'in' || operators['dot_key_code'] == 'not_in' then
        array = criteria['dot_key_code'].split(" ")
        if array.size == 1 then
          array = criteria['dot_key_code'].split(", ")
          if array.size == 1 then
            array = criteria['dot_key_code'].split(",")
            criteria['dot_key_code']= array
          end 
        else
          criteria['dot_key_code']= array  
        end
      end
    end
    debugger
    
    translations = build_lazy_loader(translations, criteria, operators)
    #puts translations.class.name
    return translations
  end
end

# == Schema Information
#
# Table name: translations
#
#  id                 :integer         not null, primary key
#  dot_key_code       :string(255)     not null
#  translation        :text            not null
#  calmapp_version_id :integer         not null
#  origin             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

