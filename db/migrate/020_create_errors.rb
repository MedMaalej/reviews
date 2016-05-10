class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|

        t.string :errorName
    end

  end
end
