class CreateMovies < ActiveRecord::Migration

  def self.up
    create_table :movies do |t|
      t.string :title
      t.integer :year
    end
  end

  def self.down
    drop_table :movies
  end
  
end
