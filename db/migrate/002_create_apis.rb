class CreateApis < ActiveRecord::Migration
  def self.up
    create_table :apis do |t|
      t.references :vendor
      t.string :input_type
      t.text :input
      t.string :output1_type
      t.text :output1
      t.string :output2_type
      t.text :output2
      t.timestamps
    end
  end

  def self.down
    drop_table :apis
  end
end
