class ParseCSSForm < ApplicationForm
  extend ModelAttribute

  attribute :url, :string

  validates :url, presence: true, url: true

  private

  def persist!
  end

  def load_url!
    #https://github.com/premailer/css_parser
    require 'css_parser'
    include CssParser

    parser = CssParser::Parser.new
    parser.load_uri!('http://example.com/styles/style.css')
  end
end
