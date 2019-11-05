class CreateSkill < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.string :ability
      t.string :name
      t.boolean :proficient
      t.timestamps
    end
    add_reference :skills, :character, null: true, foreign_key: true
  end
end
