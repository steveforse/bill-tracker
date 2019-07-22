# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'flash_class' do
    let(:flash_class_map) do
      {
        'notice' => 'alert alert-info',
        'success' => 'alert alert-success',
        'error' => 'alert alert-danger',
        'alert' => 'alert alert-warning'
      }
    end

    it 'has correct bootstrap style for notice' do
      flash_class_map.each do |level, classes|
        expect(helper.flash_class(level)).to include(classes)
      end
    end
  end

  describe 'icon helper' do
    it 'creates a span with the correct icon classes' do
      expect(helper.icon('sample')).to have_selector('span.fas.fa-sample', exact_text: '')
    end
  end

  describe 'button_cancel' do
    let(:url) { 'https://some_url' }

    it 'creates a link with default text of "Cancel"' do
      expect(helper.button_cancel(url)).to have_selector(
        "a.btn.btn-outline-secondary[href='#{url}']", exact_text: 'Cancel'
      )
    end

    it 'creates a link with given link test' do
      expect(helper.button_cancel(url, 'Example')).to have_selector(
        "a.btn.btn-outline-secondary[href='#{url}']", exact_text: 'Example'
      )
    end
  end

  describe 'button_reset' do
    it 'creates a styled form reset button with default text "Reset Form"' do
      expect(helper.button_reset).to have_selector(
        "button.btn.btn-outline-secondary[type='reset']", exact_text: 'Reset Form'
      )
    end

    it 'creates a styled form reset button with given text' do
      expect(helper.button_reset('Example')).to have_selector(
        "button.btn.btn-outline-secondary[type='reset']", exact_text: 'Example'
      )
    end
  end

  describe 'generic button helpers' do
    let(:button_text) { 'example' }
    let(:url) { 'https://example' }
    let(:button_types) { %w[primary secondary danger success warning info default] }

    %w[primary secondary danger success warning info default].each do |button_type|
      it 'renders a styled link with given url and options' do
        test_case = helper.send(('button_' + button_type), button_text, url, 'icon', class: 'extra')
        expect(test_case).to have_selector("a.btn.btn-#{button_type}.extra[href='#{url}']")
      end

      it 'renders a button with icon classes' do
        test_case = helper.send(('button_' + button_type), button_text, url, 'icon', class: 'extra')
        expect(test_case).to have_selector('span.fas.fa-icon')
      end
    end
  end

  describe 'base button helper' do
    let(:button_text) { 'example' }
    let(:url) { 'https://example' }
    let(:button_types) { %w[primary secondary danger success warning info default] }

    it 'renders a styled link if given a bootstrap contextual class' do
      %w[primary secondary danger success warning info default].each do |button_type|
        test_case = helper.button_link_to(button_text, url, 'icon', button_type)
        expect(test_case).to have_selector("a.btn.btn-#{button_type}")
      end
    end

    it 'raises ArgumentError with invalid style' do
      expect { helper.button_link_to(button_text, url, 'icon', 'invalid') }.to \
        raise_error(ArgumentError, match("Bootstrap's contextual classes"))
    end

    it 'defaults to default style if not specified' do
      test_case = helper.button_link_to(button_text, url)
      expect(test_case).to have_selector('a.btn.btn-default')
    end

    it 'accepts html_options' do
      test_case = helper.button_link_to(button_text, url, nil, 'default', class: 'testing')
      expect(test_case).to have_selector('a.btn.btn-default.testing')
    end

    it 'renders link with given text and url' do
      test_case = helper.button_link_to(button_text, url)
      expect(test_case).to have_selector("a.btn.btn-default[href='#{url}']",
                                         exact_text: button_text)
    end

    it 'renders link with given icon name' do
      test_case = helper.button_link_to(button_text, url, 'icon')
      expect(test_case).to have_selector('span.fas.fa-icon')
    end
  end
end
