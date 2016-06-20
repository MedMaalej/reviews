class CreatePatches < ActiveRecord::Migration
  def change
    create_table :patches do |t|
      t.integer :reviewId

      t.integer :issueId

      t.string :ptime

      t.text :pComment
     
      t.string :pLine
      
      t.integer :pErrorId
       
      t.string :pFileName     
    end

  end
end
