# frozen_string_literal: true

require_relative '../../../lib/views/default_visitors_list'

RSpec.describe Views::DefaultVisitorsList do
  let(:described_class_instance) { described_class.new }
  let(:list) { described_class_instance.list }

  describe '#append_list' do
    subject(:append_list) { -> { described_class_instance.append_list(log_line) } }

    context 'when log line is not nil and not empty' do
      let(:log_line) { "#{expected_target} #{expected_visitor}" }
      let(:expected_target) { '/contact' }
      let(:expected_visitor) { '184.123.665.067' }

      it 'adds new record to list' do
        expect(append_list).to change(list, :count).from(0).to(1)
      end

      it 'appends list by expected page' do
        expect(append_list).to change(list, :keys).from([]).to([expected_target])
      end

      it 'appends list by expected ip' do
        expect(append_list).to change { list[expected_target] }.from(nil).to([expected_visitor])
      end
    end

    context 'when log line is nil' do
      let(:log_line) { nil }

      it 'does not add new record to list' do
        expect(append_list).not_to change(list, :count)
      end
    end

    context 'when log line is empty' do
      let(:log_line) { '' }

      it 'does not add new record to list' do
        expect(append_list).not_to change(list, :count)
      end
    end
  end
end
