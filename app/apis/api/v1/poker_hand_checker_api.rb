module API
  module V1
    class PokerHandCheckerApi < Grape::API
      include PokerHandValidator

      resource :poker_hand do
        helpers do
          def params_invalid?
            params[:cards].blank? || card_sets_duplicate?
          end

          def card_sets_duplicate?
            params[:cards] != params[:cards].uniq
          end
        end

        desc 'check poker hand'

        params do
          requires :cards, type: Array
        end

        post '/' do

          if params_invalid?
            response = { "error": '入力されたカード組は半角スペース区切りで、重複がないか確認してください。' }
            status 400
          else
            response = PokerHandEvaluationService.analyze_card_sets(params[:cards])
            status 200
          end

          present response
        end
      end
    end
  end
end
