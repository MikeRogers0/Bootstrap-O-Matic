class RandomCssForm < ApplicationForm
  extend ModelAttribute

  def styleguide
    @styleguide
  end

  private

  def persist!
    @styleguide = BootstrapConfiguration.build_from
    @styleguide.attributes = {
      required_colours: [
        { name: 'primary', colour: colormind[0] },
        { name: 'success', colour: colormind[1] },
        { name: 'danger', colour: colormind[2] }
      ],
      optional_colours: [
        { name: 'Secondary', colour: colormind[3] },
        { name: 'Info', colour: colormind[4] },
      ]
    }
    @styleguide.save
  end

  def colormind
    @colormind ||= Colormind::Api.random_colours
  end

end
