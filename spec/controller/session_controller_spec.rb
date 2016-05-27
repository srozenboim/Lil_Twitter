require 'spec_helper'

describe 'sessions controller' do
  context 'registering a new user' do
    let(:params) {
      {
        username: 'John Doe',
        email: 'john@gmail.com',
        password: '12345',
        password_confirmation: '12345'
      }
    }
    it 'renders register view' do
      get '/register'
      expect(last_response).to be_ok
      expect(last_response.body).to match 'Registration'
    end

    it 'creates a new user' do
      expect{
        post '/register', params
      }.to change(User.all, :size).by(1)
    end

    it 'redirects to the login page' do
      post '/register', params

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response).to be_ok
      expect(last_response.body).to match 'Login'
    end
  end

  context 'logging in' do
    let(:params) { { email: 'john@gmail.com', password: '12345' } }
    before(:each) do
      user = User.new(username: 'John Doe', email: 'john@gmail.com')
      user.password = '12345'
      user.save
    end

    it 'renders the login page' do
      get '/login'
      expect(last_response.body).to match 'Login'
    end

    it 'redirects to root if successful' do
      post '/login', params
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to match 'Write about Broccoli'
    end

  end
end
