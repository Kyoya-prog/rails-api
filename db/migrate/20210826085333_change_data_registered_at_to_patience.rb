class ChangeDataRegisteredAtToPatience < ActiveRecord::Migration[6.1]
  def change
      change_column :patiences, :registered_at, :datetime
  end
end
