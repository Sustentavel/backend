class CreateAiResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_responses do |t|
      t.text :user_prompt, null: false
      t.text :system_prompt
      t.text :output, null: false
      t.integer :total_tokens, null: false
      t.string :model, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
