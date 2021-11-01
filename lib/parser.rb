#!/usr/bin/env ruby
# frozen_string_literal: true

argument = ARGV.first

raise(ArgumentError, 'Path argument is required', caller) if ARGV.first.nil?

PAGE_REGEX = %r{/\w+[\s/]}
IP_REGEX = /\s(\d{1,3}.){3}\d{1,3}/

data = {}

IO.foreach(argument.to_s) do |line|
  page = PAGE_REGEX.match(line).to_s.strip.gsub(%r{/$}, '')
  data[page] = [] if data[page].nil?
  data[page] << IP_REGEX.match(line).to_s.strip
end

sorted = data.dup

def sort_desc(hash)
  Hash[hash.sort_by { |_, ip_count| ip_count }.reverse]
end

sorted.each { |page, ip| sorted[page] = ip.count }
sorted = sort_desc(sorted)

def show_list(hash, description = '')
  hash.each { |page, count| puts "#{page}: #{count}#{description} visits" }
end

puts "\n> list of webpages with most page views:"
show_list(sorted)

sorted_uniq = data.dup

sorted_uniq.each { |page, ip| sorted_uniq[page] = ip.uniq.count }
sorted_uniq = sort_desc(sorted_uniq)

puts "\n> list of webpages with most unique page views:"
show_list(sorted_uniq, ' unique')
