# frozen_string_literal: true

require_relative '../../lib/lost_and_found/services/matching_service'
require_relative '../../lib/lost_and_found/models/lost_item'
require_relative '../../lib/lost_and_found/models/found_item'

RSpec.describe MatchingService do
  describe '#find_matches' do
    it 'returns no matches when there are no found items' do
      expect(described_class.new.find_matches(Object.new, [])).to eq([])
    end

    it 'matches a found item with the same name and location' do
      lost = LostItem.new(name: 'Black Wallet', category: 'Wallet', location: 'Library')
      found = FoundItem.new(name: 'Black Wallet', category: 'Wallet', location: 'Library')

      expect(described_class.new.find_matches(lost, [found])).to eq([found])
    end

    it 'matches using a single provided field' do
      lost = LostItem.new(name: '', category: 'Wallet', location: '', description: '')
      found = FoundItem.new(name: 'Black Wallet', category: 'Wallet', location: 'Library')

      expect(described_class.new.find_matches(lost, [found])).to eq([found])
    end

    it 'returns no matches when every query field is blank' do
      lost = LostItem.new(name: '', category: '', location: '', description: '')
      found = FoundItem.new(name: 'Black Wallet', category: 'Wallet', location: 'Library')

      expect(described_class.new.find_matches(lost, [found])).to eq([])
    end

    it 'matches even when the description wording differs slightly' do
      lost = LostItem.new(name: 'Black Wallet', category: 'Wallet', location: 'Library', description: 'Leather wallet')
      found = FoundItem.new(
        name: 'Black Wallet', category: 'Wallet', location: 'Library', description: 'Brown leather wallet'
      )

      expect(described_class.new.find_matches(lost, [found])).to eq([found])
    end

    it 'excludes clearly unrelated items' do
      lost = LostItem.new(name: 'Black Wallet', category: 'Wallet', location: 'Library')
      found = FoundItem.new(name: 'Car Keys', category: 'Keys', location: 'Gym')

      expect(described_class.new.find_matches(lost, [found])).to eq([])
    end
  end
end
