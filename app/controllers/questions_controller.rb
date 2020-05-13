class QuestionsController < ApplicationController
  def index
    default_user_id = User.where(email: ENV['GMAIL_ADDRESS']).select(:id).ids[0]
    @aggregates = Qfile.left_outer_joins(:results).where(user_id: default_user_id).select("qfiles.id, qfiles.title, qfiles.results_count, COUNT(distinct results.user_id) AS count_distinct_results_user_id").group("qfiles.id, qfiles.category, results_count").order("qfiles.id ASC")
    @qfiles_words = Qfile.where(category: 0, user_id: default_user_id).order(:id)
    @qfiles_sentences = Qfile.where(category: 1, user_id: default_user_id).order(:id)
    @qfiles = Qfile.where.not(user_id: default_user_id).order(id: 'DESC').includes(:user)
  end

  def new
    @qfile = Qfile.new
  end

  def create
    @qfile = Qfile.new(qfile_params)
    binding.pry
    if @qfile.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    qfile = Qfile.find(params[:id])
    if qfile.destroy!
      flash[:notice] = "問題を削除しました。"
    else
      flash[:alert] = "問題を削除できませんでした。"
    end
    redirect_to root_path
  end

  def show
    @default_user_id = User.where(email: ENV['GMAIL_ADDRESS']).select(:id).ids[0]
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
    gon.question = question
    # いらないかもしれないが、テンポラリファイルを閉じて削除
    file.close
    file.unlink
  end

  def result
    # 非ログイン状態で保持していたタイピング結果を破棄
    session[:result] = nil

    @result = Result.new(result_params)
    if user_signed_in?
      respond_to do |format|
        if @result.save
          format.json
        else
          format.json {render :play}
        end
      end
    else
      # ログインしていなかった場合に一時的にタイピング結果をcookieに保存
      session[:result] = @result
    end
  end

  private

  def qfile_params
    params.require(:qfile).permit(:title, :overview, :category, :src).merge(user_id: current_user.id)
  end

  def result_params
    if user_signed_in?
      params.require(:question).permit(:correct_cnt, :wrong_cnt, :elapsed_time, :speed).merge(user_id: current_user.id, qfile_id: params[:id])
    else
      params.require(:question).permit(:correct_cnt, :wrong_cnt, :elapsed_time, :speed).merge(qfile_id: params[:id])
    end
  end

end
