# frozen_string_literal: true

class Book < ApplicationRecord
  module Operation
    class Create < Trailblazer::Operation
      class Present < Trailblazer::Operation
        step Model(Book, :new)
        step self::Contract::Build(constant: Book::Contract::Create)
      end

      step Subprocess(Present)
      step self::Contract::Validate()
      step self::Contract::Persist()
    end
  end
end
