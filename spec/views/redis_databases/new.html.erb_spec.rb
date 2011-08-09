require 'spec_helper'

describe "redis_databases/new.html.erb" do
  before(:each) do
    assign(:redis_database, stub_model(RedisDatabase,
      :redis_index => 1,
      :name => "MyString",
      :server => false
    ).as_new_record)
  end

  it "renders new redis_database form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => redis_databases_path, :method => "post" do
      assert_select "input#redis_database_redis_index", :name => "redis_database[redis_index]"
      assert_select "input#redis_database_name", :name => "redis_database[name]"
      assert_select "input#redis_database_server", :name => "redis_database[server]"
    end
  end
end
