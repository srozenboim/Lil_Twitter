#new user form
get '/users/new' do
	erb :index
end

def create
  @user = User.new(params[:user])
  @user.password = params[:password]
  @user.save!
end

#authenticates a user for login
def login
  @user = User.find_by_email(params[:email])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    session[:visit] = 0
    redirect "users/#{@user.id}/feed"
  else
    redirect '/'
  end
end

post '/users/login' do
  login
end

post '/users' do
  if create
    session[:user_id] = @user.id
    session[:visit] = 0
    redirect "users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end

#get edit page
get '/users/:id/edit' do
	@user = User.find(params[:id])
	erb :'/users/user_edit'
end

#show a user
get '/users/:id' do
	@user = User.find(params[:id])
end

#submit user edit
put '/users/:id' do
	user = User.find(params[:id])
	user.username = params[:username]
	user.email = params[:email]
	if user.save
		redirect '/'
	else
		# flash[:errors] = user.errors.full_messages
		redirect "/users/#{current_user.id}/edit"
	end
end

#delete user
delete '/users/:id' do
	User.find(params[:id]).destroy
	session[:id] = nil
	current_user = nil
end


