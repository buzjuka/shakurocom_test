class BaseForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def submit(params)
    assign_params(params)
    return false if invalid?
    save_form!
    true
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    false
  end

  private

  def assign_params(_params)
    raise NotImplementedError
  end

  def save_form!
    raise NotImplementedError
  end
end
