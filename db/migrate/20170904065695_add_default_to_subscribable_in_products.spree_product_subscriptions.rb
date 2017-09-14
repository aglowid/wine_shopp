# This migration comes from spree_product_subscriptions (originally 20160229151248)
class AddDefaultToSubscribableInProducts < ActiveRecord::Migration
  def up
    change_column_default :spree_products, :subscribable, false
  end

  def down
    change_column_default :spree_products, :subscribable, nil
  end
end
