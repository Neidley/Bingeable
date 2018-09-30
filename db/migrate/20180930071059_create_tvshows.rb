class CreateTvshows < ActiveRecord::Migration[5.1]
  def change
    create_table :tvshows do |t|
      t.string :original_name
      t.string :backdrop_path

      t.timestamps
    end
  end
end
