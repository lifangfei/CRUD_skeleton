get '/' do
  "Hello World"
end

#index
get '/users' do
  @users = User.all
  @users.map{|user| user.email.to_s}
  # Has to do with the pathway from views
  erb :'users/index'
end

#new
get '/users/new' do
  @user = User.new
  erb :'users/new'
end

#create
post '/users' do
  @user = User.new(params[:user])
  @user.password = @user.hash_password
  @user.save
  if @user.valid?
    redirect '/users'
  else
    status 422
    @errors = @user.errors.full_messages
    erb :'users/new'
  end
end

#show
get '/users/:id' do
  @user = User.find(params[:id])
  erb :'users/show'
end

#edit
get '/users/:id/edit' do
  @user = User.find(params[:id])
  erb :'users/edit'
end

#update
def update_user
  @user = User.find(params[:id])
  @user.update(params[:user])
  if @user.valid?
    redirect "/users/#{@user.id}"
  else
    status 422
    @errors = @user.errors.full_messages
    erb :'users/edit'
  end
end

patch '/users/:id' do
  update_user
end

put '/users/:id' do
  update_user
end

#delete
delete '/users/:id' do
  User.find(params[:id]).destroy!
  redirect '/users'
end
