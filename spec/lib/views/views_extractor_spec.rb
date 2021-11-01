# frozen_string_literal: true

require_relative '../../../lib/views/views_extractor'

RSpec.describe Views::ViewsExtractor do
  let(:filename) { 'log.txt' }
  let(:visitors_list) { instance_double('Visitor List') }
  let(:file_validator) { instance_double('File Validator') }

  let(:list) do
    {
      '/contact': %w[184.123.665.067 184.123.665.067],
      '/home/2': %w[170.123.665.067]

    }
  end

  before do
    allow(file_validator).to receive(:call).with(filename).and_return(true)
    allow(File).to receive(:foreach).with(filename).and_yield(filename)
    allow(visitors_list).to receive(:append_list).with(any_args).and_return(list)
    allow(visitors_list).to receive(:list).and_return(list)
  end

  describe '#all_desc' do
    subject(:all_views) do
      described_class.new(file: filename,
                          file_validator: file_validator,
                          visitors_list: visitors_list).all_desc
    end

    let(:expected_value) { { '/contact': 2, '/home/2': 1 } }

    it 'returns all counted views in desc order' do
      expect(all_views).to eq(expected_value)
    end
  end

  describe '#unique_desc' do
    subject(:unique_views) do
      described_class.new(file: filename,
                          file_validator: file_validator,
                          visitors_list: visitors_list).unique_desc
    end

    let(:expected_value) { { '/contact': 1, '/home/2': 1 } }

    it 'returns unique counted views in desc order' do
      expect(unique_views).to eq(expected_value)
    end
  end
end
