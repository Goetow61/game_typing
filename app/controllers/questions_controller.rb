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

  def play
    # CSV読み込みの部分が長くなってしまった
    require 'csv'
    require 'tempfile'
    
    @qfile = Qfile.find(params[:id])
    # テンポラリファイルを定義。S3からダウンロードして(多分)サーバー上のファイルとして開く。
    file = Tempfile.open
    data = open(@qfile.src.url).read()
    File.open(file, 'wb'){|file| file.write(data)}
    # CSVの中身を保存する配列
    question = []
    CSV.foreach(file, col_sep:"\t", liberal_parsing: true) do |row|
      question << row
    end
    # javascriptに変数を渡す
    gon.question_id = @qfile.id
    gon.question = question
    # いらないかもしれないが、テンポラリファイルを閉じて削除
    file.close
    file.unlink
  end

  private

  def qfile_params
    params.require(:qfile).permit(:title, :overview, :category, :src).merge(user_id: current_user.id)
  end

end
