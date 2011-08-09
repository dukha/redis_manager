require 'spec_helper'

describe "redis_databases/show.html.erb" do
  before(:each) do
    @redis_database = assign(:redis_database, stub_model(RedisDatabase,
      :redis_index => 1,
      :name => "Name",
      :server => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
