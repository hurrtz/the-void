class CreatePlanets < ActiveRecord::Migration
  def change
    create_table :planets do |t|

      t.timestamps
    end
  end
end
