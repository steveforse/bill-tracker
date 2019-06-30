require 'rails_helper'

RSpec.describe "payees/show", type: :view do
  before(:each) do
    @payee = assign(:payee, create(:payee))
    @payee.schedules = [create(:schedule, payee: @payee),
                        create(:schedule, payee: @payee)]
    assign(:schedules, @payee.schedules)
  end

  it "renders attributes in <p>" do
    render
  end
end
