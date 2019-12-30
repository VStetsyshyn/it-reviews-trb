# frozen_string_literal: true

class Book < ApplicationRecord
  module Operation
    class Search < OperationBase
      step :create_parameters
      fail :show_errors, fail_fast: true
      step :model
      step :any_books?
      fail :books_undefined

      def create_parameters(options, params:, **)
        parameters = {}
        parameters[:title] = params[:title] if params[:title]
        parameters[:author] = params[:author] if params[:author]
        parameters[:category] = params[:category] if params[:category]
        options[:parameters] = parameters if parameters.any?
      end

      def show_errors(options, **)
        options[:errors] = 'Please fill searching fields'
      end

      def model(options, parameters:, **)
        options[:model] = Book.where(parameters)
      end

      def any_books?(_options, model:, **)
        model.any?
      end

      def books_undefined(options, **)
        options[:errors] = 'There aren\'t such books'
      end
    end
  end
end
