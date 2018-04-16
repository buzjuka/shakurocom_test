require 'rails_helper'

describe BookSellingForm, type: :model do
  let(:shop) { create(:shop) }
  let(:book) { create(:book, :with_balances, shops: [shop]) }
  let(:balance) { book.book_shop_balances.first }

  describe '#submit' do
    let(:params) { { amount: 1 } }
    let!(:previous_stock) { balance.stock_count }
    let(:last_transaction) { balance.balance_transactions.last }

    subject { described_class.new(book.id, shop.id).submit(params) }

    it 'success' do
      expect(subject).to be true
      expect(balance.reload.attributes).to match(
        a_hash_including('stock_count' => previous_stock - params[:amount], 'sold_count' => params[:amount])
      )
      expect(last_transaction.attributes).to match(
        a_hash_including('amount' => params[:amount], 'transaction_type' => 'sale')
      )
    end

    context 'error' do
      let(:params) { { amount: -1 } }

      it do
        expect(subject).to be false
        expect(balance.reload.attributes).to match(
          a_hash_including('stock_count' => previous_stock, 'sold_count' => 0)
        )
        expect(last_transaction.transaction_type).to eq('supply')
      end
    end
  end
end
