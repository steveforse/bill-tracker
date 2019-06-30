require 'rails_helper'

RSpec.describe "payees/edit", type: :view do
  before(:each) do
    #@payee = assign(:payee, Payee.create!())
    @payee = create(:payee)
  end

  it "renders the edit payee form" do
    render

    assert_select "form[action=?][method=?]", payee_path(@payee), "post" do
    end
  end
end
