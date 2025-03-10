# == Schema Information
#
# Table name: ai_responses
#
#  id            :integer          not null, primary key
#  user_prompt   :text             not null
#  system_prompt :text
#  output        :text             not null
#  total_tokens  :integer          not null
#  model         :string           not null
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_ai_responses_on_user_id  (user_id)
#

require 'spec_helper'

RSpec.describe TranslationPrompt, type: :model do
  context 'validations' do
    context 'is valid with valid attributes' do
      let(:translation_prompt) { described_class.new(from_language: 'en', to_language: 'es') }

      it do
        expect(translation_prompt).to be_valid
      end
    end

    context 'is invalid with invalid attributes' do
      let(:translation_prompt) { described_class.new(from_language: 'en', to_language: 'any_language') }

      it do
        expect(translation_prompt).not_to be_valid
      end
    end
  end

  context 'prompt' do
    let(:translation_prompt) { described_class.new(from_language: 'en', to_language: 'es') }

    it do
      expect(translation_prompt.prompt).to eq('Translate from English to Spanish. Please provide us only the translated text, and nothing more.')
    end
  end

  context 'acronym_to_language' do
    let(:translation_prompt) { described_class.new(from_language: 'en', to_language: 'es') }

    it do
      expect(translation_prompt.send(:acronym_to_language, 'en')).to eq('English')
    end
  end

  TranslationPrompt::POSSIBLE_LANGUAGES.each do |language|
    context "with #{language} language" do
      let(:translation_prompt) { described_class.new(from_language: language, to_language: 'es') }

      it do
        expect(translation_prompt).to be_valid
      end

      it 'have the corresponding language full name' do
        expect(translation_prompt.send(:acronym_to_language, language)).not_to be_nil
      end
    end
  end
end
