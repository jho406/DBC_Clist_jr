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
  @category = Category.find(params[:id])
  erb :new
end

post '/categories/:id/posts/new' do
  @post = Post.create(name: params[:name], body: params[:body], category_id: params[:id])
  erb :user_nav
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  pass unless params[:access_key] == @post.access_key 
  @post = Post.find(params[:id])
  erb :edit_delete
end

post '/posts/:id/edit' do
  @post = Post.find(params[:id])
  pass unless params[:access_key] == @post.access_key
  if params[:submit] == "Submit Changes"
    @post.name = params[:name]
    @post.body = params[:body]
    @post.save
  erb :user_nav
  elsif params[:submit] == "Delete Post"
    Post.delete(@post.id)
  erb :post_deleted
  end
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :post_info
end
