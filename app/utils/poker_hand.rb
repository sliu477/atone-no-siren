class PokerHand
  HANDS_RANKING = { 'ストレートフラッシュ' => 9,
                    'フォー・オブ・ア・カインド' => 8,
                    'フルハウス' => 7,
                    'フラッシュ' => 6,
                    'ストレート' => 5,
                    'スリー・オブ・ア・カインド' => 4,
                    'ツーペア' => 3,
                    'ペア' => 2,
                    'ハイカード' => 1 }

  CARD_RANK_ORDER = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1]

  def initialize(cards)
    @cards = cards
  end

  def evaluate_hand_type
    if straight_flush? then 'ストレートフラッシュ'
    elsif four_of_a_kind?  then 'フォー・オブ・ア・カインド'
    elsif full_house?      then 'フルハウス'
    elsif flush?           then 'フラッシュ'
    elsif straight?        then 'ストレート'
    elsif three_of_a_kind? then 'スリー・オブ・ア・カインド'
    elsif two_pair?        then 'ツーペア'
    elsif pair?            then 'ペア'
    else 'ハイカード'
    end
  end

  private

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    suits.uniq.count == 1
  end

  def straight?
    ranking_index = ranks.map { |r| CARD_RANK_ORDER.index(r) }
    return true if ranks.max - ranks.min == 4 || ranking_index.max - ranking_index.min == 4
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    n_of_a_kind?(2) && ranks.uniq.size == 3
  end

  def pair?
    n_of_a_kind?(2)
  end

  def n_of_a_kind?(n)
    rank_counts = Hash.new(0)

    @cards.each do |card|
      rank = card[1..-1]
      rank_counts[rank] += 1
    end

    rank_counts.any? { |_rank, count| count == n }
  end

  def suits
    @cards.map { |card| card[0] }
  end

  def ranks
    @cards.map { |card| card[1..-1].to_i }
  end
end
