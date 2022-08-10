require 'rails_helper'

RSpec.describe Creator, type: :model do
  context 'Creator model tests' do
    let(:creator) {
      Creator.create(first_name: 'Walter', last_name: 'White')
    }
    it 'test create creator' do
      expect(creator.first_name).to eq 'Walter'
      expect(creator.last_name).to eq 'White'
    end

    it 'test create creator with gig' do
      gig = Gig.create(brand_name: 'los polles harmenos', creator_id: creator.id)
      expect(creator.id).to eq gig.creator_id
    end

    it 'test create creator with 3 gigs' do
      gig = Gig.create(brand_name: 'los polles harmenos', creator_id: creator.id)
      gig = Gig.create(brand_name: 'Adidog', creator_id: creator.id)
      gig = Gig.create(brand_name: 'Mike', creator_id: creator.id)
      expect(creator.gigs.length).to be 3
    end
  end

end
