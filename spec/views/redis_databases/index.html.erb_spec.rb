require 'spec_helper'

describe "redis_databases/index.html.erb" do
  before(:each) do
    assign(:redis_databases, [
      stub_model(RedisDatabase,
        :redis_index => 1,
        :name => "Name",
        :server => false
      ),
      stub_model(RedisDatabase,
        :redis_index => 1,
        :name => "Name",
        :server => false
      )
    ])
  end

  it "renders a list of redis_databases" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
