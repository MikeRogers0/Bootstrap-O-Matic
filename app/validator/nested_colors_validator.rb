class NestedColorsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if !value.present? || value.empty?

    value.each do |color_hex|
      if (color_hex.name =~ /[0-9a-zA-z\-\ ]/) != 0
        return record.errors.add(attribute, I18n.t("activerecord.errors.models.#{record.model_name.i18n_key}.attributes.#{attribute}.name")) 
      end

      if (color_hex.colour =~ /\#[0-9a-fA-F]{3,6}+/) != 0
        return record.errors.add(attribute, I18n.t("activerecord.errors.models.#{record.model_name.i18n_key}.attributes.#{attribute}.hexcode")) 
      end
    end
  end
end
