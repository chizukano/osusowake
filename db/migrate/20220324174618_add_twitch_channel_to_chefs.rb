class AddTwitchChannelToChefs < ActiveRecord::Migration[6.1]
  def change
    add_column :chefs, :twitch_channel, :string
  end
end
