require 'rails_helper'

RSpec.describe Gig, type: :model do
  context 'Gig model tests' do
    let(:gig) {
      Gig.create(brand_name: 'Los Pollos Hermanos')
    }
    it 'test create gig' do
      expect(gig.brand_name).to eq 'Los Pollos Hermanos'
      expect(gig.state).to eq 'applied'
    end

    it 'test create gig with creator' do
      creator = Creator.create(first_name: 'Walter', last_name: 'White')
      gig.update(creator_id: creator.id)
      expect(gig.creator_id).to eq creator.id
    end

    it 'test create gig with gig_payment' do
      creator = Creator.create(first_name: 'Gus', last_name: 'Fring')
      gig.update(creator_id: creator.id)
      gig.set_complete

      gig_payment = GigPayment.find_by(gig_id: gig.id)
      expect(gig_payment).to be_truthy
    end
  end
end
