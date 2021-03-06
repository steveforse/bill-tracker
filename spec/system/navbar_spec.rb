# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Navbar', type: :system do
  before { sign_in create(:user) }

  describe 'navbar' do
    it 'has the logo and icon' do
      visit '/'
      assert_selector 'nav.navbar' do
        assert_selector 'a.navbar-brand', text: 'Bill Tracker' do
          assert_selector 'img[src*="logo"]'
        end
      end
    end

    it 'has the correct navigation links' do
      visit '/'
      assert_selector 'ul.navbar-nav' do
        assert_selector 'li.nav-item' do
          assert_selector 'a.nav-link[href="/calendar"]', text: 'Calendar'
          assert_selector 'a.nav-link[href="/payments"]', text: 'Payments'
          assert_selector 'a.nav-link[href="/payees"]', text: 'Setup'
        end
      end
    end

    it 'has the logout button' do
      visit '/'
      assert_selector 'nav.navbar' do
        assert_selector 'a.btn.btn-danger[href="/users/sign_out"]', text: 'Logout'
      end
    end

    it 'does not display when signed out' do
      sign_out create(:user)
      assert_selector 'nav.navbar', count: 0
    end
  end
end
