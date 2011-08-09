require 'spec_helper'

describe "translation_uploads/new.html.erb" do
  before(:each) do
    assign(:translation_upload, stub_model(TranslationUpload,
      :translation_file_name => "MyString",
      :translation_file_content_type => "MyString",
      :translation_file_size => 1
    ).as_new_record)
  end

  it "renders new translation_upload form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => translation_uploads_path, :method => "post" do
      assert_select "input#translation_upload_translation_file_name", :name => "translation_upload[translation_file_name]"
      assert_select "input#translation_upload_translation_file_content_type", :name => "translation_upload[translation_file_content_type]"
      assert_select "input#translation_upload_translation_file_size", :name => "translation_upload[translation_file_size]"
    end
  end
end
