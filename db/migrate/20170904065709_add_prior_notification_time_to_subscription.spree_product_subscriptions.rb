# This migration comes from spree_product_subscriptions (originally 20160426131235)
class AddPriorNotificationTimeToSubscription < ActiveRecord::Migration
  def change
    add_column :spree_subscriptions, :prior_notification_days_gap, :integer, default: 7, null: false
  end
end
