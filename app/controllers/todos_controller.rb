require_relative './base_controller.rb'

class TodosController < BaseController

  # GET/todos
  def index
    server_response todos_page("this should be a list of todos")
  end

  #GET/todos/:id
  def show
    server_response todos_page("this should show todo ##{params[:id]}")
  end

  # GET /todos/new
  def new
    server_response todos_page("a page to create a new todo")
  end

  # POST /todos
  # not implemented for now
  def create
    redirect_to "/todos"
  end

  private

  def todos_page(message)
    <<~HTML
      <html>
        <head><title>My First Rack Application</title></head>
        <body>
          <h1>This is TodosController##{params[:action]}</h1>
          <p>#{message}</p>
        </body>
      </html>
    HTML
  end
end
