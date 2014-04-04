require 'spec_helper'

describe "Imports" do
  describe "GET /imports" do
    it "imports data" do
      get "/imports/new"
      expect(response).to render_template(:new)
      expect(response.body).to include("Sign in with OAuth Developer")
      expect(response.body).not_to include("New import")

      post "/auth/developer/callback", :name => "Jedediah Ignatius Knight", :email => "jediknight@gmail.com", :provider => "developer"
      expect(response).to redirect_to("/")
      follow_redirect!
      expect(response).to render_template(:new)
      expect(response.body).to include("Signed in as Jedediah Ignatius Knight!")
      expect(response.body).to include("New import")

      post "/imports", :import => {
                       :tsv => fixture_file_upload("#{Rails.root}/spec/fixtures/files/good_input.tsv", 'text/tab-separated-values') }

      expect(response).to redirect_to(assigns(:import))
      follow_redirect!

      expect(response).to render_template(:new)
      expect(response.body).to include("Import processed successfully.")
      expect(response.body).to include("Total gross revenue of $95.00")
    end

    it "fails gracefully" do
      post "/auth/developer/callback", :name => "Jedediah Ignatius Knight", :email => "jediknight@gmail.com", :provider => "developer"
      follow_redirect!

      post "/imports", :import => {
                       :tsv => fixture_file_upload("#{Rails.root}/spec/fixtures/files/bad_input.tsv", 'text/tab-separated-values') }

      expect(response).to render_template(:new)
      expect(response.body).to include("The import failed, please check your file and try again.")
    end
  end
end
