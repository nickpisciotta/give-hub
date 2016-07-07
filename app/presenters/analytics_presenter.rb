class AnalyticsPresenter

  def initialize(charity)
    @charity = charity
  end

  def get_id_data
    [@charity.recipients.pluck(:name), @charity.recipients.pluck(:id)]
  end

  def get_data
  end

  #recipients - active, inactive
  #total donations $ and #
  #needs by needs category
  # # outstanding need items by recipient_photo
  # donors by amount/#donations

end
