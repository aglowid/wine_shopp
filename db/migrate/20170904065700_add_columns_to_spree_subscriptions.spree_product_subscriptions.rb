# This migration comes from spree_product_subscriptions (originally 20160302110531)
class AddColumnsToSpreeSubscriptions < ActiveRecord::Migration
  def change
    add_column :spree_subscriptions, :number, :string
    add_column :spree_subscriptions, :cancellation_reasons, :text
  end
end
