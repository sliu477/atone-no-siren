class PokerHandCheckerController < ApplicationController
  include PokerHandValidator
  def index; end

  def check
    cards = params[:cards]
    flash[:cards] = cards

    if !PokerHandValidator.validate_single_card_set(cards)
      message = "五つのカード指定文字を半⾓スペース区切りで入力してください（例：'S3 H4 H5 D6 C7'）"
    else
      message = PokerHandEvaluationService.classify_card_set(cards)
    end

    flash[:message] = message.is_a?(Array) ? message.join("\n") : message

    redirect_to "/poker_checker"
  end
end
