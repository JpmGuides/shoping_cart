require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it 'should be created from factory' do
    expect(create(:order)).to be_persisted
  end
end
