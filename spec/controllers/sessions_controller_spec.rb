require 'spec_helper'

describe SessionsController do
  let(:user) { mock_model(User, id: 1) }

  describe "GET create" do
    before(:each) do
      User.stub(:find_or_create_from_auth).and_return(user)
      request.env["omniauth.auth"] = OmniAuth::AuthHash.new({ :provider => 'twitter', :uid => '123545' })
    end
    it "assigns user_id to the session" do
      get :create, provider: "twitter"
      session[:user_id].should == 1
    end

    it "redirects to the root_url" do
      get :create, provider: "twitter"
      response.should redirect_to('/')
    end
  end

  describe "GET signout" do
    it "removes user_id from the session" do
      get :destroy
      session[:user_id].should be_nil
    end

    it "redirects to the root_url" do
      get :destroy
      response.should redirect_to('/')
    end
  end
end
