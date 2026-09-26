# frozen_string_literal: true

require_relative '../../lib/lost_and_found/models/found_item'
require_relative '../../lib/lost_and_found/constants'

RSpec.describe FoundItem do
  describe 'defaults' do
    it 'uses the found status and exposes date_found' do
      item = described_class.new(name: 'Car Keys', location: 'Gym', date_found: '2026-09-02')

      expect(item.status).to eq(Status::FOUND)
      expect(item.date_found).to eq('2026-09-02')
      expect(item.date).to eq('2026-09-02')
    end
  end

  describe 'date compatibility' do
    it 'accepts the base date keyword' do
      item = described_class.new(name: 'Car Keys', location: 'Gym', date: '2026-09-02')

      expect(item.date_found).to eq('2026-09-02')
    end
  end
end
