require 'spec_helper'

describe ImportsController do
  let(:good_tsv) { fixture_file_upload('files/good_input.tsv', 'text/tab-separated-values') }

  describe "GET new" do
    it "assigns a new import as @import" do
      get :new, {}
      assigns(:import).should be_a_new(Import)
    end

    it "renders the 'new' template" do
      get :new, {}
      response.should render_template("new")
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "redirects to the import show page" do
        Import.any_instance.stub(:save).and_return(true)
        Import.any_instance.stub(:process).and_return(true)
        post :create, {import: { tsv: good_tsv }}
        response.should redirect_to(assigns(:import))
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        Import.any_instance.stub(:save).and_return(false)
        post :create, {import: { tsv: nil }}
        response.should render_template("new")
      end
    end
  end

  describe 'GET #show' do
    let(:import) { Import.create(tsv: good_tsv) }
    before { get :show, {id: import.id} }

    it { should render_template('show') }

    it "assigns import as @import" do
      assigns(:import).should be_a(Import)
    end
  end

end
