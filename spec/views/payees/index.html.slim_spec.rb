# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'payees/index', type: :view do
  before do
    create(:payee, name: 'Alpha',
                   nickname: 'alphie',
                   website: 'https://alpha',
                   phone_number: '555-555-5555')

    create(:payee, name: 'Beta',
                   nickname: 'bittie',
                   website: 'https://beta',
                   phone_number: '123-123-1234')

    assign(:payees, Payee.all.order(:name).decorate)
    render
  end

  let(:payees) { Payee.all.order(:name) }

  it 'renders card header' do
    assert_select '.card .card-header' do
      assert_select '.h4', text: 'Payees'
      assert_select 'a.btn.btn-success[href=\'/payees/new\']', text: 'New Payee'
    end
  end

  it 'renders table header' do
    assert_select 'table.table thead' do
      assert_select 'th', count: 5
      assert_select 'th a.rezort', count: 4
      assert_select 'th a.rezort', text: 'Name'
      assert_select 'th a.rezort', text: 'Nickname'
      assert_select 'th a.rezort', text: 'Website'
      assert_select 'th a.rezort', text: 'Phone Number'
      assert_select 'th', text: 'Actions'
    end
  end

  it 'renders decorated records' do
    assert_select '.card-body table.table tbody' do
      assert_select 'tr', count: 2
      assert_select 'tr:first' do
        assert_select 'td', count: 5
        assert_select 'td', text: payees[0].name, count: 1
        assert_select 'td', text: payees[0].nickname, count: 1
        assert_select "td a[href='#{payees[0].website}']", text: payees[0].website, count: 1
        assert_select "td a[href='tel:#{payees[0].phone_number}']",
                      text: payees[0].phone_number, count: 1
        assert_select "td a.btn.btn-primary[href='/payees/#{payees[0].id}']", text: 'Details'
        assert_select "td a.btn.btn-danger[data-method=delete][href='/payees/#{payees[0].id}']",
                      text: 'Delete'
      end

      assert_select 'tr:last' do
        assert_select 'td', count: 5
        assert_select 'td', text: payees[1].name, count: 1
        assert_select 'td', text: payees[1].nickname, count: 1
        assert_select "td a[href='#{payees[1].website}']", text: payees[1].website, count: 1
        assert_select "td a[href='tel:#{payees[1].phone_number}']",
                      text: payees[1].phone_number, count: 1
        assert_select "td a.btn.btn-primary[href='/payees/#{payees[1].id}']", text: 'Details'
        assert_select "td a.btn.btn-danger[data-method=delete][href='/payees/#{payees[1].id}']",
                      text: 'Delete'
      end
    end
  end
end
