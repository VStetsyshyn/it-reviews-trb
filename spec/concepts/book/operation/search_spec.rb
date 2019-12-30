# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book::Operation::Search do
  include Trailblazer::Test::Deprecation::Operation::Helper

  subject(:result) { described_class.call(params: params) }

  context 'with valid data' do
    let(:params) do
      {
        author: 'Sendi Metz',
        title: 'great book',
        category: 'ruby'
      }
    end

    before do
      factory(Book::Operation::Create, params: params)
    end

    it 'is success' do
      expect(result).to be_success
    end

    it 'has the author' do
      expect(result['model'].first.author).to eq(params[:author])
    end
  end

  context 'when specific book is missing' do
    let(:error) { 'There aren\'t such books' }
    let(:params) do
      {
        author: 'Sendi Metz'
      }
    end

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      expect(result[:errors]).to include(error)
    end
  end

  context 'when user don\'t fill searching fields' do
    let(:error) { 'Please fill searching fields' }
    let(:result) { described_class.call(params: {}) }

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      expect(result[:errors]).to include(error)
    end
  end
end
