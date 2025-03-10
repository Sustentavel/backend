require "gemini-ai"

class GoogleAiService
  def initialize(user:)
    @client = GeminiAi::Client.new(
      api_key: ENV['GEMINI_AI_API_KEY']
    )
    @current_user = user
  end

  def generate_text(prompt:, system_prompt:, options: {})
    contents = {
      contents: {
        role: 'user',
        parts: {
          text: "#{system_prompt}\n#{prompt}"
        }
      }
    }

    response = @client.generate_content(
      contents,
      model: 'gemini-2.0-flash'
    )

    formatted_response = {
      message: response['candidates']&.first['content']['parts']&.first['text'] || raise('No response from AI'),
      metadata: {
        prompt_tokens: response['usageMetadata']['promptTokenCount'],
        candidate_tokens: response['usageMetadata']['candidatesTokenCount'],
        model: response['modelVersion']
      }
    }

    @current_user.ai_responses.create!(
      user_prompt: prompt,
      system_prompt: system_prompt,
      output: formatted_response[:message],
      total_tokens: formatted_response[:metadata][:candidate_tokens],
      model: formatted_response[:metadata][:model]
    )

    formatted_response[:message]
  end
end
