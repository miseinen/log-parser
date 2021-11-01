# frozen_string_literal: true

require_relative '../../../lib/validators/default_file_validator'

RSpec.describe Validators::DefaultFileValidator do
  describe '#call' do
    subject(:validator) { described_class.new.call(filename) }

    context 'when file does not exist' do
      let(:filename) { 'filename.txt' }
      let(:error_message) { 'File does not exist' }

      it 'raises IOError' do
        expect { validator }.to raise_error(IOError, error_message)
      end
    end

    context 'when file has not supported extensions' do
      let(:filename) { 'filename.doc' }
      let(:error_message) { 'Invalid file format. Please use file with .log or .txt extensions' }

      before do
        allow(File).to receive(:exist?).with(filename).and_return(true)
      end

      it 'raises IOError' do
        expect { validator }.to raise_error(IOError, error_message)
      end
    end

    context 'when file is empty' do
      let(:filename) { 'filename.log' }
      let(:error_message) { 'Log file is empty' }

      before do
        allow(File).to receive(:exist?).with(filename).and_return(true)
        allow(File).to receive(:zero?).with(filename).and_return(true)
      end

      it 'raises IOError' do
        expect { validator }.to raise_error(IOError, error_message)
      end
    end

    context 'when file exists, not empty, has supported extension' do
      let(:filename) { 'filename.log' }

      before do
        allow(File).to receive(:exist?).with(filename).and_return(true)
        allow(File).to receive(:zero?).with(filename).and_return(false)
      end

      it 'does not raise an error' do
        expect { validator }.not_to raise_error
      end
    end
  end
end
