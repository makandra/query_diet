database = Gemika::Database.new
database.connect
database.rewrite_schema! do

  create_table :movies do |t|
    t.string :title
    t.integer :year
  end

end
