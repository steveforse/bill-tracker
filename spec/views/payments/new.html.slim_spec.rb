require 'rails_helper'

RSpec.describe "payments/new", type: :view do
  before(:each) do
    assign(:payment, Payment.new(
      :schedule_id => 1,
      :amount => "",
      :comment => "MyText"
    ))
  end

  it "renders new payment form" do
    render

    assert_select "form[action=?][method=?]", payments_path, "post" do

      assert_select "input[name=?]", "payment[schedule_id]"

      assert_select "input[name=?]", "payment[amount]"

      assert_select "textarea[name=?]", "payment[comment]"
    end
  end
end
