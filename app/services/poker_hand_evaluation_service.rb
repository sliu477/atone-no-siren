class PokerHandEvaluationService
  class << self
    include PokerHandValidator

    def analyze_card_sets(card_sets)
      valid_card_sets, invalid_card_sets_errors = process_card_sets(card_sets)
      best_hand = BestPokerHandChecker.check_best_poker_hand(valid_card_sets)
      generate_response(valid_card_sets, invalid_card_sets_errors, best_hand)
    end

    def classify_card_set(card_set)
      card_arr = card_set.split
      check_typo_card_index(card_arr) || PokerHand.new(card_arr).evaluate_hand_type
    end

    private

    def process_card_sets(card_sets)
      valid_card_sets = []
      invalid_card_sets_errors = []

      card_sets.each do |cards|
        card_arr = cards.split
        typo_index_msg = check_typo_card_index(card_arr)
        if typo_index_msg.blank?
          valid_card_sets << cards
        else
          invalid_card_sets_errors << { card: cards, msg: typo_index_msg }
        end
      end

      [valid_card_sets, invalid_card_sets_errors]
    end

    def generate_response(valid_card_sets, errors, best_hand)
      result = valid_card_sets.map do |cards|
        card_arr = cards.split
        hand_type = PokerHand.new(card_arr).evaluate_hand_type
        { card: cards, hand: hand_type, best: cards == best_hand }
      end

      response = { result: result }
      response[:error] = errors if errors.present?
      response
    end

    def check_typo_card_index(card_array)
      poker_card_regex = /^([SHDC])([1-9]|1[0-3])$/
      error_msg_arr = []

      card_array.each.with_index(1) do |card, i|
        error_msg_arr.push("#{i}番目のカード指定文字が不正です。(#{card})") if card !~ poker_card_regex
      end
      error_msg_arr.blank? ? nil : error_msg_arr
    end
  end
end
