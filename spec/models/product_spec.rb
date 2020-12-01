require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'should be created from factory' do
    expect(create(:product)).to be_persisted
  end

  it 'should have uniq refrence in client' do
    client = create(:client)
    product1 = create(:product, client: client)
    product2 = build(:product, client: client, reference: product1.reference)
    expect(product2).to_not be_valid
  end
end
