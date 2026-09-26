# frozen_string_literal: true

require_relative '../../lib/lost_and_found/models/lost_item'
require_relative '../../lib/lost_and_found/constants'

RSpec.describe LostItem do
  describe 'defaults' do
    it 'uses the lost status and exposes date_lost' do
      item = described_class.new(name: 'Black Wallet', location: 'Library', date_lost: '2026-09-01')

      expect(item.status).to eq(Status::LOST)
      expect(item.date_lost).to eq('2026-09-01')
      expect(item.date).to eq('2026-09-01')
    end
  end

  describe 'date compatibility' do
    it 'accepts the base date keyword' do
      item = described_class.new(name: 'Black Wallet', location: 'Library', date: '2026-09-01')

      expect(item.date_lost).to eq('2026-09-01')
    end
  end
end
