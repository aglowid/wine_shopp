# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)


Spree::SubscriptionFrequency.create(title: "monthly", months_count: 1)
Spree::SubscriptionFrequency.create(title: "quarterly", months_count: 3)
Spree::SubscriptionFrequency.create(title: "half yearly", months_count: 6)
Spree::SubscriptionFrequency.create(title: "yearly", months_count: 12)
