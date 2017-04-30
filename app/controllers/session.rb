get '/session-viewer' do
  session.inspect
end

get '/sessions/new' do
  erb :"sessions/new"
end

post '/sessions' do
  @user = User.authenticate(params[:email], params[:password])
  if @user
    login(@user)
    redirect "/users/#{@user.id}"
  else
    erb :"sessions/new"
  end
end

delete '/sessions' do
  logout
  redirect '/sessions/new'
end
