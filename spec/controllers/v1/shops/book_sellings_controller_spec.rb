require 'rails_helper'
require "#{Rails.root}/app/controllers/v1/shops/base_controller"

describe V1::Shops::BookSellingsController, type: :controller do
  let(:shop) { create(:shop) }
  let(:access_token) { shop.access_token }
  let(:publisher) { create(:publisher) }
  let(:book) { create(:book, :with_balances, shops: [shop]) }
  let(:sold_amount) { 1 }
  let(:params) { { book_selling: { book_id: book.id, amount: sold_amount } } }

  describe '#create' do
    subject do
      header 'Access-Token', access_token
      post '/v1/shops/book_sellings', params
      last_response
    end

    it 'success' do
      expect(subject.status).to eq(201)
    end

    context 'not found' do
      let(:params) { { book_selling: { book_id: 'unknown_id' } } }

      it { expect(subject.status).to eq(404) }
    end

    context 'errors' do
      let(:balance) { book.book_shop_balances.first }
      let(:sold_amount) { balance.stock_count + 1 }

      it do
        expect(subject.status).to eq(422)
        expect(JSON.parse(subject.body)['errors']).to match [a_hash_including('field' => 'amount')]
      end
    end
  end
end
