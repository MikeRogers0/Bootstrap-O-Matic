class CreateBootstrapConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :bootstrap_configurations do |t|
      t.string :version
      t.json :store_required_colours
      t.json :store_optional_colours
      t.string :font_size_base
      t.string :font_family_sans_serif
      t.string :font_family_monospace

      t.timestamps
    end
  end
end
