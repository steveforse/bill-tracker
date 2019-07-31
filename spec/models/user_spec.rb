# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  it 'authenticates password' do
    password = 'password123'
    user.password = password
    user.password_confirmation = password
    expect(user).to be_valid_password('password123')
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
