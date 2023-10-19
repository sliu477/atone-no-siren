require 'rails_helper'

RSpec.describe PokerHandEvaluationService, type: :service do
  let(:valid_card_sets) { ['S1 S2 S3 S4 S5', 'D3 D12 D11 D10 D1', 'D9 S9 H4 H6 H2'] }
  let(:invalid_card_set) { 'S22 H3 S8 D5 D8' }
  let(:validator_stub) { class_double('PokerHandValidator').as_stubbed_const }

  before do
    allow(BestPokerHandChecker).to receive(:check_best_poker_hand).and_return('S1 S2 S3 S4 S5')
    allow(validator_stub).to receive(:validate_single_card_set) do |cards|
      cards.include?(invalid_card_set) ? 'invalid card set' : nil
    end
    poker_hand_mock = instance_double(PokerHand)
    allow(PokerHand).to receive(:new).and_return(poker_hand_mock)
    allow(poker_hand_mock).to receive(:evaluate_hand_type).and_return('mock_hand_type')
  end

  describe 'analyze_card_sets' do
    context 'all card sets are valid' do
      let(:request_card_sets) { valid_card_sets }
      it 'evaluate card sets and generate response' do
        analyze_card_sets

        hand = @response[:result].map { |result| result[:hand] }
        best = @response[:result].map { |result| result[:best] }
        expect(hand.uniq).to include('mock_hand_type')
        expect(best).to eq([true, false, false])
        expect(@response[:error]).to be_nil
      end
    end

    context 'invalid card set is included' do
      let(:request_card_sets) { valid_card_sets << invalid_card_set }
      it 'evaluate card sets and generate response' do
        analyze_card_sets
        hand = @response[:result].map { |result| result[:hand] }
        best = @response[:result].map { |result| result[:best] }
        error = @response[:error].map { |result| result[:msg] }
        expect(hand.uniq).to include('mock_hand_type')
        expect(best).to eq([true, false, false])
        expect(error).to include('invalid card set')
      end
    end
  end

  describe 'classify_card_set' do
    context 'card set is valid' do
      let(:request_card_set) { valid_card_sets[0] }
      it 'evaluate card sets and return hand_type' do
        classify_card_set
        expect(@response[:hand_type]).to include('mock_hand_type')
      end
    end
    context 'card set is invalid' do
      let(:request_card_set) {invalid_card_set}
      it 'evaluate card sets and return error' do
        classify_card_set
        expect(@response[:error]).to include('invalid card set')
      end
    end
  end

  def analyze_card_sets
    @response = PokerHandEvaluationService.analyze_card_sets(request_card_sets)
  end

  def classify_card_set
    @response = PokerHandEvaluationService.classify_card_set(request_card_set)
  end
end
