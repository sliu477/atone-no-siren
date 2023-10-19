require 'rails_helper'

RSpec.describe PokerHandCheckerController, type: :controller do
  describe 'get #index' do
    it 'render index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'post #check' do
    context 'with valid input' do
      it 'assign flash message hand_type and render index template' do
        post :check, { cards: 'C2 D3 H4 S5 C6' }
        expect(flash[:cards]).to eq('C2 D3 H4 S5 C6')
        expect(flash.now[:hand_type]).to be_present
        expect(flash.now[:error]).to be_nil
        expect(response).to render_template :index
      end
    end
    context 'with invalid input' do
      it 'assign flash message error and render index template' do
        post :check, { cards: 'Invalid Input' }
        expect(flash[:cards]).to eq('Invalid Input')
        expect(flash.now[:hand_type]).to be_nil
        expect(flash.now[:error]).to be_present
        expect(response).to render_template :index
      end
    end
  end
end
