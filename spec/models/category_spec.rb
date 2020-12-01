require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'should be created from factory' do
    expect(create(:category)).to be_persisted
  end

  it 'should have uniq refrence in client' do
    client = create(:client)
    category1 = create(:category, client: client)
    category2 = build(:category, client: client, reference: category1.reference)
    expect(category2).to_not be_valid
  end
end
