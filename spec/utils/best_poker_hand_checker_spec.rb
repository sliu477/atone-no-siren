require 'rails_helper'

RSpec.describe BestPokerHandChecker, type: :module do
  let(:card_sets) { ['S1 S2 S3 S4 S5', 'D3 D12 D11 D10 D1', 'D9 S9 H4 H6 H2'] }
  before do
    allow_any_instance_of(PokerHand).to receive(:evaluate_hand_type) do |args|
      case args
      when card_sets[0].split
        'ストレートフラッシュ'
      when card_sets[1].split
        'フラッシュ'
      when card_sets[2].split
        'ハイカード'
      end
    end
  end
  describe 'check_best_poker_hand' do
    it 'return the card set with highest score' do
      check_best_poker_hand
      expect(@response).to eq('S1 S2 S3 S4 S5')
    end
  end

  def check_best_poker_hand
    @response = BestPokerHandChecker.check_best_poker_hand(card_sets)
  end
end
