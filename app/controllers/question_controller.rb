class QuestionController < ApplicationController
  def index
  end

  def new
    @qfile = Qfile.new
  end

  def create
    @qfile = Qfile.new(qfile_params)
    @qfile.save
    render :index
  end

  private

  def qfile_params
    params.require(:qfile).permit(:src)
  end
end
