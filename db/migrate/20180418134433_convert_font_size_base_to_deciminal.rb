class ConvertFontSizeBaseToDeciminal < ActiveRecord::Migration[5.2]
  def change
    remove_column :bootstrap_configurations, :font_size_base, :string
    add_column :bootstrap_configurations, :font_size_base, :decimal, precision: 10, scale: 6, default: 1
  end
end
