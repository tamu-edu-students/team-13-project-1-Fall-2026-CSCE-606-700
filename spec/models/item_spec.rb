# frozen_string_literal: true

require_relative '../../lib/lost_and_found/models/item'

RSpec.describe Item do
  subject(:item) do
    described_class.new(
      id: 1,
      name: 'Black Wallet',
      description: 'Leather wallet',
      category: 'Accessory',
      location: 'Library',
      date: '2026-09-01',
      status: 'Lost'
    )
  end

  describe 'attributes' do
    it 'stores the item details' do
      expect(item.to_h).to eq(
        'type' => 'Item',
        'id' => 1,
        'name' => 'Black Wallet',
        'description' => 'Leather wallet',
        'category' => 'Accessory',
        'location' => 'Library',
        'date' => '2026-09-01',
        'status' => 'Lost'
      )
    end

    it 'allows the status to be updated' do
      item.status = 'Returned'

      expect(item.status).to eq('Returned')
    end
  end

  describe '#to_s' do
    it 'formats the item for display' do
      expect(item.to_s).to eq('ID: 1 | Black Wallet | Accessory | Library | 2026-09-01 | Lost')
    end
  end

  describe '.from_h' do
    it 'builds an item from persisted attributes' do
      restored = described_class.from_h(item.to_h)

      expect(restored.to_h).to eq(item.to_h)
    end
  end
end
