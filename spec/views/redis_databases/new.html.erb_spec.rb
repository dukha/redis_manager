require 'spec_helper'

describe "translations/new.html.erb" do
  before(:each) do
    assign(:translation, stub_model(Translation,
      :redis_index => 1,
      :name => "MyString",
      :server => false
    ).as_new_record)
  end

  it "renders new translation form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => translations_path, :method => "post" do
      assert_select "input#translation_redis_index", :name => "translation[redis_index]"
      assert_select "input#translation_name", :name => "translation[name]"
      assert_select "input#translation_server", :name => "translation[server]"
    end
  end
end
