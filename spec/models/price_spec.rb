require 'rails_helper'

RSpec.describe Price, type: :model do
  it 'should be created from factory' do
    expect(create(:price)).to be_persisted
  end
end
