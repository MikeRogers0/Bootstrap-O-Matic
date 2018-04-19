class AddBodyBgAndBodyTextVariablesToConfigurator < ActiveRecord::Migration[5.2]
  def change
    add_column :bootstrap_configurations, :body_bg, :string, default: '#ffffff'
    add_column :bootstrap_configurations, :body_color, :string, default: '#212529'
  end
end
