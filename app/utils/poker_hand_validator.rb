module PokerHandValidator

  def self.validate_single_card_set(card_set)
    cards_arr = card_set.split
    if invalid_num_of_cards?(cards_arr)
      ["5つのカード指定文字を半角スペース区切りで入力してください。"]
    elsif duplicate_cards?(cards_arr)
      ["カードが重複しています。"]
    else
      check_typo_card_index(cards_arr)
    end
  end

  private

  def self.invalid_num_of_cards?(cards_arr)
    cards_arr.length != 5
  end

  def self.duplicate_cards?(cards_arr)
    cards_arr != cards_arr.uniq
  end

  def self.check_typo_card_index(card_arr)
    poker_card_regex = /^([SHDC])([1-9]|1[0-3])$/
    error_msg_arr = []

    card_arr.each.with_index(1) do |card, i|
      error_msg_arr.push("#{i}番目のカード指定文字が不正です。(#{card})") if card !~ poker_card_regex
    end
    error_msg_arr.blank? ? nil : error_msg_arr
  end

end
