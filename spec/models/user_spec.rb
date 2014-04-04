require 'spec_helper'

describe User do
  let(:auth) { {"provider" => "twitter", "uid" => "123456", "info" => { "name" => "Tweety Bird"}} }

  describe ".find_from_auth" do
    it "should find the user from the auth hash values" do
      User.should_receive(:where).with({ "provider" => "twitter", "uid" => "123456" })
      User.find_from_auth(auth)
    end
  end

  describe ".find_or_create_from_auth" do
    context "when a user exists" do
      let!(:user) { User.create!({ "provider" => "twitter", "uid" => "123456", "name" => "Tweety Bird" }) }

      it "should find the user" do
        User.should_not_receive(:create!)
        User.find_or_create_from_auth(auth).name.should == "Tweety Bird"
      end
    end

    context "when a user does not exists" do
      it "should create the user from the auth hash values" do
        User.should_receive(:create!).with({ provider: "twitter", uid: "123456", name: "Tweety Bird" })
        User.find_or_create_from_auth(auth)
      end
    end
  end
end
