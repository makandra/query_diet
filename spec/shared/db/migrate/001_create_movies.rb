migration_class = Rails.version > '5' ? ActiveRecord::Migration[4.2] : ActiveRecord::Migration

class CreateMovies < migration_class

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
