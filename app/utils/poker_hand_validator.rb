module PokerHandValidator
  def self.validate_multiple_card_sets(card_sets)
    no_duplicate_card_sets?(card_sets) && card_sets.all? { |cards| validate_single_card_set(cards) }
  end

  def self.validate_single_card_set(card_set)
    cards_arr = card_set.split
    valid_card_set?(cards_arr) && no_duplicate_cards?(cards_arr)
  end

  def self.no_duplicate_card_sets?(card_sets)
    card_sets == card_sets.uniq
  end

  def self.valid_card_set?(cards_arr)
    cards_arr.length == 5
  end

  def self.no_duplicate_cards?(cards_arr)
    cards_arr == cards_arr.uniq
  end

end
