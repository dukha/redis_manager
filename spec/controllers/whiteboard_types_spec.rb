#messages/06/spec/controllers/messages_controller_spec.rb
require 'spec_helper'
require 'ruby-debug'
describe WhiteboardTypesController do
  describe "POST create" do
    let(:whiteboard_type) { mock_model(WhiteboardType).as_null_object }
    before do
      WhiteboardType.stub(:new).and_return(whiteboard_type)
    end
    it "creates a new whiteboard type" do
      #pending("drive out redirect")
      WhiteboardType.should_receive(:new).with("name_english" => "test_type", "translation_code" => "test_type_code")
      post :create, :whiteboard_type => { "name_english" => "test_type", "translation_code" => "test_type_code" }
      #, :format=>"html"
      puts "WBT0"
    end
    it "saves the whiteboard type" do
      #debugger
      #whiteboard_type = mock_model(WhiteboardType)
      puts "WBT1"
      #WhiteboardType.stub(:new).and_return(whiteboard_type)
      puts "WBT2"
      whiteboard_type.should_receive(:save)
      #debugger
      #puts "WBT3"
      post :create
      puts "WBT4"
    end

    it "redirects to the whitebord_types index" do
      post :create
      response.should redirect_to(:action => "index")
    end
  end
end


