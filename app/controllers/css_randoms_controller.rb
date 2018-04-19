class CssRandomsController < ApplicationController
  layout 'landing'

  def create
    raise resource.styleguide.errors.inspect unless resource.save
    redirect_to styleguides_bootstrap_v4_path(id: resource.styleguide)
  end

  private
  helper_method :resource
  def resource
    @resource ||= RandomCSSForm.new()
  end
end
