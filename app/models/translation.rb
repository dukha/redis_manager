class Translation < ActiveRecord::Base
  validates :dot_key_code, :uniqueness=>true, :presence=>true 
  validates :translation, :presence=>true
  
  # for developers  we want to be able to process up to 3 translations from 1 form: thus extra virtual attributes
  # to be saved as separate translations
  attr_accessor  :dot_key_code0, :translation0, :translation_message0, :dot_key_code1, :translation1, :translation_message1, :dot_key_code2, :translation2,  :translation_message2#, :developer_params
  
  def self.save_multiple translation_array
    debugger
    transaction do 
      translation_array.each do |t|
        t.save!
      end
    end
  end
  
end
