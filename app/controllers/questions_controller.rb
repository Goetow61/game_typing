class QuestionsController < ApplicationController
  def index
  end

  def new
    @qfile = Qfile.new
  end

  def create
    @qfile = Qfile.new(qfile_params)
    if @qfile.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @qfile = Qfile.find(params[:id]) 
  end

  private

  def qfile_params
    params.require(:qfile).permit(:title, :overview, :category, :src).merge(user_id: current_user.id)
  end
end
