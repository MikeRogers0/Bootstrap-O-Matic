class Styleguides::Bootstrap::V4Controller < ApplicationController
  before_action -> { respond_to :html }

  def show; end

  def buttons; end
  def alerts; end

  private
  helper_method :css_source_path
  def css_source_path
    session['bootstrap-vs-source'] || css_bootstrap_v4_path(format: :css)
  end

  helper_method :css_generator_path
  def css_generator_path
    css_bootstrap_v4_path(format: :css)
  end
end
