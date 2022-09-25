class CreateShorteners < ActiveRecord::Migration[7.0]
  def change
    create_table :shorteners do |t|
      t.string :url
      t.string :short_code
      t.integer :alexa_rank
      t.integer :counter, default: 0

      t.timestamps
    end
  end
end
