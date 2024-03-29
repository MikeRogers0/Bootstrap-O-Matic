class BootstrapConfiguration < ApplicationRecord
  validates :required_colours, presence: true, nested_colors: true
  validates :optional_colours, nested_colors: true
  validates :font_family_sans_serif, presence: true
  validates :font_family_monospace, presence: true
  validates :font_size_base, presence: true, numericality: { greater_than: 0, less_than: 5 }
  validates :body_bg, presence: true
  validates :body_color, presence: true, hexcode: true

  def optional_colours_attributes=(values)
    self.optional_colours = values.collect do |id, value|
      value
    end.reject do |value|
      value['name'].blank? || value['colour'].blank?
    end
  end

  def optional_colours
    @optional_colours ||= (store_optional_colours || []).collect do |hash|
      Colour.new( hash['name'], hash['colour'] )
    end
  end

  def optional_colours=(value)
    self.store_optional_colours = value
    @optional_colours = nil
  end

  def required_colours_attributes=(values)
    self.required_colours = values.collect do |id, value|
      value
    end.reject do |value|
      value['name'].blank? || value['colour'].blank?
    end
  end

  def required_colours
    @required_colours ||= (store_required_colours || []).collect do |hash|
      Colour.new( hash['name'], hash['colour'] )
    end
  end

  def required_colours=(value)
    self.store_required_colours = value
    @required_colours = nil
  end

  def to_theme_colours
    theme_colours = required_colours.collect(&:id)
    theme_colours += optional_colours.collect(&:id)

    processed_theme_colours = theme_colours.collect do |theme_colour|
      "\"#{theme_colour}\": $#{theme_colour}"
    end.join(",\n")
    "$theme-colors: (\n#{processed_theme_colours}\n);"
  end

  def self.build_from
    bc = BootstrapConfiguration.new
    bc.attributes = {
      required_colours: [
        Colour.new( 'Primary', '#007bff' ),
        Colour.new( 'Success', '#6c757d' ),
        Colour.new( 'Danger', '#dc3545' ),
      ],
      optional_colours: [
        Colour.new( 'Secondary', '#6c757d' ),
        Colour.new( 'Info', '#17a2b8' ),
        Colour.new( 'Warning', '#ffc107' ),
        Colour.new( 'Light', '#f8f9fa' ),
        Colour.new( 'Dark', '#343a40' ),
      ],
      font_family_sans_serif: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol"'.split(', '),
      font_family_monospace: 'SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace'.split(', '),
      font_size_base: 1,
    }
    bc
  end

  def options_for_font_family_sans_serif
    (font_family_sans_serif + ["-apple-system", "BlinkMacSystemFont", "\"Segoe UI\"", "Roboto", "\"Helvetica Neue\"", "Arial", "sans-serif", "\"Apple Color Emoji\"", "\"Segoe UI Emoji\"", "\"Segoe UI Symbol\"", "Helvetica", "\"Arial Black\"", "Gadget", "\"Comic Sans MS\"", "cursive", "Impact", "Charcoal", "\"Lucida Sans Unicode\"", "\"Lucida Grande\""]).uniq
  end

  def options_for_font_family_monospace
    (font_family_monospace + ["SFMono-Regular", "Menlo", "Monaco", "Consolas", "\"Liberation Mono\"", "\"Courier New\"", "monospace", "Courier", "\"Lucida Console\""]).uniq
  end

  class Colour < Struct.new(:name, :colour)
    def persisted?
      false
    end

    def id
      name.parameterize
    end

    def to_scss_variable
      "$#{id}: #{colour};"
    end
  end
end
