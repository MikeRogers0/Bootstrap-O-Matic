class ApplicationForm
  include ActiveModel::Model

  def initialize(attributes={})
    # Pass flag to set_attributes to allow setting attributes with private writers
    set_attributes(attributes, true)
  end

  def attributes=(attributes)
    set_attributes(attributes, true)
  end

  def save
    if valid?
      persist!
    else
      false
    end
  end

  private

  def persist!; end

  def i18n_path
    @i18n_path ||= "#{self.class.to_s.underscore}"
  end

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
      include ActionView::Helpers
    end.new
  end
end
