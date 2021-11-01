# frozen_string_literal: true

module Views
  class ViewsExtractor
    def initialize(file:, file_validator:, visitors_list:)
      @file = file
      file_validator.call(file)
      @visitors_list = visitors_list
    end

    def all_desc
      sort_desc(all_views(extract_list.dup))
    end

    def unique_desc
      sort_desc(unique_views(extract_list.dup))
    end

    private

    def all_views(hash)
      hash.each { |target, visitors| hash[target] = visitors.count }
    end

    def unique_views(hash)
      hash.each { |target, visitors| hash[target] = visitors.uniq.count }
    end

    def sort_desc(hash)
      hash.sort_by { |_, visitors_count| visitors_count }.reverse.to_h
    end

    def extract_list
      File.foreach(@file.to_s) { |line| @visitors_list.append_list(line) }

      @visitors_list.list
    end
  end
end
