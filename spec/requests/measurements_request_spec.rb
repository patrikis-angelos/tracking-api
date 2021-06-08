require 'rails_helper'

RSpec.describe 'Measurements', type: :request do
  before { post '/users', params: { name: 'patrick', password: '12345' } }
  before {
    user = User.find_by(name: 'patrick')
    create_list(:measurement, 15, user: user)
  }
  let(:token){
    body = JSON.parse(response.body)
    body['token']
  }

  describe 'GET /index' do
    it 'returns all the measurements of the current user' do
      get '/measurements', headers: { 'Authorization': "Bearer #{token}"}
      body = JSON.parse(response.body)
      p body['measurements']
      expect(body['measurements'].size).to eql(15)
    end
  end
end
