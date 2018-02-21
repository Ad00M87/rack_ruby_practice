require './application'

use Rack::Reloader, 0 #Reloads server if a file changes
run Application.new
