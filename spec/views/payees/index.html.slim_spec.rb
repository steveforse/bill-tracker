require 'rails_helper'

RSpec.describe "payees/index", type: :view do
  before(:each) do
    assign(:payees, [
      create(:payee),
      create(:payee)
    ])
  end

  it "renders a list of payees" do
    render
  end
end
