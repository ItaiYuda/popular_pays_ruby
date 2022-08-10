require 'rails_helper'

RSpec.describe "Creators", type: :request do
  describe 'GET /creators/:id' do
    before do
      @creator = Creator.create(first_name: 'Walter', last_name: 'White')
      get "/creators/#{@creator.id}"
    end

    it 'returns all creators' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"]["attributes"]["first_name"]).to be_eql @creator.first_name
      expect(parsed_body["data"]["attributes"]["last_name"]).to be_eql @creator.last_name
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /creators' do
    before do
      @creator = Creator.create(first_name: 'Walter', last_name: 'White')
      @creator_1 = Creator.create(first_name: 'Mike', last_name: 'Ehrmantraut')
      get '/creators'
    end

    it 'returns all creators' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"][0]["attributes"]["first_name"]).to be_eql @creator.first_name
      expect(parsed_body["data"][1]["attributes"]["first_name"]).to be_eql @creator_1.first_name
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /creators' do
    before do
      @first_name = 'Walter'
      @last_name = 'White'
      post '/creators', params:
        { creator: {
          first_name: @first_name,
          last_name: @last_name
        } }
    end

    it 'create new creator' do
      creator = Creator.find_by(first_name: @first_name)
      expect(creator.first_name).to be_eql @first_name
      expect(creator.last_name).to be_eql @last_name
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(:created)
    end

  end

  describe 'PUT /creators' do
    before do
      @creator = Creator.create(first_name: 'Walter', last_name: 'White')
      @new_first_name = 'Gas'
      put "/creators/#{@creator.id}", params:
        { creator: {
          first_name: @new_first_name
        } }
    end

    it 'returns all creators' do
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["data"]["attributes"]["first_name"]).to be_eql @new_first_name
      expect(parsed_body["data"]["attributes"]["last_name"]).to be_eql @creator.last_name
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
