class AddNameToApi < ActiveRecord::Migration
  def self.up
    change_table :apis do |t|
      t.string :name
    end
  end

  def self.down
    change_table :apis do |t|
      t.remove :name
    end
  end
end
