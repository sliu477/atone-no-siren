class PokerHandCheckerController < ApplicationController
  include PokerHandValidator
  def index; end

  def check
    cards = params[:cards]
    flash[:cards] = cards

    result = PokerHandEvaluationService.classify_card_set(cards)
    flash.now[:error] = result[:error]&.join("\n")
    flash.now[:hand_type] = result[:hand_type]

    render :index
  end
end
