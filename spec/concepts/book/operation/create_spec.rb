# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book::Operation::Create do
  subject(:result) { described_class.call(params: params) }

  context 'with valid data' do
    let(:params) do
      {
        author: 'Sendi Metz',
        title: 'POOD in Ruby',
        publisher: 'Anonim',
        category: 'ruby'
      }
    end

    it 'is success' do
      expect(result).to be_success
    end
  end
end
