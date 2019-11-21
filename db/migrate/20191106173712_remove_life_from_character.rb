class RemoveLifeFromCharacter < ActiveRecord::Migration[6.0]
  def change

    remove_column :characters, :life, :integer
  end
end
