# frozen_string_literal: true

class Book < ApplicationRecord
  module Contract
    class Create < BaseForm
      property :author
      property :title
      property :publisher
      property :category

      validation do
        required(:author).filled
        required(:title).filled
      end
    end
  end
end
