class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.string :name
      t.text :data

      t.timestamps
    end
  end
end
