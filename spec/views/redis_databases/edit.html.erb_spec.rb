require 'spec_helper'

describe "translations/edit.html.erb" do
  before(:each) do
    @translation = assign(:translation, stub_model(Translation,
      :new_record? => false,
      :redis_index => 1,
      :name => "MyString",
      :server => false
    ))
  end

  it "renders the edit translation form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => translation_path(@translation), :method => "post" do
      assert_select "input#translation_redis_index", :name => "translation[redis_index]"
      assert_select "input#translation_name", :name => "translation[name]"
      assert_select "input#translation_server", :name => "translation[server]"
    end
  end
end
