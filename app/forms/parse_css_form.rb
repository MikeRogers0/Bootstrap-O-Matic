class ParseCSSForm < ApplicationForm
  extend ModelAttribute

  attribute :url, :string

  validates :url, presence: true, url: true

  private

  def persist!
  end

  def load_url!
    #https://github.com/premailer/css_parser
  end
end
