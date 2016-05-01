class CreatePatches < ActiveRecord::Migration
  def change
    create_table :patches do |t|

      t.string :ptime

      t.text :pOldText

      t.text :pNewText
     
      t.integer :pLine
    end

  end
end
