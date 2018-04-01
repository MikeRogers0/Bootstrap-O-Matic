class Styleguides::Bootstrap::V4Controller < ApplicationController
  before_action -> { respond_to :html }

  def show; end

  def buttons; end
  def alerts; end

  private
  helper_method :css_generator_url
  def css_generator_url
    css_bootstrap_v4_url(host: ENV['CSS_HOST'], format: :css)
  end
end
