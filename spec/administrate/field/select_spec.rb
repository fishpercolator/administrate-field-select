require 'spec_helper'

describe Administrate::Field::Select do
  
  subject { described_class.new(:example, 'wibble', :form) }
  
  let(:options) { {} }
  before(:each) do
    allow(subject).to receive(:options).and_return(options)
  end
  
  describe '#select_options' do
    context 'no options' do
      it 'returns an empty array' do
        expect(subject.select_options).to eq([])
      end
    end
    context '1D :select_options without prettify' do
      let(:options) { { select_options: %w{foo bar baz} } }
      it 'returns the options verbatim' do
        expect(subject.select_options).to eq(%w{foo bar baz})
      end
    end
    context '2D :select_options' do
      let(:select_options) { [['foo', 'BAR'], ['baz', 'QUX']] }
      let(:options) { { select_options: select_options } }
      it 'returns the options verbatim' do
        expect(subject.select_options).to eq(select_options)
      end
    end
    context '1D :select_options with prettify=true' do
      let(:options) { { select_options: %w{foo bar baz}, prettify: true } }
      it 'returns a 2d options with titleized 1st element' do
        expect(subject.select_options).to eq([['Foo', 'foo'], ['Bar', 'bar'], ['Baz', 'baz']])
      end
    end
    context '1D :select_options with prettify=lambda' do
      let(:options) { { select_options: %w{foo bar bazz}, prettify: ->(x) {x.length} } }
      it 'returns a 2d options with lambda called on 1st element' do
        expect(subject.select_options).to eq([[3, 'foo'], [3, 'bar'], [4, 'bazz']])
      end
    end
  end
  
  describe '#to_s' do
    context 'no prettify' do
      it 'returns data verbatim' do
        expect(subject.to_s).to eq('wibble')
      end
    end
    context 'prettify=true' do
      let(:options) { {prettify: true} }
      it 'titleizes data' do
        expect(subject.to_s).to eq('Wibble')
      end
    end
    context 'prettify=lambda' do
      let(:options) { {prettify: ->(x) {x.length}} }
      it 'calls lambda on data' do
        expect(subject.to_s).to eq(6)
      end
    end    
  end
  
  describe '#include_blank' do
    context 'include_blank absent' do
      it 'returns false' do
        expect(subject.include_blank).to be false
      end
    end
    context 'include_blank present' do
      let(:options) { {include_blank: 'Select...'} }
      it 'returns its value' do
        expect(subject.include_blank).to eq('Select...')
      end
    end
  end
  
end
