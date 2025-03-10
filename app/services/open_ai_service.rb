# frozen_string_literal: true

require 'openai'

class OpenAiService
  def initialize
    @client = OpenAI::Client.new(
      access_token: ENV.fetch('OPENAI_AI_API_KEY', nil),
      log_errors: true
    )
  end

  def generate_text(prompt:, system_prompt:, options: {})
    response = @client.chat(
      parameters: {
        model: 'gpt-4-vision-preview',
        messages: [
          {
            role: 'system',
            content: system_prompt
          },
          {
            role: 'user',
            content: prompt
          }
        ],
        **options
      }
    )

    content = response[:choices]&.first&.[](:message)&.[](:content)

    raise(CustomException, 'No response from OpenAI') if content.nil?

    content
  end
end
