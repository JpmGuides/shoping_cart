require 'rails_helper'

RSpec.describe Client, type: :model do
  it 'should be created from factory' do
    expect(create(:client)).to be_persisted
  end

  it 'should be created with an api key' do
    client = build(:client)
    expect(client.api_key).to be_nil
    client.save
    expect(client.api_key).to_not be_nil
  end
end
