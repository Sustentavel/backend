class TranslationPrompt
  include ActiveModel::Model
  include ActiveModel::Attributes

  POSSIBLE_LANGUAGES = %w[en es fr de it ja ko pt ru zh].freeze

  attribute :from_language, :string
  attribute :to_language, :string

  validates :from_language, presence: true, inclusion: { in: POSSIBLE_LANGUAGES + ['auto'] }
  validates :to_language, presence: true, inclusion: { in: POSSIBLE_LANGUAGES }

  def prompt
    "Translate from #{acronym_to_language(from_language)} to #{acronym_to_language(to_language)}. Please provide us only the translated text, and nothing more."
  end

  private

  def acronym_to_language(acronym)
    object = {
      'en' => 'English',
      'es' => 'Spanish',
      'fr' => 'French',
      'de' => 'German',
      'it' => 'Italian',
      'ja' => 'Japanese',
      'ko' => 'Korean',
      'pt' => 'Portuguese',
      'ru' => 'Russian',
      'zh' => 'Chinese'
    }

    object[acronym]
  end
end
