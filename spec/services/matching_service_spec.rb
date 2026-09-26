# frozen_string_literal: true

require_relative '../../lib/lost_and_found/services/matching_service'

RSpec.describe MatchingService do
  describe '#find_matches' do
    it 'returns no matches when there are no found items' do
      expect(described_class.new.find_matches(Object.new, [])).to eq([])
    end
  end
end
