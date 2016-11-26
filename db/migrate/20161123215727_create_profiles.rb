class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :location
      t.string :occupation
      t.text :about_me
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
