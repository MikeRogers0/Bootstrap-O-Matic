class Styleguides::Bootstrap::V4Controller < ApplicationController
  before_action -> { respond_to :html }

  def show; end

  def buttons; end
  def alerts; end
  def typography; end
  def tables; end
  def forms; end

  private
  helper_method :css_generator_url
  def css_generator_url
    css_bootstrap_v4_url(host: ENV['CSS_HOST'], format: :css)
  end

  helper_method :resource
  def resource
    @resource ||= BootstrapConfiguration.build_from
  end
end
