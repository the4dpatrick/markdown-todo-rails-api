class TodosController < ApplicationController
  before_action :authorize
  before_action :set_list
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    @todos = @list.todos.paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html
      format.json { render json: @list }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /todos/new
  def new
    @todo = @list.todos.new

    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = @list.todos.build(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to [@list, @todo], notice: 'Todo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @list }
      else
        format.html { render action: 'new' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to [@list, @todo], notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to list_todos_url(@list) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

  def set_list
    @list = List.find(params[:list_id])
  end
  def set_todo
      @todo = @list.todos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:item, :completed_at)
    end
end
