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

RSpec.describe AiResponse, type: :model do
  context 'validations' do
    context 'is valid with valid attributes' do
      let(:user) { create(:user) }

      it do
        expect(user).to be_valid
      end
    end

    it { is_expected.to validate_presence_of(:user_prompt) }
    it { is_expected.to validate_presence_of(:output) }
    it { is_expected.to validate_presence_of(:total_tokens) }
    it { is_expected.to validate_presence_of(:model) }
    it { is_expected.to belong_to(:user) }
  end
end
