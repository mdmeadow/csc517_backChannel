require 'spec_helper'

describe "Users" do
  it "display home screen on startup" do
    get "/home/index"
    response.should render_template('index')

  end

  #describe "GET /users" do
  #  it "works! (now write some real specs)" do
  #    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #    get users_path
  #    response.status.should be(200)
  #  end
  #end
end
