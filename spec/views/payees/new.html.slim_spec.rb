require 'rails_helper'

RSpec.describe "payees/new", type: :view do
  before(:each) do
    assign(:payee, Payee.new())
  end

  it "renders new payee form" do
    render

    assert_select "form[action=?][method=?]", payees_path, "post" do
    end
  end
end
