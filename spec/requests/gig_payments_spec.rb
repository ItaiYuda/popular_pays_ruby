require 'rails_helper'

RSpec.describe "GigPayments", type: :request do
  describe "PUT /set_complete" do
    before do
      @first_name = 'Walter'
      @last_name = 'White'
      @creator = Creator.create(first_name: @first_name, last_name: @last_name)

      @gig = Gig.create(brand_name: 'Hike', creator_id: @creator.id)
      @gig.update(state: 'complete')
      @gig_payment = GigPayment.create(state: 'pending', gig_id: @gig.id)
      id = @gig_payment.id
      put "/gig_payments/#{id}/set_complete"
    end

    it "returns gig payment as complete and change gig to paid" do
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]["attributes"]["state"]).to eq 'complete'

      gig = Gig.find_by(brand_name: 'Hike')
      expect(gig.state).to eq 'paid'
    end

    it "set complete and change" do
      expect(response).to have_http_status(200)
    end
  end
end
