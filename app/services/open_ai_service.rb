require 'openai'

class OpenAiService
  def initialize
    @client = OpenAI::Client.new(
      access_token: ENV['OPENAI_AI_API_KEY'],
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
            content: user_prompt
          }
        ],
        **options
      }
    )

    response[:choices]&.first[:message][:content] || raise('No response from AI')
  end
end
