require 'rails_helper'

describe V1::Publishers::ShopsController, type: :controller do
  let(:publisher) { create(:publisher) }
  let(:access_token) { publisher.access_token }

  describe '#index' do
    subject do
      header 'Access-Token', access_token
      get '/v1/publishers/shops'
      last_response
    end

    it 'ok' do
      expect(subject.status).to eq(200)
    end

    context 'unauthorized' do
      let(:access_token) { SecureRandom.hex }

      it { expect(subject.status).to eq(401) }
    end
  end
end
