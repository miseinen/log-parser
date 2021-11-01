# frozen_string_literal: true

module Validators
  class DefaultFileValidator
    EXTENSIONS = %w[.log .txt].freeze

    def call(file)
      validate_existence(file)
      validate_extension(file)
      validate_data(file)
    end

    private

    def validate_existence(file)
      return if File.exist?(file)

      raise IOError, 'File does not exist'
    end

    def validate_extension(file)
      return if EXTENSIONS.include? File.extname(file)

      raise IOError, 'Invalid file format. Please use file with .log or .txt extensions'
    end

    def validate_data(file)
      return unless File.zero?(file)

      raise IOError, 'Log file is empty'
    end
  end
end
