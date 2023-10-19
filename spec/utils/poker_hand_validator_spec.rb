require 'rails_helper'

RSpec.describe PokerHandValidator, type: :module do
  let(:valid_card_set) { 'S1 S2 S3 S4 S5' }
  let(:wrong_card_num) { 'S1 S2 S3' }
  let(:repeated_cards) { 'S1 S1 S3 S4 S5' }
  let(:incorrect_pattern) { 'S100 S1 S3 S4 S5' }

  describe 'validate single card set' do
    context 'card set is valid' do
      let(:card_set) { valid_card_set }
      it 'return nil' do
        validate_card_set
        expect(@response).to be nil
      end
    end
    context 'card set is invalid' do
      context 'card set does not have 5 cards' do
        let(:card_set) { wrong_card_num }
        it 'return invalid number of cards error message' do
          validate_card_set
          expect(@response).to eq ['5つのカード指定文字を半角スペース区切りで入力してください。']
        end
      end
      context 'card set has duplicate cards' do
        let(:card_set) { repeated_cards }
        it 'return duplicate cards error message' do
          validate_card_set
          expect(@response).to eq ['カードが重複しています。']
        end
      end
      context 'card set has incorrect card' do
        let(:card_set) { incorrect_pattern }
        it 'return error message typo index' do
          validate_card_set
          expect(@response).to eq ['1番目のカード指定文字が不正です。(S100)']
        end
      end
    end
  end

  def validate_card_set
    @response = PokerHandValidator.validate_single_card_set(card_set)
  end
end
