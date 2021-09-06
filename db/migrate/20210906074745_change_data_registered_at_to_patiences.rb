class ChangeDataRegisteredAtToPatiences < ActiveRecord::Migration[6.1]
  def change
    change_column :patiences, :registered_at, :date
  end
end
