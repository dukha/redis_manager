require 'spec_helper'

describe "translation_uploads/show.html.erb" do
  before(:each) do
    @translation_upload = assign(:translation_upload, stub_model(TranslationUpload,
      :translation_file_name => "Translation File Name",
      :translation_file_content_type => "Translation File Content Type",
      :translation_file_size => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Translation File Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Translation File Content Type/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
