require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before { post '/users', params: { name: 'example', password: '12345' } }
  describe 'POST /users' do
    it 'creates a new user' do
      post '/users', params: { name: 'patrick', password: '12345' }
      user = User.last
      expect(user.name).to eql('patrick')
    end
    it 'returns error message if the name or password is invalid' do
      post '/users', params: { name: 'bob', password: '' }
      body = JSON.parse(response.body)
      expect(body['error']).to eql('Invalid username or password')
    end
    it 'return error message if the username is taken' do
      post '/users', params: { name: 'example', password: '12345' }
      body = JSON.parse(response.body)
      expect(body['error']).to eql('Invalid username or password')
    end
  end

  describe 'POST /login' do
    it 'logins the user' do
      post '/login', params: { name: 'example', password: '12345' }
      body = JSON.parse(response.body)
      expect(body['user']['name']).to eql('example')
    end
    it 'return error message if wrong username or password is given' do
      post '/login', params: { name: 'wrongName', password: '12345' }
      body = JSON.parse(response.body)
      expect(body['error']).to eql('Invalid username or password')
    end
  end

  describe 'DELETE /logout' do
    it 'deletes the user id from the cookies hash' do
      body = JSON.parse(response.body)
      token = body['token']
      delete '/logout', headers: { Authorization: "Bearer #{token}" }
      expect(cookies[:user_id]).to be_empty
    end
  end

  describe 'GET /auto_login' do
    it 'return the user token if the user is logged in' do
      get '/auto_login'
      body = JSON.parse(response.body)
      token = body['token']
      expect(token).to_not be_empty
    end
    it 'return error message if th euser is not logged in' do
      body = JSON.parse(response.body)
      token = body['token']
      delete '/logout', headers: { Authorization: "Bearer #{token}" }
      get '/auto_login'
      body = JSON.parse(response.body)
      expect(body['error']).to eql('User not logged in')
    end
  end
end
