# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Creator.destroy_all
Gig.destroy_all
GigPayment.destroy_all

gig_payment_1 = GigPayment.create(state: 'pending')
gig_payment_2 = GigPayment.create(state: 'pending')

gig_1 = Gig.create(brand_name: 'Nike', state: 'applied', gig_payment: gig_payment_1)
gig_2 = Gig.create(brand_name: 'Los Dos Pollos',state: 'applied', gig_payment: gig_payment_2)

creator_1 = Creator.create(first_name: 'Itamar', last_name: 'Galili', gigs: [gig_1, gig_2])
creator_2 = Creator.create(first_name: 'Walter', last_name: 'White')

