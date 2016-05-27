require 'spec_helper'

describe 'user CRUD routes' do
  before(:each) do
    User.create(username: 'Erich', email: 'integer@mail.com', password: '1234')
    User.create(username: 'Richard', email: 'array@mail.com', password: '1234')
    User.create(username: 'Ralph', email: 'boolean@mail.com', password: '1234')
    User.create(username: 'John', email: 'string@mail.com', password: '1234')
  end

  context 'users#new' do
    it 'renders the index view' do
      get '/users/new'
      expect(last_response).to be_ok
      expect(last_response.body).to match 'Create an account'
    end
  end

  context 'users#create' do
    it 'creates a new user' do
      params = { user: { username: 'Name', email: 'someone@mail.com' },
                 password: '1234' }
      expect { post '/users', params }.to change(User.all, :size).by(1)
    end

    xit 'redirects to new if incorrect params' do
      # As of now, this never fails
      params = { user: { username: 'Name', email: 'someone@mail.com' }}

      post '/users', params

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to match 'Create an account'
    end
  end

  context 'logging in' do
    let(:params) { { email: 'john@gmail.com', password: '12345' } }
    before(:each) do
      @user = User.new(username: 'John Doe', email: 'john@gmail.com')
      @user.password = '12345'
      @user.save
    end

    it 'renders the login page' do
      get '/users/new'
      expect(last_response.body).to match 'Login'
    end

    it 'redirects to root if successful' do
      post '/users/login', params
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to match @user.username
    end

  end
end
