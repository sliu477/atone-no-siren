module PokerHandValidator
  include RegularExpressionDefinition
  def self.validate_single_card_set(cards_arr)
    error_messages = []

    error_messages << invalid_num_of_cards_error(cards_arr)
    error_messages << duplicate_cards_error(cards_arr)
    error_messages << typo_card_error(cards_arr)

    error_messages.compact
  end

  def self.invalid_num_of_cards_error(cards_arr)
    '5つのカード指定文字を半角スペース区切りで入力してください。' if cards_arr.length != 5
  end

  def self.duplicate_cards_error(cards_arr)
    duplicate_cards = cards_arr.find_all { |e| cards_arr.count(e) > 1 }.uniq
    "カードが重複しています。(#{duplicate_cards.join(' ')})" if duplicate_cards.any?
  end

  def self.typo_card_error(cards_arr)
    error_indices = []
    error_cards = []
    cards_arr.each.with_index(1) do |card, i|
      if card !~ POKER_CARD_REGEX
        error_indices << i
        error_cards << card
      end
    end

    return if error_indices.blank?

    case error_indices.size
    when 1
      "#{error_indices[0]}番目のカード指定文字が不正です。(#{error_cards.join(' ')})"
    when 2
      "#{error_indices[0]}番目と#{error_indices[1]}番目のカード指定文字が不正です。(#{error_cards.join(' ')})"
    else
      "#{error_indices[0..-2].join('番目、')}#{error_indices[-1]}番目のカード指定文字が不正です。(#{error_cards.join(' ')})"
    end
  end
end
