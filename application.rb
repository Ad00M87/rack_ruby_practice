#Require all of the files inside of the app directory and it's sub directorires
files = File.expand_path('../app/**/*.rb', __FILE__)
Dir.glob(files).each { |file| require(file) }

class Application
  def call(env)
    #create an instance of Rack::Request
    request = Rack::Request.new(env)
    resolve(request)
  end

  def resolve(request)
    #Pass the request to our Router and call the route function
    Router.new(request).route
  end
end
