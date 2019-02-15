class AddValidationToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :validation, :boolean
  end
end
