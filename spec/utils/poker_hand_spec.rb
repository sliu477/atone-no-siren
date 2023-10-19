require 'rails_helper'

RSpec.describe PokerHand do
  describe '#evaluate_hand_type' do
    it 'correctly identifies a straight flush' do
      poker_hand = PokerHand.new('C7 C6 C5 C4 C3'.split)
      expect(poker_hand.evaluate_hand_type).to eq('ストレートフラッシュ')
    end
    it 'correctly identifies a four of a kind' do
      poker_hand = PokerHand.new('C10 D10 H10 S10 D5'.split)
      expect(poker_hand.evaluate_hand_type).to eq('フォー・オブ・ア・カインド')
    end
    it 'correctly identifies a full house' do
      poker_hand = PokerHand.new('S10 H10 D10 S4 D4'.split)
      expect(poker_hand.evaluate_hand_type).to eq('フルハウス')
    end
    it 'correctly identifies a flush' do
      poker_hand = PokerHand.new('S13 S12 S11 S9 S6'.split)
      expect(poker_hand.evaluate_hand_type).to eq('フラッシュ')
    end
    it 'correctly identifies a staight' do
      poker_hand = PokerHand.new('S8 S7 H6 H5 S4'.split)
      expect(poker_hand.evaluate_hand_type).to eq('ストレート')
    end
    it 'correctly identifies a three of a kind' do
      poker_hand = PokerHand.new('S12 C12 D12 S5 C3'.split)
      expect(poker_hand.evaluate_hand_type).to eq('スリー・オブ・ア・カインド')
    end
    it 'correctly identifies a two pair' do
      poker_hand = PokerHand.new('H13 D13 C2 D2 H11'.split)
      expect(poker_hand.evaluate_hand_type).to eq('ツーペア')
    end
    it 'correctly identifies a pair' do
      poker_hand = PokerHand.new('C2 D2 H5 S7 C13'.split)
      expect(poker_hand.evaluate_hand_type).to eq('ペア')
    end
    it 'correctly identifies a high card' do
      poker_hand = PokerHand.new('D1 D10 S9 C5 C4'.split)
      expect(poker_hand.evaluate_hand_type).to eq('ハイカード')
    end
  end
end
