get '/categories' do
  @categories = Category.all
  erb :category_index
end

get '/categories/:id' do
  @category = Category.find(params[:id]) 
  @posts = @category.posts.all 
  erb :post_index
end

get '/categories/:id/posts/new' do
  erb :new
end

post '/categories/:id/posts/new' do
  @post = Post.create(name: params[:name], body: params[:body], category_id: params[:id])
  erb :user_nav

  # redirect to("/posts/#{post.id}/edit?access_key=#{post.access_key}")
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  pass unless params[:access_key] == @post.access_key 
  @post = Post.find(params[:id])
  erb :edit_delete
end

post '/posts/:id/edit' do
  post = Post.find(params[:id])
  pass unless params[:access_key] == post.access_key
  post.name = params[:name]
  post.body = params[:body]
  post.save
  redirect to("/posts/#{post.id}/edit?access_key=#{post.access_key}")
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :show
end
