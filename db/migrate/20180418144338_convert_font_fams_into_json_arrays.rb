class ConvertFontFamsIntoJsonArrays < ActiveRecord::Migration[5.2]
  def change
    remove_column :bootstrap_configurations, :font_family_sans_serif, :string
    remove_column :bootstrap_configurations, :font_family_monospace, :string

    add_column :bootstrap_configurations, :font_family_sans_serif, :json
    add_column :bootstrap_configurations, :font_family_monospace, :json
  end
end
