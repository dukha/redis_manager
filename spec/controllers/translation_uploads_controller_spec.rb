require 'spec_helper'

describe TranslationUploadsController do

  def mock_translation_upload(stubs={})
    @mock_translation_upload ||= mock_model(TranslationUpload, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all translation_uploads as @translation_uploads" do
      TranslationUpload.stub(:all) { [mock_translation_upload] }
      get :index
      assigns(:translation_uploads).should eq([mock_translation_upload])
    end
  end

  describe "GET show" do
    it "assigns the requested translation_upload as @translation_upload" do
      TranslationUpload.stub(:find).with("37") { mock_translation_upload }
      get :show, :id => "37"
      assigns(:translation_upload).should be(mock_translation_upload)
    end
  end

  describe "GET new" do
    it "assigns a new translation_upload as @translation_upload" do
      TranslationUpload.stub(:new) { mock_translation_upload }
      get :new
      assigns(:translation_upload).should be(mock_translation_upload)
    end
  end

  describe "GET edit" do
    it "assigns the requested translation_upload as @translation_upload" do
      TranslationUpload.stub(:find).with("37") { mock_translation_upload }
      get :edit, :id => "37"
      assigns(:translation_upload).should be(mock_translation_upload)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created translation_upload as @translation_upload" do
        TranslationUpload.stub(:new).with({'these' => 'params'}) { mock_translation_upload(:save => true) }
        post :create, :translation_upload => {'these' => 'params'}
        assigns(:translation_upload).should be(mock_translation_upload)
      end

      it "redirects to the created translation_upload" do
        TranslationUpload.stub(:new) { mock_translation_upload(:save => true) }
        post :create, :translation_upload => {}
        response.should redirect_to(translation_upload_url(mock_translation_upload))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved translation_upload as @translation_upload" do
        TranslationUpload.stub(:new).with({'these' => 'params'}) { mock_translation_upload(:save => false) }
        post :create, :translation_upload => {'these' => 'params'}
        assigns(:translation_upload).should be(mock_translation_upload)
      end

      it "re-renders the 'new' template" do
        TranslationUpload.stub(:new) { mock_translation_upload(:save => false) }
        post :create, :translation_upload => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested translation_upload" do
        TranslationUpload.should_receive(:find).with("37") { mock_translation_upload }
        mock_translation_upload.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :translation_upload => {'these' => 'params'}
      end

      it "assigns the requested translation_upload as @translation_upload" do
        TranslationUpload.stub(:find) { mock_translation_upload(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:translation_upload).should be(mock_translation_upload)
      end

      it "redirects to the translation_upload" do
        TranslationUpload.stub(:find) { mock_translation_upload(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(translation_upload_url(mock_translation_upload))
      end
    end

    describe "with invalid params" do
      it "assigns the translation_upload as @translation_upload" do
        TranslationUpload.stub(:find) { mock_translation_upload(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:translation_upload).should be(mock_translation_upload)
      end

      it "re-renders the 'edit' template" do
        TranslationUpload.stub(:find) { mock_translation_upload(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested translation_upload" do
      TranslationUpload.should_receive(:find).with("37") { mock_translation_upload }
      mock_translation_upload.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the translation_uploads list" do
      TranslationUpload.stub(:find) { mock_translation_upload }
      delete :destroy, :id => "1"
      response.should redirect_to(translation_uploads_url)
    end
  end

end
