require 'spec_helper'

describe "translation_uploads/index.html.erb" do
  before(:each) do
    assign(:translation_uploads, [
      stub_model(TranslationUpload,
        :translation_file_name => "Translation File Name",
        :translation_file_content_type => "Translation File Content Type",
        :translation_file_size => 1
      ),
      stub_model(TranslationUpload,
        :translation_file_name => "Translation File Name",
        :translation_file_content_type => "Translation File Content Type",
        :translation_file_size => 1
      )
    ])
  end

  it "renders a list of translation_uploads" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Translation File Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Translation File Content Type".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
