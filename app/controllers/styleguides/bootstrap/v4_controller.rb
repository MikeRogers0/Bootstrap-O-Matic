class Styleguides::Bootstrap::V4Controller < ApplicationController
  before_action -> { respond_to :html }

  def show; end

  def buttons; end
  def alerts; end
  def typography; end
  def tables; end
  def forms; end
  def progress; end

  private
  helper_method :css_generator_url
  def css_generator_url(args={})
    css_bootstrap_v4_url({host: ENV['CSS_HOST'], format: :css}.merge(args))
  end

  helper_method :resource
  def resource
    if params[:id].present?
      @resource ||= BootstrapConfiguration.find(params[:id])
    else
      @resource ||= BootstrapConfiguration.build_from
    end
  end
end
