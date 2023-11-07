class CreateApiSecrets < ActiveRecord::Migration[7.1]
  def change
    create_table :api_secrets do |t|
      t.string :key

      t.timestamps
    end
  end
end
