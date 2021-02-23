class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.boolean :questionnaire

      t.timestamps
    end
  end
end
