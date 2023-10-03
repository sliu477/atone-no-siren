module API
  module V1
    class PokerHandCheckerApi < Grape::API
      include PokerHandValidator

      resource :poker_hand do
        helpers do
          def params_invalid?(card_sets)
            !PokerHandValidator.validate_multiple_card_sets(card_sets)
          end
        end

        desc 'check poker hand'

        params do
          requires :cards, type: Array
        end

        post '/' do
          card_sets = params[:cards].map(&:upcase)

          if params_invalid?(card_sets)
            response = { "error": '入力されたカード組は半角スペース区切りで、重複がないか確認してください。' }
          else
            response = PokerHandEvaluationService.analyze_card_sets(card_sets)
          end

          present response
        end
      end
    end
  end
end
