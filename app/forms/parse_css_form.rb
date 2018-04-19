class ParseCSSForm < ApplicationForm
  extend ModelAttribute

  attribute :url, :string

  validates :url, presence: true#, url: true

  validate :css_is_loadable

  def styleguide
    @styleguide
  end

  private

  def persist!
    @styleguide = BootstrapConfiguration.build_from
    @styleguide.attributes = {
      required_colours: required_colours,
      optional_colours: optional_colours,
      font_size_base: font_size_base,
      font_family_sans_serif: font_family_sans_serif.split(',').collect(&:strip).uniq,
      font_family_monospace: font_family_monospace.split(',').collect(&:strip).uniq,
      body_bg: body_bg,
      body_color: body_color
    }
    @styleguide.save
  end

  def body_bg
    @parser.find_rule_sets(["body"]).each do |css|
      return css['background-color'].gsub(';', '') if css['background-color'].present?
    end
    nil
  end

  def body_color
    @parser.find_rule_sets(["body"]).each do |css|
      return css['color'].gsub(';', '') if css['color'].present?
    end
    nil
  end

  def font_size_base
    @parser.find_rule_sets(["body"]).each do |css|
      css.expand_font_shorthand!
      font_size = css['font-size'].gsub(';', '')
      next unless font_size.present?

      return font_size.to_f if font_size.ends_with?('rem')
      return "#{( BigDecimal.new(font_size.to_i) / BigDecimal.new(16) ).round(2)}" if font_size.ends_with?('px')
    end
    '1'
  end

  def font_family_sans_serif
    @parser.find_rule_sets([":root"]).each do |css|
      return css['--font-family-sans-serif'].gsub(';', '') if css['--font-family-sans-serif'].present?
    end

    @parser.find_rule_sets(["body"]).each do |css|
      css.expand_font_shorthand!
      return css['font-family'].gsub(';', '') if css['font-family'].present?
    end
    'sans-serif'
  end

  def font_family_monospace
    @parser.find_rule_sets([":root"]).each do |css|
      return css['--font-family-monospace'].gsub(';', '') if css['--font-family-monospace'].present?
    end

    @parser.find_rule_sets(["pre,code,kbd,samp"]).each do |css|
      css.expand_font_shorthand!
      return css['font-family'].gsub(';', '') if css['font-family'].present?
    end
    'monospace'
  end

  def optional_colours
    ( @theme_colour_names - ['primary', 'success', 'danger'] ).collect do |name|
      { name: name, colour: find_colour_by_variable(name) }
    end
  end

  def required_colours
    ['primary', 'success', 'danger'].collect do |name|
      { name: name, colour: find_colour_by_variable(name) }
    end
  end

  def css_is_loadable
    #begin
     load_url! 
     discover_theme_colour_names!
    # rescue e
    #end
  end

  def discover_theme_colour_names!
    @theme_colour_names = ['primary', 'success', 'danger']
    @parser.each_selector do |selector|
      if selector.starts_with?('.btn-') && !selector.starts_with?('.btn-outline-') && !selector.starts_with?('.btn-group')
        @theme_colour_names << selector.match(/btn-([a-z0-9\-]+)/)[1]
      end
    end

    @theme_colour_names.select! do |colour|
      find_colour_by_variable(colour).present?
    end

    @theme_colour_names = @theme_colour_names.compact.uniq - ['link', 'sm', 'lg', 'block', 'xs', 'toolbar']
  end

  def find_colour_by_variable(name)
    @parser.find_rule_sets([":root"]).each do |css|
      return css["--#{name}"].gsub(';', '') if css["--#{name}"].present?
    end

    css = @parser.find_rule_sets([".btn-#{name}"]).first
    if css.present?
      css.expand_background_shorthand!
      css['background-color'].gsub(';', '')
    else
      '#000'
    end
  end

  def load_url!
    #https://github.com/premailer/css_parser
    require 'css_parser'

    @parser = CssParser::Parser.new
    @parser.load_uri!(url)
  end
end
