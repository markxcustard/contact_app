class Contact < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/




  def full_name
    [first_name, middle_name, last_name].join (' ')
  end
  def country_code
    international_code = "+81"
    [international_code, phone_number].join (' ')
  end
  def friendly_updated_at
    updated_at.strftime("%B %e, %Y")
  end
  def friendly_created_at
    created_at.strftime("%B %e, %Y")
  end
  def as_json
    {id: id,
      first_name: first_name,
      last_name: last_name,
      middle_name: middle_name,
      full_name: full_name,
      bio: bio,
      email: email,
      phone_number: phone_number,
      country_code: country_code,
      friendly_created_at: friendly_created_at,
      friendly_updated_time: friendly_updated_at}
  end
end
