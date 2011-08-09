require "spec_helper"

describe TranslationUploadsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/translation_uploads" }.should route_to(:controller => "translation_uploads", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/translation_uploads/new" }.should route_to(:controller => "translation_uploads", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/translation_uploads/1" }.should route_to(:controller => "translation_uploads", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/translation_uploads/1/edit" }.should route_to(:controller => "translation_uploads", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/translation_uploads" }.should route_to(:controller => "translation_uploads", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/translation_uploads/1" }.should route_to(:controller => "translation_uploads", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/translation_uploads/1" }.should route_to(:controller => "translation_uploads", :action => "destroy", :id => "1")
    end

  end
end
