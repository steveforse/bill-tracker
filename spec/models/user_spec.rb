# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  it { should validate_presence_of :email  }
  it { should validate_presence_of :password }

  it 'authenticates password' do
    password = 'password123'
    user.password = password
    user.password_confirmation = password
    expect(user.valid_password?('password123')).to be_truthy
  end

  it 'rejects bad password' do
    password = 'password123'
    user.password = password
    user.password_confirmation = password
    expect(user.valid_password?('invalid_password')).to be false
  end

  it 'rejects non-matching password' do
    user.password = 'password_good'
    user.password_confirmation = 'password_bad'
    expect(user.valid?).to be false
  end
end
