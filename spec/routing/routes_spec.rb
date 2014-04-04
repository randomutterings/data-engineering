require "spec_helper"

describe "Routing" do
  it { should route(:get, '/imports/new').to('imports#new') }
  it { should route(:post, '/imports').to('imports#create') }
  it { should route(:get, '/imports/1').to('imports#show', id: '1') }
  it { should route(:get, 'auth/:provider/callback').to('sessions#create', :provider => ":provider") }
  it { should route(:get, 'signout').to('sessions#destroy') }

  it "does not route to #index" do
    get("/imports").should_not be_routable
  end

  it "does not route to #edit" do
    get("/imports/1/edit").should_not be_routable
  end

  it "does not route to #update" do
    put("/imports/1").should_not be_routable
  end

  it "does not route to #destroy" do
    delete("/imports/1").should_not be_routable
  end

end
