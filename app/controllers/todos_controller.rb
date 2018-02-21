require_relative './base_controller.rb'

class TodosController < BaseController

  # GET /todos
  def index
    @title = "Todos"
    @todos = Todo.all
    server_response render_template
  end

  # GET /todos/:id
  def show
    @todo = Todo.find(params[:id])
    @title = "#{@todo.name}'s page"
    server_response render_template
  end

  # GET /todos/new
  def new
    @title = "Add a todo item"
    server_response render_template
  end

  # POST /todos
  def create
    todo = Todo.new(name: params['todo']['name'])
    todo.save
    redirect_to "todos/#{todo.id}"
  end

  private

  def todos
    [
      { id: 1, name: 'Learn Ruby' },
      { id: 2, name: 'Build a server' },
      { id: 3, name: 'Profit' }
    ]
  end
end
