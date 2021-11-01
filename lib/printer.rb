# frozen_string_literal: true

class Printer
  def print_list(hash, note = '')
    note = " #{note}" unless note.empty?
    puts "\n> list of webpages with most#{note} page views:"
    hash.each { |page, count| puts "#{page}: #{count}#{note} visits" }
  end
end
