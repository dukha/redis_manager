require 'spec_helper'

describe RedisDatabasesController do

  def mock_redis_database(stubs={})
    @mock_redis_database ||= mock_model(RedisDatabase, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all redis_databases as @redis_databases" do
      RedisDatabase.stub(:all) { [mock_redis_database] }
      get :index
      assigns(:redis_databases).should eq([mock_redis_database])
    end
  end

  describe "GET show" do
    it "assigns the requested redis_database as @redis_database" do
      RedisDatabase.stub(:find).with("37") { mock_redis_database }
      get :show, :id => "37"
      assigns(:redis_database).should be(mock_redis_database)
    end
  end

  describe "GET new" do
    it "assigns a new redis_database as @redis_database" do
      RedisDatabase.stub(:new) { mock_redis_database }
      get :new
      assigns(:redis_database).should be(mock_redis_database)
    end
  end

  describe "GET edit" do
    it "assigns the requested redis_database as @redis_database" do
      RedisDatabase.stub(:find).with("37") { mock_redis_database }
      get :edit, :id => "37"
      assigns(:redis_database).should be(mock_redis_database)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created redis_database as @redis_database" do
        RedisDatabase.stub(:new).with({'these' => 'params'}) { mock_redis_database(:save => true) }
        post :create, :redis_database => {'these' => 'params'}
        assigns(:redis_database).should be(mock_redis_database)
      end

      it "redirects to the created redis_database" do
        RedisDatabase.stub(:new) { mock_redis_database(:save => true) }
        post :create, :redis_database => {}
        response.should redirect_to(redis_database_url(mock_redis_database))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved redis_database as @redis_database" do
        RedisDatabase.stub(:new).with({'these' => 'params'}) { mock_redis_database(:save => false) }
        post :create, :redis_database => {'these' => 'params'}
        assigns(:redis_database).should be(mock_redis_database)
      end

      it "re-renders the 'new' template" do
        RedisDatabase.stub(:new) { mock_redis_database(:save => false) }
        post :create, :redis_database => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested redis_database" do
        RedisDatabase.should_receive(:find).with("37") { mock_redis_database }
        mock_redis_database.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :redis_database => {'these' => 'params'}
      end

      it "assigns the requested redis_database as @redis_database" do
        RedisDatabase.stub(:find) { mock_redis_database(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:redis_database).should be(mock_redis_database)
      end

      it "redirects to the redis_database" do
        RedisDatabase.stub(:find) { mock_redis_database(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(redis_database_url(mock_redis_database))
      end
    end

    describe "with invalid params" do
      it "assigns the redis_database as @redis_database" do
        RedisDatabase.stub(:find) { mock_redis_database(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:redis_database).should be(mock_redis_database)
      end

      it "re-renders the 'edit' template" do
        RedisDatabase.stub(:find) { mock_redis_database(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested redis_database" do
      RedisDatabase.should_receive(:find).with("37") { mock_redis_database }
      mock_redis_database.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the redis_databases list" do
      RedisDatabase.stub(:find) { mock_redis_database }
      delete :destroy, :id => "1"
      response.should redirect_to(redis_databases_url)
    end
  end

end
