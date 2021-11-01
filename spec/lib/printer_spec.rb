# frozen_string_literal: true

require_relative '../../lib/printer'

RSpec.describe Printer do
  describe '#print_list' do
    subject(:printed_list) { -> { described_class.new.print_list(hash, note) } }

    context 'when "note" attribute is not given' do
      let(:hash) { { '/contact' => 2, '/home/2' => 1 } }
      let(:note) { '' }
      let(:expected_output) do
        <<~TEXT

          > list of webpages with most page views:
          /contact: 2 visits
          /home/2: 1 visits
        TEXT
      end

      it 'returns formatted log without special note' do
        expect(printed_list).to output(expected_output).to_stdout
      end
    end

    context 'when "note" and "hash" attributes are given' do
      let(:hash) { { '/contact' => 2, '/home/2' => 1 } }
      let(:note) { 'unique' }
      let(:expected_output) do
        <<~TEXT

          > list of webpages with most unique page views:
          /contact: 2 unique visits
          /home/2: 1 unique visits
        TEXT
      end

      it 'returns formatted logs with special note' do
        expect(printed_list).to output(expected_output).to_stdout
      end
    end

    context 'when "hash" attribute is empty' do
      let(:hash) { {} }
      let(:note) { 'unique' }
      let(:expected_output) do
        <<~TEXT

          > list of webpages with most unique page views:
        TEXT
      end

      it 'does not returns formatted logs' do
        expect(printed_list).to output(expected_output).to_stdout
      end
    end
  end
end
