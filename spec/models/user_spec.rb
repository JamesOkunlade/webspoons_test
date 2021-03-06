require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation test
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:status) }
end
