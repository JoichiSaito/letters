class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :refollowing_id
      t.integer :refollower_id

      t.timestamps
    end
  end
end
