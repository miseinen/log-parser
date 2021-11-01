# frozen_string_literal: true

module Views
  class DefaultVisitorsList
    attr_reader :list

    TARGET_REGEX = %r{/\w+(/\d)?}
    VISITOR_REGEX = %r{(\d{1,3}.){3}\d{1,3}}

    def initialize
      @list = {}
    end

    def append_list(line)
      return if line.nil? || line.empty?

      list[target(line)] = [] if list[target(line)].nil?
      list[target(line)] << visitor(line)
    end

    private

    def target(line)
      TARGET_REGEX.match(line).to_s.strip
    end

    def visitor(line)
      VISITOR_REGEX.match(line).to_s.strip
    end
  end
end
