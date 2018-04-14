class CssParsersController < ApplicationController
  layout 'landing'

  def create
    return render :new unless resource.save
    redirect_to styleguides_bootstrap_v4_path(id: resource.styleguide)
  end

  private
  helper_method :resource
  def resource
    @resource ||= ParseCSSForm.new(resource_params)
  end

  def resource_params
    params.require(:parse_css_form).permit(:url)
  end
end
