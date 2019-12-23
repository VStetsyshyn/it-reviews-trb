# frozen_string_literal: true

class Book < ApplicationRecord
  module Contract
    class Create < BaseForm
      property :author
      property :title
      property :publisher
      property :category

      validation :default do
        required(:title).filled
        required(:author).filled
      end

      validation :unique_title_for_author, if: :default, with: { form: true } do
        configure do
          config.messages_file = './config/errors.yml'

          def title
            form.input_params[:title]
          end

          def unique_title_for_author?(author)
            !Book.where(author: author, title: title).exists?
          end
        end

        required(:author).filled(:unique_title_for_author?)
      end
    end
  end
end
