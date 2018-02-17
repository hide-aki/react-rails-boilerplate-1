class Role < ApplicationRecord
  has_and_belongs_to_many :users

  validates :title, presence: true, uniqueness: {case_sensitive: false}
  before_validation :process_data

  private

  # process data before validation
  def process_data
    self.title = self.title.downcase
  end
end
