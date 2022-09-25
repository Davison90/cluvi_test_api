class Shortener < ApplicationRecord
  validates :url, format: URI::regexp(/^((https)|(http)).*/), presence: true
  validates :alexa_rank, :counter, presence: true

  before_validation :generate_short_code

  def generate_short_code
    self.short_code = SecureRandom.uuid[0..6] if self.short_code.nil? || self.short_code.empty?
  end
end
