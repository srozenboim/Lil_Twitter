require 'spec_helper'

describe 'user CRUD routes' do
  before(:each) do
    User.create(username: 'Erich', email: 'integer@mail.com', password: '1234')
    User.create(username: 'Richard', email: 'array@mail.com', password: '1234')
    User.create(username: 'Ralph', email: 'boolean@mail.com', password: '1234')
    User.create(username: 'John', email: 'string@mail.com', password: '1234')
  end

  context 'users#index' do
    it 'renders index with the usernames' do
      get '/users'

      expect(last_response).to be_ok
      expect(last_response.body).to match 'Erich'
      expect(last_response.body).to match 'Richard'
      expect(last_response.body).to match 'Ralph'
      expect(last_response.body).to match 'John'
    end
  end
end
