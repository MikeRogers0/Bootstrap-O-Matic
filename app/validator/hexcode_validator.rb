class HexcodeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.present?
    return if (value =~ /\#[0-9a-fA-F]{3,6}+/) == 0

    record.errors.add(attribute, I18n.t("activerecord.errors.models.#{record.model_name.i18n_key}.attributes.#{attribute}.hexcode")) 
  end
end
