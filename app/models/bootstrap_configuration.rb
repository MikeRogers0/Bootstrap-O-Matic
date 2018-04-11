class BootstrapConfiguration < ApplicationRecord
  def optional_colours_attributes=(values)
    raise values.inspect
    #optional_colours=
  end

  def optional_colours
    @optional_colours ||= store_optional_colours.collect do |hash|
      Colour.new( hash['name'], hash['colour'] )
    end
  end

  def optional_colours=(value)
    self.store_optional_colours = value
    @optional_colours = nil
  end

  def required_colours_attributes=(values)
    # Process the attributes hash
  end

  def required_colours
    @required_colours ||= store_required_colours.collect do |hash|
      Colour.new( hash['name'], hash['colour'] )
    end
  end

  def required_colours=(value)
    self.store_required_colours = value
    @required_colours = nil
  end

  def to_theme_colours
    theme_colours = required_colours.collect(&:name)
    theme_colours += optional_colours.collect(&:name)

    processed_theme_colours = theme_colours.collect do |theme_colour|
      "\"#{theme_colour}\": $#{theme_colour}"
    end.join(",\n")
    "$theme-colors: (\n#{processed_theme_colours}\n);"
  end

  def self.build_from
    bc = BootstrapConfiguration.new
    bc.attributes = {
      required_colours: [
        Colour.new( 'primary', '#000000' ),
        Colour.new( 'success', '#000000' ),
        Colour.new( 'danger', '#000000' ),
      ],
      optional_colours: [
        Colour.new( 'custom', '#000000' ),
        Colour.new( 'custom2', '#000000' )
      ]
    }
    bc
  end

  class Colour < Struct.new(:name, :colour)
    def persisted?
      false
    end

    def to_scss_variable
      "$#{name}: #{colour};"
    end
  end
end
