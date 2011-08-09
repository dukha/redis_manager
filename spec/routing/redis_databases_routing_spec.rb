require "spec_helper"

describe RedisDatabasesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/redis_databases" }.should route_to(:controller => "redis_databases", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/redis_databases/new" }.should route_to(:controller => "redis_databases", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/redis_databases/1" }.should route_to(:controller => "redis_databases", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/redis_databases/1/edit" }.should route_to(:controller => "redis_databases", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/redis_databases" }.should route_to(:controller => "redis_databases", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/redis_databases/1" }.should route_to(:controller => "redis_databases", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/redis_databases/1" }.should route_to(:controller => "redis_databases", :action => "destroy", :id => "1")
    end

  end
end
