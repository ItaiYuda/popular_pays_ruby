require 'rails_helper'

RSpec.describe "Gigs", type: :request do
  describe "GET /gigs" do
    before do
      @creator = Creator.create(first_name: 'Walter', last_name: 'White')
      @gig = Gig.create(brand_name: 'Hike', creator: @creator)
      @gig_2 = Gig.create(brand_name: 'Bike', creator: @creator)
      get gigs_path
    end

    it 'returns all gigs' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"][0]["attributes"]["brand_name"]).to be_eql @gig.brand_name
      expect(parsed_body["data"][1]["attributes"]["brand_name"]).to be_eql @gig_2.brand_name
    end

    it 'returns status code 200' do

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /gigs/:id' do
    before do
      @creator = Creator.create(first_name: 'Walter', last_name: 'White')
      @gig = Gig.create(brand_name: 'Hike', creator: @creator)

      get "#{gigs_path}/#{@gig.id}"
    end

    it 'returns gig' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"]["attributes"]["brand_name"]).to be_eql @gig.brand_name
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /creators' do
    before do
      @first_name = 'Walter'
      @last_name = 'White'
      @creator = Creator.create(first_name: @first_name, last_name: @last_name)
      @brand_name = 'Hike'
      post gigs_path, params:
        { gig: {
          brand_name: @brand_name,
          creator_id: @creator.id
        } }
    end

    it 'create new creator' do
      gig = Gig.find_by(brand_name: @brand_name)
      expect(gig.brand_name).to be_eql @brand_name
      expect(gig.state).to be_eql 'applied'
      expect(gig.creator_id).to be_eql @creator.id
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /gigs' do
    before do
      @first_name = 'Walter'
      @last_name = 'White'
      @creator = Creator.create(first_name: @first_name, last_name: @last_name)

      @gig = Gig.create(brand_name: 'Hike', creator_id: @creator.id)
      @brand_name = 'Smaike'
      put "#{gigs_path}/#{@gig.id}", params:
        { gig: {
          brand_name: @brand_name,
        } }
    end

    it 'returns gig' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"]["attributes"]["brand_name"]).to be_eql @brand_name
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /set_complete' do
    before do
      @first_name = 'Walter'
      @last_name = 'White'
      @creator = Creator.create(first_name: @first_name, last_name: @last_name)

      @gig = Gig.create(brand_name: 'Hike', creator_id: @creator.id)
      @gig.update(state: 'complete')
      put "/gigs/#{@gig.id}/set_complete"
    end

    it 'returns gig' do
      gig_payment = GigPayment.find_by(gig_id: @gig.id)

      expect(gig_payment.state).to eq 'pending'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'PUT /set_complete - Error' do
  #   before do
  #     @first_name = 'Walter'
  #     @last_name = 'White'
  #     @creator = Creator.create(first_name: @first_name, last_name: @last_name)
  #
  #     @gig = Gig.create(brand_name: 'Hike', creator_id: @creator.id)
  #     @gig.update(state: 'paid')
  #     id = @gig.id
  #     put "/gigs/#{id}/set_complete"
  #   end
  #
  #   it 'returns gig' do
  #     expect { response.status }.to eq 400
  #   end
  #
  #   it 'returns status code 200' do
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
