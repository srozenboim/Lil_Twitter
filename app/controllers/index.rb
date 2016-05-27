get '/' do
  if current_user
    redirect "/users/#{current_user.id}/feed"
  else
    redirect '/users/new'
  end
end
