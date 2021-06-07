require 'rails_helper'
require_relative '../support/factories'

RSpec.describe 'Units', type: :request do
  before { create_list(:unit, 10) }

  describe 'GET /units' do
    before { response = get '/units' }
    it 'returns a list with all available units to track' do
      json = JSON.parse(response.body)
      expect(json).to_not be_empty
      expect(json.size).to eql(10)
    end
  end
end
