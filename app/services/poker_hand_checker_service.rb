class PokerHandCheckerService
  class << self
    def evaluate_card_set(card_sets)
      result = []
      error = []
      invalid_card_sets = []
      card_sets.each do |cards|
        card_arr = cards.split

        typo_index_msg = check_typo_card_index(card_arr)
        next if typo_index_msg.blank?

        invalid_card_sets << cards
        error << {
          card: cards,
          msg: typo_index_msg
        }
      end

      valid_card_sets = card_sets - invalid_card_sets
      best_hand = BestPokerHandChecker.check_best_poker_hand(valid_card_sets)
      valid_card_sets.each do |cards|
        card_arr = cards.split
        hand_type = PokerHand.new(card_arr).evaluate_hand_type
        result << {
          card: cards,
          hand: hand_type,
          best: cards == best_hand
        }
      end

      response = { result: result }
      response[:error] = error if error.present?

      response
    end

    def check_typo_card_index(card_array)
      poker_card_regex = /^([SHDC])([1-9]|1[0-3])$/
      error_msg_arr = []

      card_array.each.with_index(1) do |card, i|
        error_msg_arr.push("#{i}番目のカード指定文字が不正です。(#{card})") if card !~ poker_card_regex
      end
      error_msg_arr
    end
  end
end
