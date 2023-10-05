module BestPokerHandChecker
  def self.check_best_poker_hand(card_sets)
    card_set_score = card_sets.map do |card_set|
      card_set_array = card_set.split
      hand_type = PokerHand.new(card_set_array).evaluate_hand_type
      {
        card_set: card_set,
        score: PokerHand::HANDS_RANKING[hand_type]
      }
    end

    highest_score_card_set = card_set_score.max_by { |hash| hash[:score] }[:card_set]
  end
end
