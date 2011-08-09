require 'spec_helper'

describe "translation_uploads/edit.html.erb" do
  before(:each) do
    @translation_upload = assign(:translation_upload, stub_model(TranslationUpload,
      :new_record? => false,
      :translation_file_name => "MyString",
      :translation_file_content_type => "MyString",
      :translation_file_size => 1
    ))
  end

  it "renders the edit translation_upload form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => translation_upload_path(@translation_upload), :method => "post" do
      assert_select "input#translation_upload_translation_file_name", :name => "translation_upload[translation_file_name]"
      assert_select "input#translation_upload_translation_file_content_type", :name => "translation_upload[translation_file_content_type]"
      assert_select "input#translation_upload_translation_file_size", :name => "translation_upload[translation_file_size]"
    end
  end
end
