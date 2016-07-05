get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
   # Deja a los usuarios crear una URL reducida y despliega una lista de URLs. 
  erb :index
end

get '/correcto' do
  @message = session[:message] #inicializa la session
  @url_all = Url.all
  p @url_all
  erb :new_url
end


post '/principal' do
  @new_url = params[:user_input] #cacha el parametro del name='user_input' 
  @validar = Url.new(url_anterior: @new_url, click_count: 0)
  # @validar.save

  if @validar.save
    session[:message] = "El registro fue salvado" 
  else
    session[:message] = "error el registro no se salvo" 
  end


  redirect to ('/correcto')
end

# e.g., /q6bda
get '/:short_url' do
  # redirige a la URL original
 # @url_visitated
 user_input = params[:short_url]
 u = Url.find_by(url_nueva: user_input)
 u.update(click_count: u.click_count + 1) #actializa si ya fue requerido
 redirect to u.url_anterior
 
end