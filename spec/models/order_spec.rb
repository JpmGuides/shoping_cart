require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'should be created from factory' do
    expect(create(:order)).to be_persisted
  end

  it 'should be created with an api key' do
    order = build(:order)
    expect(order.key).to be_nil
    order.save
    expect(order.key).to_not be_nil
  end
end
