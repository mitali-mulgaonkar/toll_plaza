class CreateTolls < ActiveRecord::Migration
  def change
    create_table :tolls do |t|

      t.timestamps
    end
  end
end
