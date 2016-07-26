require 'spec_helper'

describe Administrate::Field::SelectBasic do
  
  subject { described_class.new(:example, 'wibble', :form) }
  
  let(:options) { {} }
  before(:each) do
    allow(subject).to receive(:options).and_return(options)
  end
  
  describe '#choices' do
    context 'no options' do
      it 'returns an empty array' do
        expect(subject.choices).to eq([])
      end
    end
    context '1D :choices without prettify' do
      let(:options) { { choices: %w{foo bar baz} } }
      it 'returns the choices verbatim' do
        expect(subject.choices).to eq(%w{foo bar baz})
      end
    end
    context '2D :choices' do
      let(:choices) { [['foo', 'BAR'], ['baz', 'QUX']] }
      let(:options) { { choices: choices } }
      it 'returns the choices verbatim' do
        expect(subject.choices).to eq(choices)
      end
    end
    context '1D :choices with prettify=true' do
      let(:options) { { choices: %w{foo bar baz}, prettify: true } }
      it 'returns 2d choices with titleized 1st element' do
        expect(subject.choices).to eq([['Foo', 'foo'], ['Bar', 'bar'], ['Baz', 'baz']])
      end
    end
    context '1D :choices with prettify=lambda' do
      let(:options) { { choices: %w{foo bar bazz}, prettify: ->(x) {x.length} } }
      it 'returns 2d choices with lambda called on 1st element' do
        expect(subject.choices).to eq([[3, 'foo'], [3, 'bar'], [4, 'bazz']])
      end
    end
    context '1D :choices with i18n=true' do
      let(:options) { { choices: %w{foo bar baz}, i18n: true } }
      it 'returns 1d choices with translated 1st element' do
        allow(I18n).to receive(:t).with('foo').and_return('FOO')
        allow(I18n).to receive(:t).with('bar').and_return('BAR')
        allow(I18n).to receive(:t).with('baz').and_return('BAZ')

        expect(subject.choices).to eq([['FOO', 'foo'], ['BAR', 'bar'], ['BAZ', 'baz']])
      end
    end
    context '2D :choices with i18n=true' do
      let(:options) { { choices: [['foo', 0], ['bar', 1]], i18n: true } }
      it 'returns 2d choices with translated 1st element and unadulterated 2nd element' do
        allow(I18n).to receive(:t).with('foo').and_return('FOO')
        allow(I18n).to receive(:t).with('bar').and_return('BAR')

        expect(subject.choices).to eq([['FOO', 0], ['BAR', 1]])
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
