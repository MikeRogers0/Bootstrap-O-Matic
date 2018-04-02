class Css::Bootstrap::V4Controller < ApplicationController
  before_action -> { respond_to :css }

  def show
    respond_to do |format|
      format.css do
        render body: render_scss('node_modules/bootstrap/scss/bootstrap.scss')
      end
    end
  end

  private
  # https://stackoverflow.com/questions/24566456/how-do-i-render-sass-in-a-rails-partial
  def render_scss(file)
    Rails.cache.fetch("css/bootstrap/v4/#{variables_params.to_s}", expires_in: 12.hours) do

      filename = Rails.root.join(file).to_s

      custom_varibles =  variables_params.to_h.collect do |name, value|
        "$#{name}: #{value};"
      end.join(' ')

      engine = Sass::Engine.new("#{custom_varibles} #{File.read(filename)}", {
        syntax: :scss,
        style: :compressed,
        compressed: true,
        filename: filename
      })

      engine.render
    end

  end

  def variables_params
    if params[:variables].present?
      params.require(:variables).permit!
    else
      {}
    end
  end
end
