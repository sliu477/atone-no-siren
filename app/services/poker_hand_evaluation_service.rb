class PokerHandEvaluationService
  class << self
    include BestPokerHandChecker
    def analyze_card_sets(card_sets)
      valid_card_sets, invalid_card_sets_errors = process_card_sets(card_sets)
      best_hand = BestPokerHandChecker.check_best_poker_hand(valid_card_sets) if valid_card_sets.present?
      build_analysis_response(valid_card_sets, invalid_card_sets_errors, best_hand)
    end

    def classify_card_set(card_set)
      error_message = PokerHandValidator.validate_single_card_set(card_set)
      hand_type = PokerHand.new(card_set.split).evaluate_hand_type if error_message.blank?
      build_classification_response(error_message, hand_type)
    end

    private

    def process_card_sets(card_sets)
      valid_card_sets = []
      invalid_card_sets_errors = []

      card_sets.each do |cards|
        error_message = PokerHandValidator.validate_single_card_set(cards)

        if error_message.blank?
          valid_card_sets << cards
        else
          invalid_card_sets_errors << { card: cards, msg: error_message }
        end
      end

      [valid_card_sets, invalid_card_sets_errors]
    end

    def build_analysis_response(valid_card_sets, errors, best_hand)
      response = {}
      result = valid_card_sets.map do |cards|
        card_arr = cards.split
        hand_type = PokerHand.new(card_arr).evaluate_hand_type
        { card: cards, hand: hand_type, best: cards == best_hand }
      end

      response[:result] = result if result.present?
      response[:error] = errors if errors.present?
      response
    end

    def build_classification_response(error_message, hand_type)
      return { error: error_message } if error_message.present?

      { hand_type: hand_type }
    end
  end
end