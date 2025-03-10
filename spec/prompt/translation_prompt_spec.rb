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
  let(:from_language) { Language.new(acronym: 'en') }
  let(:to_language) { Language.new(acronym: 'es') }

  context 'validations' do
    context 'is valid with valid attributes' do
      let(:translation_prompt) { described_class.new(from_language: from_language, to_language: to_language) }

      it do
        expect(translation_prompt).to be_valid
      end
    end

    context 'is invalid with invalid attributes' do
      let(:translation_prompt) { described_class.new(from_language: from_language, to_language: Language.new(acronym: 'any_language')) }

      it do
        expect(translation_prompt.errors.full_messages).to eq(['Linguagem de Destino não está incluído na lista'])
      end
    end

    context 'is invalid with equal languages' do
      let(:translation_prompt) { described_class.new(from_language: from_language, to_language: from_language) }

      it do
        expect(translation_prompt.errors.full_messages).to eq(['Linguagem de Origem não pode ser igual à Linguagem de Destino'])
      end
    end
  end

  context 'prompt' do
    let(:translation_prompt) { described_class.new(from_language: from_language, to_language: to_language) }

    it do
      expect(translation_prompt.prompt).to eq('Traduza de Inglês para Espanhol. Por favor, forneça-nos apenas o texto traduzido, e nada mais.')
    end
  end

  Language::POSSIBLE_LANGUAGES.each do |language|
    context "with #{language} language" do
      let(:translation_prompt) { described_class.new(from_language: Language.new(acronym: language), to_language: Language.new(acronym: 'es'))}

      it do
        expect(translation_prompt).to be_valid
      end
    end
  end
end
