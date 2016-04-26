class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|

      t.integer :id

      t.string :comment

      t.integer :score

      t.integer :sprintId

      t.string :decision

      t.string :dater

      t.integer :userId


    end

  end
end
