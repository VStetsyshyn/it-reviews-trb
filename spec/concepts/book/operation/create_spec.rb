# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book::Operation::Create do
  include Trailblazer::Test::Deprecation::Operation::Helper

  subject(:result) { described_class.call(params: params) }

  context 'with valid data' do
    let(:params) do
      {
        author: 'Sendi Metz',
        title: 'POOD in Ruby'
      }
    end

    it 'is success' do
      expect(result).to be_success
    end

    it 'has the author' do
      expect(result['model'].author).to eq(params[:author])
    end
  end

  context 'when book already exists' do
    let(:error) { 'We have such book with this author already' }
    let(:params) do
      {
        author: 'Sendi Metz',
        title: 'another book'
      }
    end

    before do
      factory(described_class, params: params)
    end

    it 'has failure result' do
      expect(result).to be_failure
    end

    it 'handles an error' do
      expect(result[:errors]).to include(error)
    end
  end
end
