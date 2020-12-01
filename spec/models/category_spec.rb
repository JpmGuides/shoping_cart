require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'should be created from factory' do
    expect(create(:category)).to be_persisted
  end
end
