module ApplicationHelper
  def site_options?(key)
    data = ApplicationRecord::SiteOption.find_by_key(key.to_s)
    data.present? ? data.value : ''
  end
end
