#get edit page
# #show all users
# get '/posts' do
#   @posts = Post.all
#   erb :'posts/index'
# end

# #new post form
# get '/posts/new' do
#   if logged_in
#     erb :'posts/new'
#   else
#     redirect '/posts'
#   end
# end

#create new post
post '/posts' do
  redirect '/sessions/new' if session[:id].nil?
  @new_post = Post.new(body: params[:body], user_id: params[:user_id])
  if @new_post.save
    redirect "/users/#{params[:user_id]}/feed"
  else
    redirect "/users/#{params[:user_id]}/feed"
  end
end


# get edit page
get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  if allow_edit(@post)
    erb :'/posts/edit'
  else
    redirect "/posts/#{params[:id]}"
  end
end

#show a post
get '/posts/:id' do
  @post = Post.find(params[:id])
  @post.update(body: params[:body])
  redirect "posts/#{@post.id}"
end

# submit post edit
put '/posts/:id' do
  @post = Post.find(params[:id])
  @post.update(body: params[:body], title: params[:title])
  redirect "posts/#{@post.id}"
end

#delete post from feed
delete '/posts/:id/feed' do
  @post = Post.find(params[:id])
  if allow_edit(@post)
    @post.destroy
    redirect "/users/#{current_user.id}/feed"
  else
    redirect "/users/#{current_user.id}/feed"
  end
end

#delete post from profile
delete '/posts/:id/profile' do
  @post = Post.find(params[:id])
  if allow_edit(@post)
    @post.destroy
    redirect "/users/#{current_user.id}"
  else
    redirect "/users/#{current_user.id}"
  end
end
