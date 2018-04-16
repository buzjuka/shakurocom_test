class AddAccessTokenToPublisher < ActiveRecord::Migration[5.0]
  def change
    add_column :publishers, :access_token, :uuid, default: 'uuid_generate_v4()', null: false, index: true
  end
end
