class RenameDescriptionColumnToPatiences < ActiveRecord::Migration[6.1]
  def change
    rename_column :patiences, :description, :memo
  end
end
