require 'rails_helper'

RSpec.describe API::V1::PokerHandCheckerApi, type: :request do
  before do
    @path = '/api/v1/poker_hand'
    @params = {
      "cards": ['S1 S2 S3 S4 S5', 'H11 D12 S13 S8 S9']
    }
  end

  describe 'call API' do
    context 'request is valid' do
      before { stub_evaluation_service }
      it 'will return successful result' do
        call_api
        expect(response.status).to eq 200
      end
    end

    context 'request is invalid' do
      context 'request body is empty' do
        before do
          @params = {}
        end
        it 'will return error' do
          call_api
          expect(response.status).to eq 400
          expect(@json['error']).to eq('cards is missing')
        end
      end

      context 'request body is an empty array' do
        before do
          @params = { "cards": '' }
        end
        it 'will return error' do
          call_api
          expect(response.status).to eq 400
          expect(@json['error']).to eq('入力されたカード組は半角スペース区切りで、重複がないか確認してください。')
        end
      end

      context 'card sets duplicate' do
        before do
          @params = {
            "cards": ['S1 S2 S3 S4 S5', 'S1 S2 S3 S4 S5']
          }
        end
        it 'will return error' do
          call_api
          expect(response.status).to eq 400
          expect(@json['error']).to eq('入力されたカード組は半角スペース区切りで、重複がないか確認してください。')
        end
      end
    end
  end

  def call_api
    post @path, @params
    @json = JSON.parse(response.body)
  end

  def stub_evaluation_service
    allow(PokerHandEvaluationService).to receive(:analyze_card_sets).and_return(fake_response)
  end

  def fake_response
    {
      "result": [
        {
          "card": 'S1 S2 S3 S4 S5',
          "hand": 'ストレートフラッシュ',
          "best": true
        },
        {
          "card": 'H11 D12 S13 S8 S9',
          "hand": 'ハイカード',
          "best": false
        }
      ]
    }
  end
end
