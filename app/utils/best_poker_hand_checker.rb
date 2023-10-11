module BestPokerHandChecker
  HANDS_RANKING = { 'ストレートフラッシュ' => 9,
                    'フォー・オブ・ア・カインド' => 8,
                    'フルハウス' => 7,
                    'フラッシュ' => 6,
                    'ストレート' => 5,
                    'スリー・オブ・ア・カインド' => 4,
                    'ツーペア' => 3,
                    'ペア' => 2,
                    'ハイカード' => 1 }

  def self.check_best_poker_hand(card_sets)
    card_set_score = card_sets.map do |card_set|
      card_set_array = card_set.split
      hand_type = PokerHand.new(card_set_array).evaluate_hand_type
      {
        card_set: card_set,
        score: HANDS_RANKING[hand_type]
      }
    end

    highest_score_card_set = card_set_score.max_by { |hash| hash[:score] }[:card_set]
  end
end
