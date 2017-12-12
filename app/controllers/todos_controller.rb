class TodosController < ApplicationController
  before_action :todo_find, :only => [:show, :edit, :update, :destroy]
  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      flash[:notice] = 'List was successfully created!!'
      redirect_to todos_url
    else
      render :action => :new
    end
  end

  def update
    if @todo.update_attributes(todo_params)
      redirect_to todo_path(@todo)
    else
      render :action => :edit
    end
  end

  # 過了due date，就不能刪除
  # can_destroy method 寫在 models/todo.rb 裡
  def destroy
    if @todo.can_destroy?
      @todo.destroy
      flash[:alert] = 'List was successfully deleted!!'
      redirect_to todos_path
    else
      flash[:alert] = 'List was overdue, cannot be deleted!!'
      redirect_to todos_path
    end
  end

  private
  def todo_params
    params.require(:todo).permit(:title, :due_date, :note)
  end

  def todo_find
    @todo = Todo.find(params[:id])
  end

end
