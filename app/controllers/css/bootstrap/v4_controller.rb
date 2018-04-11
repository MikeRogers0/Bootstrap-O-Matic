class Css::Bootstrap::V4Controller < ApplicationController
  before_action -> { respond_to :css }

  def show
    resource.attributes = resource_params

    respond_to do |format|
      format.css do
        render body: render_scss
      end
    end
  end

  private
  # https://stackoverflow.com/questions/24566456/how-do-i-render-sass-in-a-rails-partial
  def render_scss
    SassC::Engine.new(render_to_string('css/bootstrap/v4/css.scss'), {
      syntax: :scss,
      style: :compressed,
      compressed: true,
      filename: Rails.root.join('node_modules/bootstrap/scss/bootstrap.scss').to_s,
      source_map_file: ".",
      source_map_embed: true,
      source_map_contents: true,
    }).render
  end

  helper_method :resource
  def resource
    @resource ||= BootstrapConfiguration.build_from
  end

  def resource_params
    # params.require(:bootstrap_configuration).keys.collect(&:to_sym)
    if params[:bootstrap_configuration].present?
      params.require(:bootstrap_configuration).permit!
    else
      {}
    end
  end
end
