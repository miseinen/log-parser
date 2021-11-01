#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'validators/default_file_validator'
require_relative 'views/views_extractor'
require_relative 'views/default_visitors_list'
require_relative 'printer'

begin
  path = ARGV.first

  raise(ArgumentError, 'Path argument is required', caller) if path.nil?

  file_validator = Validators::DefaultFileValidator.new
  visitors_list = Views::DefaultVisitorsList.new
  printer = Printer.new

  page_views = Views::ViewsExtractor.new(file: path, file_validator: file_validator, visitors_list: visitors_list)

  printer.print_list(page_views.all_desc)
  printer.print_list(page_views.unique_desc, 'unique')
rescue StandardError => e
  puts e.class
  puts e.message
end
