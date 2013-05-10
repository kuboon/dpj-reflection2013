require 'spec_helper'

describe "sessions/new.html.haml" do
  before do
    assign(:user, FactoryGirl.build(:user))
  end
  it do
    render
    assert_select "form[action=?][method=?]", session_path, "post" do
      assert_select "input#user_username[name=?]", "user[username]"
      assert_select "input#user_password[name=?]", "user[password]"
    end
  end
end
