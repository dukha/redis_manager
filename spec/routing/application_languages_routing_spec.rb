require "spec_helper"

describe ApplicationLanguagesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/application_languages" }.should route_to(:controller => "application_languages", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/application_languages/new" }.should route_to(:controller => "application_languages", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/application_languages/1" }.should route_to(:controller => "application_languages", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/application_languages/1/edit" }.should route_to(:controller => "application_languages", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/application_languages" }.should route_to(:controller => "application_languages", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/application_languages/1" }.should route_to(:controller => "application_languages", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/application_languages/1" }.should route_to(:controller => "application_languages", :action => "destroy", :id => "1")
    end

  end
end
