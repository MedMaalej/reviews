class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|

      t.string :comment

      t.integer :score

      t.integer :sprintId

      t.string :decision
      
      t.string :status

      t.string :dater

      t.integer :userId
      
      t.integer :reviewerId
    end

  end
end
