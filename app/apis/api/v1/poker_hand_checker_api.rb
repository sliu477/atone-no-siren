module API
  module V1
    class PokerHandCheckerApi < Grape::API
      resource :poker_hand do
        helpers do
          def card_set_invalid?(card_sets)
            card_sets.empty? || duplicates?(card_sets) || invalid_format?(card_sets)
          end

          def duplicates?(card_sets)
            card_sets != card_sets.uniq
          end

          def invalid_format?(card_sets)
            card_sets.any? { |c| c.split.length != 5 }
          end
        end

        desc 'check poker hand'

        params do
          requires :cards, type: Array
        end

        post '/' do
          card_sets = params[:cards]

          if card_set_invalid?(card_sets)
            response = { "error_message": '入力されたカード組は半角スペース区切りで、重複してないかをご確認ください' }
          else
            response = PokerHandCheckerService.evaluate_card_set(card_sets)
          end

          present response
        end
      end
    end
  end
end
