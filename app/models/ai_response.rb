# frozen_string_literal: true

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

class AiResponse < ApplicationRecord
  validates :user_prompt, presence: true
  validates :output, presence: true
  validates :total_tokens, presence: true
  validates :model, presence: true

  belongs_to :user
end
