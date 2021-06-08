require 'rails_helper'
require_relative '../support/factories'

RSpec.describe 'Units', type: :request do
  before { create_list(:unit, 10) }
  before { post '/users', params: { name: 'patrick', password: '12345' } }

  describe 'GET /units' do
    it 'returns a list with all available units to track if a user is logged in' do
      body = JSON.parse(response.body)
      token = body['token']
      get '/units', headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(json).to_not be_empty
      expect(json.size).to eql(10)
    end
    it 'return an error message if the user in not logged in or anuthorized' do
      get '/units'
      json = JSON.parse(response.body)
      expect(json['message']).to eql('Please log in')
    end
  end
end
