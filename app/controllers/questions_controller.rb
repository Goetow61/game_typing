class QuestionsController < ApplicationController
  def index
  end

  def new
    @qfile = Qfile.new
  end

  def create
    # Qfile.create(qfile_params)
    @qfile = Qfile.new(qfile_params)
    # binding.pry
    if @qfile.save!
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def qfile_params
    params.require(:qfile).permit(:title, :overview, :category, :src).merge(user_id: current_user.id)
  end
end
