require 'spec_helper'

describe "redis_databases/edit.html.erb" do
  before(:each) do
    @redis_database = assign(:redis_database, stub_model(RedisDatabase,
      :new_record? => false,
      :redis_index => 1,
      :name => "MyString",
      :server => false
    ))
  end

  it "renders the edit redis_database form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => redis_database_path(@redis_database), :method => "post" do
      assert_select "input#redis_database_redis_index", :name => "redis_database[redis_index]"
      assert_select "input#redis_database_name", :name => "redis_database[name]"
      assert_select "input#redis_database_server", :name => "redis_database[server]"
    end
  end
end
