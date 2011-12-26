class Translation < ActiveRecord::Base
  validates :dot_key_code, :uniqueness=>true, :presence=>true
  attr_accessor  :dot_key_code0, :translation0, :translation_message0, :dot_key_code1, :translation1, :translation_message1, :dot_key_code2, :translation2,  :translation_message2, :developer_params
end
