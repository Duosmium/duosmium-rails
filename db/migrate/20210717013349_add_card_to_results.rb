class AddCardToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :card, :text
  end
end
