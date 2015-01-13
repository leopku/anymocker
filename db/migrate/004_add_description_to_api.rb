class AddDescriptionToApi < ActiveRecord::Migration
  def self.up
    change_table :apis do |t|
      t.text :description
    end
  end

  def self.down
    change_table :apis do |t|
      t.remove :description
    end
  end
end
