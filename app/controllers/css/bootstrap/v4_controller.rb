class Css::Bootstrap::V4Controller < ApplicationController
  def show
    resource.attributes = resource_params
    return resource.errors.inspect unless resource.valid?

    respond_to do |format|
      format.scss {}
      format.css do
        render body: render_scss
      end
    end
  end

  private
  # https://stackoverflow.com/questions/24566456/how-do-i-render-sass-in-a-rails-partial
  def render_scss
    SassC::Engine.new(render_to_string('css/bootstrap/v4/show.scss'), {
      syntax: :scss,
      style: :compressed,
      compressed: true,
      filename: Rails.root.join('node_modules/bootstrap/scss/bootstrap.scss').to_s,
      source_map_file: '.',
      source_map_embed: true,
      source_map_contents: true,
    }).render
  end

  helper_method :resource
  def resource
    if params[:id].present?
      @resource ||= BootstrapConfiguration.find(params[:id])
    else
      @resource ||= BootstrapConfiguration.build_from
    end
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
