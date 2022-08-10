require 'rails_helper'

RSpec.describe GigPayment, type: :model do
  context 'GigPayment model tests' do
    it 'test create gig_payment' do
      gig_payment = GigPayment.create(
        gig: Gig.create(brand_name: 'brand', creator: Creator.create(first_name: 'Walter', last_name: 'White'))
      )
      expect(gig_payment.state).to be_eql "pending"
    end

    it 'test create gig with creator' do
      creator = Creator.create(first_name: 'Walter', last_name: 'White')
      gig = Gig.create(brand_name: 'brand', creator_id: creator.id)
      gig.update(state: 'complete')
      expect(gig.state).to eq 'complete'

      gig_payment = GigPayment.create(gig_id: gig.id)
      gig_payment.set_complete
      expect(gig_payment.state).to eq 'complete'
    end
  end
end
