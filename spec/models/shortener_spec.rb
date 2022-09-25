require 'rails_helper'

RSpec.describe Shortener, type: :model do
  describe 'validations' do
    # it { should validate_presence_of(:url) }
    # it { should validate_presence_of(:short_code) }
    it { should validate_presence_of(:alexa_rank) }
    it { should validate_presence_of(:counter) }
  end
end
